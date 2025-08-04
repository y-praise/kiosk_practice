// lib/screens/second_page.dart
import 'package:flutter/material.dart';
import '../utils.dart'; // SizeConfig 임포트
import 'third_page.dart';

class SecondPage extends StatefulWidget {
  const SecondPage({super.key});

  @override
  State<SecondPage> createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
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
      body: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: 80.h),
              Text(
                '맛있는 버거',
                style: TextStyle(fontSize: 40.sp, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 50.h),
              Text(
                '식사 방법 선택',
                style: TextStyle(fontSize: 30.sp, fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 30.h),
              Expanded(
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        flex: 1,
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 15.w),
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => const ThirdPage()),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.w),
                              ),
                              minimumSize: Size.fromHeight(270.h),
                              textStyle: TextStyle(fontSize: 25.sp),
                            ),
                            child: const Text(
                              '매장에서 식사',
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 15.w),
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => const ThirdPage()),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.w),
                              ),
                              minimumSize: Size.fromHeight(270.h),
                              textStyle: TextStyle(fontSize: 22.sp),
                            ),
                            child: const Text(
                              '포장하기',
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),

          // 도움말 말풍선 오버레이
          if (_showHelpOverlay)
            Positioned(
              bottom: 200.h, // 버튼 아래쪽에 위치하도록 조정
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
                    '식사 방법에 따라 버튼을 눌러주세요',
                    textAlign: TextAlign.center,
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
