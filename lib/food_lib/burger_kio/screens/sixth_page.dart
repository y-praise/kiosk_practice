// lib/screens/sixth_page.dart
import 'package:flutter/material.dart';
import '../utils.dart'; // SizeConfig 임포트
import 'dart:math'; // Random을 위해 import

class SixthPage extends StatefulWidget {
  const SixthPage({super.key});

  @override
  State<SixthPage> createState() => _SixthPageState();
}

class _SixthPageState extends State<SixthPage> {
  late int _orderNumber; // 주문 번호를 저장할 변수

  @override
  void initState() {
    super.initState();
    // 페이지가 로드될 때 무작위 3자리 주문 번호 생성 (100 ~ 999)
    _orderNumber = Random().nextInt(900) + 100;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // 배경색 흰색
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        toolbarHeight: 0, // AppBar 보이지 않게 설정
      ),
      body: GestureDetector(
        // 화면 어디를 클릭하든 첫 화면으로 돌아가게 함
        onTap: () {
          Navigator.popUntil(context, (route) => route.isFirst);
        },
        child: Container(
          // GestureDetector가 전체 화면을 감지하도록 Container 사용
          color: Colors.transparent, // 투명하게 설정하여 하단 Scaffold 배경색이 보이도록 함
          width: double.infinity,
          height: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center, // 세로 중앙 정렬
            crossAxisAlignment: CrossAxisAlignment.center, // 가로 중앙 정렬
            children: [
              Text(
                '주문이 완료되었습니다!', //
                style: TextStyle(
                  fontSize: 28.sp, // 폰트 크기 조정
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 30.h), // 여백

              Text(
                '주문번호', //
                style: TextStyle(
                  fontSize: 20.sp, // 폰트 크기 조정
                  color: Colors.black87,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 10.h), // 여백

              Text(
                '$_orderNumber', // 생성된 주문 번호 표시
                style: TextStyle(
                  fontSize: 100.sp, // 주문 번호 폰트 크기 크게 설정
                  fontWeight: FontWeight.bold,
                  color: Colors.red, // 붉은색
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 30.h), // 여백

              Text(
                '신용카드를 뽑은 후', //
                style: TextStyle(
                  fontSize: 18.sp, // 폰트 크기 조정
                  color: Colors.black54,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 5.h), // 여백
              Text(
                '출력된 영수증을 받아가세요!', //
                style: TextStyle(
                  fontSize: 18.sp, // 폰트 크기 조정
                  color: Colors.black54,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}