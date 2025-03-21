import 'dart:io';
import 'dart:math';

// 먼저 캐릭터의 클래스를 정의한다.
class Character {
  String name;
  int health;
  int attack;
  int defense;

  Character(this.name, this.health, this.attack, this.defense);

  void attacMonster(Monster monster) {
    int damage = attack;
    monster.health -= damage;
    if ( monster.health < 0) {monster.health = 0};
    print('$name이(가) ${monster.name}에게 $damage의 피해를 입혔습니다!');
  }

  void defend() {
    print('$name이(가) 방어에 성공하였습니다.')
  }

  void showStatus() {
    print('[$name] 체력 : $health, 공격력 : $attack, 방어력 : $defense');
  }
}

//monster 클래스 정의
class Monster {
  String name;
  int health;
  int attack;
  int maxAttack;

  Monster(this.name, this.health, this.maxAttack)


  void attackCharacter(Character character) {
    int damage = attack - character.defense;
    if (damage < 0) {damage = 0};
    character.health -= damage;
    if (character.health < 0) character.health = 0;
    priint('$name이(가) ${character.name}에게 $damage의 피해를 입혔습니다!');
  }

  void showStatus() {
    print('[$name] 체력: $health, 공격력: $attack');
  }
}

// 게임 클래스 정의
class Game {
  late Character character;
  List<Monster> monsters = [];
  int defeatedCount = 0;

  void startGame() {
    loadCharacter();
    loadMonsters();
    print('게임을 시작합니다!\n');

    while (character.health > 0 && monsters.isNotEmpty) {
      print('\n현재 상태:');
      character.showStatus();

      Monster monster = getRandomMonster();
      print('\n새로운 몬스터가 나타났습니다!');
      monster.showStatus();

      battle(monster);

      if (character.health <= 0) {
        print('\n${character.name}이(가) 쓰러졌습니다. 게임 오버!');
        break;
      }

      defeatedCount++;
      print('현재까지 물리친 몬스터 수: $defeatedCount');

      if (defeatedCount >= 3) {
        print('\n모든 몬스터를 물리쳤습니다! 게임 승리!');
        break;
      }

      stdout.write('\n다음 몬스터와 싸우시겠습니까? (y/n): ');
      String? input = stdin.readLineSync();
      if (input?.toLowerCase() != 'y') {
        print('\n게임을 종료합니다.');
        break;
      }
    }
  }

void battle(Monster monster) {
  while (character.health > 0 && monster.health > 0) {
    print('\n--- 전투 시작 ---');
    character.showStatus();
    monster.showStatus();

    stdout.write('\n행동을 선택하세요 (1: 공격하기, 2: 방어하기): ');
    String? input = stdin.readLineSync();

    if (input == '1') {
      character.attackMonster(monster);
    } else if (input == '2') {
      character.defend();
    } else {
      print('잘못된 입력입니다. 공격으로 진행합니다.');
      character.attackMonster(monster);
    }

    if (monster.health > 0) {
      monster.attackCharacter(character);
    }
  }

  if (monster.health <= 0) {
    print('\n${monster.name}을(를) 물리쳤습니다!');
    monsters.remove(monster);
  }

  if (character.health <= 0) {
    print('\n${character.name}이(가) 쓰러졌습니다');
  }
}

  Monster getRandomMonster() {
    return monsters[Random().nextInt(monsters.length)];
  }
}

void loadCharacter() {
  try {
    final file = File('characters.txt');
    final contents = file.readAsStringSync().trim();
    final stats = contents.split(',');

    if (stats.length != 3) throw FormatException('캐릭터 데이터 형식이 잘못됨');

    int health = int.parse(stats[0]);
    int attack = int.parse(stats[1]);
    int defense = int.parse(stats[2]);

    String name = getCharacterName();

    character = Character(name, health, attack, defense);
    print('\n캐릭터가 생성되었습니다!');
    character.showStatus();
  } catch (e) {
    print('캐릭터 데이터를 불러오는 데 실패했습니다: $e');
    exit(1);
  }
}

String getCharacterName() {
  while (true) {
    stdout.write('캐릭터 이름을 입력하세요 (한글/영문만 허용): ');
    String? name = stdin.readLineSync();

    if (name != null && name.isNotEmpty && RegExp(r'^[a-zA-Z가-힣]+$').hasMatch(name)) {
      return name;
    }
    print('잘못된 이름입니다. 다시 입력해주세요.');
  }
}

void loadMonsters() {
  try {
    final file = File('monsters.txt');
    final lines = file.readAsLinesSync();

    for (var line in lines) {
      final parts = line.trim().split(',');
      if (parts.length != 3) continue;

      String name = parts[0];
      int health = int.parse(parts[1]);
      int maxAttack = int.parse(parts[2]);

      monsters.add(Monster(name, health, maxAttack));
    }

    print('\n몬스터 ${monsters.length}마리가 로드되었습니다.');
  } catch (e) {
    print('몬스터 데이터를 불러오는 데 실패했습니다: $e');
    exit(1);
  }
}

void main() {
  Game game = Game();
  game.startGame();
}