// lib/screens/fifth_page.dart
import 'package:flutter/material.dart';
import '../utils.dart'; // SizeConfig 임포트 (w, h, sp 사용을 위해 필요)
import 'package:flutter_tts/flutter_tts.dart'; // flutter_tts 패키지 임포트

// StatefulWidget으로 변경하여 상태 관리가 가능하도록 합니다.
class FifthPage extends StatefulWidget {
  final int finalTotalAmount;

  const FifthPage({
    super.key,
    required this.finalTotalAmount,
  });

  @override
  State<FifthPage> createState() => _FifthPageState();
}

class _FifthPageState extends State<FifthPage> {
  // TTS 인스턴스를 관리하는 변수
  late FlutterTts flutterTts;
  // 도움말 오버레이의 표시 여부를 관리하는 상태 변수
  bool _showHelpOverlay = false;

  @override
  void initState() {
    super.initState();
    // TTS 인스턴스 초기화
    flutterTts = FlutterTts();
    _initTts();
  }

  // TTS 설정 및 초기화 함수
  Future<void> _initTts() async {
    // 언어를 한국어로 설정합니다.
    await flutterTts.setLanguage("ko-KR");
    // TTS 속도를 조금 느리게 설정하여 더 잘 들리도록 합니다.
    await flutterTts.setSpeechRate(0.5);
  }

  // 텍스트를 음성으로 변환하여 말하는 함수
  Future<void> _speak(String text) async {
    await flutterTts.speak(text);
  }

  // 위젯이 종료될 때 TTS 리소스를 해제하는 함수
  @override
  void dispose() {
    flutterTts.stop();
    super.dispose();
  }

  // 말풍선 위젯을 생성하는 헬퍼 함수
  Widget _buildHelpBubble({required String text, double? top, double? bottom}) {
    return Positioned(
      top: top,
      bottom: bottom,
      left: 0,
      right: 0,
      child: Center(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.7),
            borderRadius: BorderRadius.circular(20.w),
          ),
          child: Text(
            text,
            style: TextStyle(
              color: Colors.white,
              fontSize: 18.sp,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(Icons.help_outline, size: 28.w, color: Colors.black),
            // 버튼 클릭 시 _showHelpOverlay 상태를 토글
            onPressed: () {
              setState(() {
                _showHelpOverlay = !_showHelpOverlay;
              });
              // 도움말이 표시될 때만 TTS를 실행합니다.
              if (_showHelpOverlay) {
                _speak('카드를 터치해 결제하세요');
              } else {
                // 도움말이 사라지면 TTS를 중지합니다.
                flutterTts.stop();
              }
            },
          ),
        ],
      ),
      // Scaffold의 body를 Stack으로 감싸서 오버레이 위젯을 띄울 수 있도록 함
      body: Stack(
        children: [
          // 기존의 body 컨텐츠
          Column(
            children: [
              SizedBox(height: 60.h),

              // "신용카드를 투입구에 꽂아주세요" 텍스트
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Text(
                  '신용카드를',
                  style: TextStyle(
                    fontSize: 32.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: 15.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Text(
                  '투입구에 꽂아주세요',
                  style: TextStyle(
                    fontSize: 32.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: 20.h),

              // "결제 오류 시 마그네틱을 아래로 향하게 긁어주세요" 텍스트
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Text(
                  '결제 오류 시 마그네틱을 아래로 향하게 긁어주세요',
                  style: TextStyle(
                    fontSize: 16.sp,
                    color: Colors.grey[700],
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: 40.h),

              // 카드 삽입구 이미지 및 화살표 (Expanded로 남은 공간 유연하게 차지)
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.arrow_drop_down,
                      size: 80.w,
                      color: Colors.red,
                    ),
                    SizedBox(height: 10.h),
                    // GestureDetector로 카드를 감싸 클릭 이벤트를 추가
                    GestureDetector(
                      onTap: () {
                        // 카드를 클릭하면 SixthPage로 이동
                        Navigator.pushNamed(context, '/sixth');
                      },
                      child: Container(
                        width: 300.w,
                        height: 180.h,
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          border: Border.all(color: Colors.black54, width: 2.w),
                          borderRadius: BorderRadius.circular(15.w),
                        ),
                        child: Center(
                          child: Container(
                            width: 240.w,
                            height: 130.h,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: Colors.grey, width: 1.w),
                              borderRadius: BorderRadius.circular(10.w),
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(10.w),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Align(
                                    alignment: Alignment.topRight,
                                    child: Text(
                                      '12 3456 7890',
                                      style: TextStyle(fontSize: 14.sp, color: Colors.black87),
                                    ),
                                  ),
                                  Container(
                                    width: 40.w,
                                    height: 25.h,
                                    color: Colors.blue[100],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // 하단 결제 정보 및 버튼 영역
              Container(
                height: 200.h,
                color: Colors.black87,
                padding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 20.h),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          '총 결제금액',
                          style: TextStyle(
                            fontSize: 28.sp,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          '${widget.finalTotalAmount}원',
                          style: TextStyle(
                            fontSize: 32.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.red,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 25.h),
                    SizedBox(
                      width: double.infinity,
                      height: 60.h,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.popUntil(context, (route) => route.isFirst);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.grey,
                          foregroundColor: Colors.white,
                          textStyle: TextStyle(fontSize: 20.sp),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.w),
                          ),
                        ),
                        child: const Text('결제취소'),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          // _showHelpOverlay 상태에 따라 말풍선 오버레이 표시
          if (_showHelpOverlay)
            _buildHelpBubble(
              text: '카드를 터치해 결제하세요',
              bottom: 220.h, // 결제 정보 영역 위에 위치
            ),
        ],
      ),
    );
  }
}
