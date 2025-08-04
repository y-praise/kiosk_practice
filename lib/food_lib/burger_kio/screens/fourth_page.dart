// lib/screens/fourth_page.dart
import 'package:flutter/material.dart';
import '../utils.dart'; // SizeConfig 임포트 (w, h, sp 사용을 위해 필요)

class FourthPage extends StatefulWidget {
  final List<Map<String, dynamic>> orderList;
  final int totalAmount;

  const FourthPage({
    super.key,
    required this.orderList,
    required this.totalAmount,
  });

  @override
  State<FourthPage> createState() => _FourthPageState();
}

class _FourthPageState extends State<FourthPage> {
  late List<Map<String, dynamic>> _currentOrderList;
  late int _currentTotalAmount;
  // 도움말 오버레이의 표시 여부를 관리하는 상태 변수
  bool _showHelpOverlay = false;

  @override
  void initState() {
    super.initState();
    _currentOrderList = List<Map<String, dynamic>>.from(
      widget.orderList.map((item) => Map<String, dynamic>.from(item))
    );
    _currentTotalAmount = widget.totalAmount;
  }

  void _updateQuantity(int index, int delta) {
    setState(() {
      int currentQuantity = _currentOrderList[index]['quantity'] as int;
      int newQuantity = currentQuantity + delta;

      if (newQuantity > 0) {
        _currentOrderList[index]['quantity'] = newQuantity;
      } else {
        _currentOrderList.removeAt(index);
      }
      _calculateTotalAmount();
    });
  }

  void _calculateTotalAmount() {
    int total = 0;
    for (var item in _currentOrderList) {
      total += (item['price'] as int) * (item['quantity'] as int);
    }
    setState(() {
      _currentTotalAmount = total;
    });
  }

  // 말풍선 위젯을 생성하는 헬퍼 함수
  Widget _buildHelpBubble({required String text, double? top, double? bottom,double? left,double? right}) {
    return Positioned(
      top: top,
      bottom: bottom,
      left: left,
      right: right,
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
      appBar: AppBar(
        title: Text(
          '주문 확인',
          style: TextStyle(fontSize: 30.sp),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, size: 28.w),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        // 우측 상단에 도움말 버튼 추가
        actions: [
          IconButton(
            icon: Icon(Icons.help_outline, size: 28.w),
            // 버튼 클릭 시 _showHelpOverlay 상태를 토글
            onPressed: () {
              setState(() {
                _showHelpOverlay = !_showHelpOverlay;
              });
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
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                color: Colors.white,
                alignment: Alignment.centerLeft,
              ),
              Divider(height: 1.h, color: Colors.grey),
              Expanded(
                child: _currentOrderList.isEmpty
                    ? Center(child: Text('주문 내역이 없습니다.', style: TextStyle(fontSize: 18.sp)))
                    : ListView.builder(
                        padding: EdgeInsets.all(16.w),
                        itemCount: _currentOrderList.length,
                        itemBuilder: (context, index) {
                          final item = _currentOrderList[index];
                          final String itemName = item['name'];
                          final int itemPrice = item['price'];
                          final int itemQuantity = item['quantity'];
                          final int itemSubtotal = itemPrice * itemQuantity;
                          final String? imagePath = item['imageUrl'] as String?;

                          return Card(
                            margin: EdgeInsets.only(bottom: 15.h),
                            elevation: 2,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.w)),
                            child: Padding(
                              padding: EdgeInsets.all(15.w),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Text(
                                          itemName,
                                          style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 2,
                                        ),
                                      ),
                                      SizedBox(width: 10.w),
                                      Text('$itemPrice원', style: TextStyle(fontSize: 16.sp)),
                                    ],
                                  ),
                                  SizedBox(height: 10.h),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      imagePath != null && imagePath.isNotEmpty
                                          ? ClipRRect(
                                              borderRadius: BorderRadius.circular(8.w),
                                              child: Image.asset(
                                                imagePath,
                                                width: 80.w,
                                                height: 80.h,
                                                fit: BoxFit.cover,
                                                errorBuilder: (context, error, stackTrace) {
                                                  return Container(
                                                    width: 80.w,
                                                    height: 80.h,
                                                    color: Colors.grey[200],
                                                    child: Center(
                                                      child: Icon(Icons.broken_image, size: 40.w, color: Colors.grey),
                                                    ),
                                                  );
                                                },
                                              ),
                                            )
                                          : Container(
                                              width: 80.w,
                                              height: 80.h,
                                              color: Colors.grey[200],
                                              child: Center(
                                                child: Icon(Icons.fastfood, size: 40.w, color: Colors.grey),
                                              ),
                                            ),
                                      Row(
                                        children: [
                                          IconButton(
                                            icon: Icon(Icons.remove_circle, size: 30.w, color: Colors.grey),
                                            onPressed: () => _updateQuantity(index, -1),
                                          ),
                                          Text('$itemQuantity', style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold)),
                                          IconButton(
                                            icon: Icon(Icons.add_circle, size: 30.w, color: Colors.blue),
                                            onPressed: () => _updateQuantity(index, 1),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 10.h),
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: Text(
                                      '합계금액: $itemSubtotal원',
                                      style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold, color: Colors.red),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
              ),
              Container(
                padding: EdgeInsets.all(20.w),
                color: Colors.grey[100],
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('할인 금액', style: TextStyle(fontSize: 18.sp)),
                        Text('0원', style: TextStyle(fontSize: 18.sp)),
                      ],
                    ),
                    SizedBox(height: 10.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('총 결제 금액', style: TextStyle(fontSize: 22.sp, fontWeight: FontWeight.bold)),
                        Text('$_currentTotalAmount원', style: TextStyle(fontSize: 22.sp, fontWeight: FontWeight.bold, color: Colors.red)),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                height: 70.h,
                padding: EdgeInsets.all(10.w),
                color: Colors.black87,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.grey,
                          textStyle: TextStyle(fontSize: 20.sp),
                        ),
                        child: const Text('취소'),
                      ),
                    ),
                    SizedBox(width: 10.w),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: _currentOrderList.isEmpty
                            ? null
                            : () {
                                Navigator.pushNamed(
                                  context,
                                  '/fifth',
                                  arguments: _currentTotalAmount,
                                );
                              },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          textStyle: TextStyle(fontSize: 20.sp),
                        ),
                        child: const Text('결제'),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          // _showHelpOverlay 상태에 따라 말풍선 오버레이 표시
          if (_showHelpOverlay) ...[
            // 상단 말풍선
            _buildHelpBubble(
              text: '+,-로 개수를 조절해보세요',
              left: 30.h,
              top: 100.h, // ListView의 상단 근처에 위치
            ),
            // 하단 말풍선
            _buildHelpBubble(
              text: '결제를 눌러 다음 단계로 넘어가세요',
              bottom: 50.h, // 결제 버튼 위에 위치
              right: 20.h
            ),
          ],
        ],
      ),
    );
  }
}
