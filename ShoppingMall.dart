// import 'dart:io';

// class ShoppingMall {
//   List<String> allProduct = [];
//   List<String> cart = [];
//   late int totalPrice;
//   late int price;

//   void showProducts() {
//     print(allProduct);
//   }

//   List<String> addToCart(List<String> product) {
//     return cart.addAll(product);
//   }
// }

// List<String> productName = ['셔츠', '원피스', '반팔티', '반바지', '양말'];
// List<int> productPrice = [45000, 30000, 35000, 38000, 5000];

// void main() {
// String manual =
// '[1] 상품 목록 보기 / [2] 장바구니에 담기 / [3] 장바구니에 담긴 상품의 총 가격 보기 / [4] 프로그램 종료';
// print('[1] 상품 목록 보기 / [2] 장바구니에 담기 / [3] 장바구니에 담긴 상품의 총 가격 보기 / [4] 프로그램 종료');
// String? str = stdin.readLineSync();
// print(str);
// if (str == '1') {
//   for (int i = 0; i < 5; i++) {
//     print('$productName[$i] / $productPrice[$i]');
//   }
// } else {
//   print('지원하지 않는 기능입니다 ! 다시 시도해 주세요 ..');
// };
// }

import 'dart:io';

List<String> productName = ['셔츠', '원피스', '반팔티', '반바지', '양말'];
List<int> productPrice = [45000, 30000, 35000, 38000, 5000];

void main() {
  String manual =
      '[1] 상품 목록 보기 / [2] 장바구니에 담기 / [3] 장바구니에 담긴 상품의 총 가격 보기 / [4] 프로그램 종료';
  print(manual);
  String? str = stdin.readLineSync();
  if (str == '1') {
    for (int i = 0; i < 5; i++) {
      print('${productName[i]} / ${productPrice[i]}원');
    }
  } else {
    print('지원하지 않는 기능입니다 ! 다시 시도해 주세요 ..');
  }
}

// 1. 판매하는 상품 목록을 볼 수 있는 기능 : 입력을 받고 그 입력을 처리하는 과정에서 어려움 느낌
// 1-1)
// Unknown evaluation response type: null 에러 발생
// 에러 구글링
// 1) Settings → 2) Dart라고 검색 → Run and debug → Cli console → terminal 또는 external terminal 클릭하기
// Cli console이 무슨 설정인데?

// 1-2)
// Too many positional arguments: 1 expected, but 3 found. 에러 발생
// print(productName[i] '/' productPrice[i]); 을
// print('${productName[i]} / ${productPrice[i]}'); 로 변경
