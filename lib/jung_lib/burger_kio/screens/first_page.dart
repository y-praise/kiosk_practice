// lib/screens/first_page.dart
import 'package:flutter/material.dart';
import '../utils.dart';
import 'second_page.dart';

class FirstPage extends StatefulWidget {
  const FirstPage({super.key});

  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  // 도움말 말풍선의 표시 상태를 관리하는 변수
  bool _showHelpOverlay = false;

  // 도움말 버튼을 누를 때 호출되는 함수
  void _toggleHelpOverlay() {
    setState(() {
      _showHelpOverlay = !_showHelpOverlay;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          // 우측 상단에 도움말 버튼 추가
          IconButton(
            icon: Icon(
              Icons.help_outline,
              size: 30.w,
            ),
            onPressed: _toggleHelpOverlay,
          ),
          SizedBox(width: 10.w), // 버튼 우측 여백
        ],
      ),
      body: Stack( // 말풍선 오버레이를 위해 Stack 위젯 사용
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(height: 50.h),

              Align(
                alignment: Alignment.center,
                child: Text(
                  '맛있는 버거',
                  style: TextStyle(
                    fontSize: 48.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
              SizedBox(height: 30.h),

              Expanded(
                child: Center(
                  child: Image.asset(
                    'assets/images/burger.png',
                    fit: BoxFit.contain,
                    width: 500.w,
                    height: 500.h,
                    errorBuilder: (context, error, stackTrace) {
                      return Text(
                        '이미지 로드 실패',
                        style: TextStyle(fontSize: 20.sp, color: Colors.red),
                      );
                    },
                  ),
                ),
              ),

              // 하단 "주문 시작" 버튼
              Padding(
                padding: EdgeInsets.only(bottom: 50.h),
                child: SizedBox(
                  width: 300.w,
                  height: 80.h,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const SecondPage()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFE0E0E0),
                      foregroundColor: Colors.black,
                      textStyle: TextStyle(
                        fontSize: 32.sp,
                        fontWeight: FontWeight.bold,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(40.w),
                      ),
                    ),
                    child: const Text('주문 시작'),
                  ),
                ),
              ),
            ],
          ),

          // 도움말 말풍선 오버레이
          if (_showHelpOverlay)
            Positioned(
              bottom: 150.h, // 버튼 위쪽에 위치
              left: 0,
              right: 0,
              child: Center(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.7), // 반투명한 배경
                    borderRadius: BorderRadius.circular(20.w),
                  ),
                  child: Text(
                    '주문 시작 버튼을 눌러 주문을 시작하세요',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.sp,
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
