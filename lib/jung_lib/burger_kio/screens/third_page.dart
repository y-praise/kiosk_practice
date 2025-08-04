import 'package:flutter/material.dart';
import 'fourth_page.dart';
import '../utils.dart';

class ThirdPage extends StatefulWidget {
  const ThirdPage({super.key});

  @override
  State<ThirdPage> createState() => _ThirdPageState();
}

class _ThirdPageState extends State<ThirdPage> {
  // State variable to control the visibility of the help bubbles
  bool _showHelpBubbles = false;

  String _selectedCategory = '이벤트';
  List<Map<String, dynamic>> _orderList = [];

  final Map<String, List<Map<String, dynamic>>> _menus = {
    '이벤트': [
      {'name': '오늘의 특가 버거', 'price': 4000, 'imageUrl': 'assets/images/special.png'},
      {'name': '만원의 행복 버거', 'price': 10000, 'imageUrl': 'assets/images/10000won.png'},
      {'name': '새로운 치킨 버거', 'price': 6500, 'imageUrl': 'assets/images/chicken.png'},
    ],
    '버거': [
      {
        'name': '불고기 버거',
        'imageUrl': 'assets/images/bulgogi.png',
        'options': [
          {'optionName': '불고기 버거 단품', 'price': 5000},
          {'optionName': '불고기 버거 세트', 'price': 7000},
        ]
      },
      {
        'name': '새우 버거',
        'imageUrl': 'assets/images/shrimp.png',
        'options': [
          {'optionName': '새우 버거 단품', 'price': 5500},
          {'optionName': '새우 버거 세트', 'price': 7500},
        ]
      },
      {
        'name': '치즈 버거',
        'imageUrl': 'assets/images/burger.png',
        'options': [
          {'optionName': '치즈 버거 단품', 'price': 6000},
          {'optionName': '치즈 버거 세트', 'price': 8000},
        ]
      },
      {
        'name': '베이컨 버거',
        'imageUrl': 'assets/images/bacon.png',
        'options': [
          {'optionName': '베이컨 버거 단품', 'price': 6500},
          {'optionName': '베이컨 버거 세트', 'price': 8500},
        ]
      },
      {
        'name': '핫 버거',
        'imageUrl': 'assets/images/hot.png',
        'options': [
          {'optionName': '핫 버거 단품', 'price': 7000},
          {'optionName': '핫 버거 세트', 'price': 9000},
        ]
      },
    ],
    '사이드': [
      {'name': '감자튀김', 'price': 2000, 'imageUrl': 'assets/images/ff.png'},
      {'name': '치즈스틱', 'price': 2500, 'imageUrl': 'assets/images/cheeze.png'},
      {'name': '어니언링', 'price': 2500, 'imageUrl': 'assets/images/onion.png'},
    ],
    '음료': [
      {'name': '콜라', 'price': 1500, 'imageUrl': 'assets/images/coke.png'},
      {'name': '사이다', 'price': 1500, 'imageUrl': 'assets/images/drink.png'},
      {'name': '환타', 'price': 1500, 'imageUrl': 'assets/images/fanta.png'},
      {'name': '과일 주스', 'price': 2500, 'imageUrl': 'assets/images/fruit.png'},
    ],
  };

  void _onMenuItemTap(Map<String, dynamic> menuData) async {
    final String menuItemName = menuData['name']!;
    final String imageUrl = menuData['imageUrl'] ?? 'assets/images/burger.png';

    if (_selectedCategory == '버거' && menuData.containsKey('options')) {
      final List<Map<String, dynamic>> options = List<Map<String, dynamic>>.from(menuData['options']);
      final Map<String, dynamic>? selectedConfig =
      await _showBurgerCustomizationDialog(menuItemName, options);

      if (selectedConfig != null) {
        String finalItemName = selectedConfig['optionName'];
        int finalPrice = selectedConfig['finalPrice'];
        bool removePickle = selectedConfig['removePickle'] ?? false;
        bool removeOnion = selectedConfig['removeOnion'] ?? false;
        String? selectedDrink = selectedConfig['selectedDrink'];

        if (removePickle) finalItemName += ' (피클X)';
        if (removeOnion) finalItemName += ' (양파X)';
        if (selectedDrink != null) finalItemName += ' (${selectedDrink})';

        setState(() {
          _orderList.add({
            'name': finalItemName,
            'price': finalPrice,
            'quantity': 1,
            'isBurger': true,
            'imageUrl': imageUrl,
          });
        });
      }
    } else {
      final int? itemPrice = menuData['price'];
      final bool? confirm = await showDialog<bool>(
        context: context,
        builder: (BuildContext dialogContext) {
          return AlertDialog(
            title: Text('$menuItemName을(를) 주문하시겠습니까?', style: TextStyle(fontSize: 20.sp)),
            content: itemPrice != null ? Text('가격: $itemPrice원', style: TextStyle(fontSize: 16.sp)) : null,
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.pop(dialogContext, false),
                child: Text('취소', style: TextStyle(fontSize: 18.sp)),
              ),
              TextButton(
                onPressed: () => Navigator.pop(dialogContext, true),
                child: Text('확인', style: TextStyle(fontSize: 18.sp)),
              ),
            ],
          );
        },
      );

      if (confirm == true) {
        setState(() {
          _orderList.add({
            'name': menuItemName,
            'price': itemPrice ?? 0,
            'quantity': 1,
            'isBurger': false,
            'imageUrl': imageUrl,
          });
        });
      }
    }
  }

  Future<Map<String, dynamic>?> _showBurgerCustomizationDialog(
      String burgerName, List<Map<String, dynamic>> options) async {
    int _selectedOptionIndex = 0;
    bool _removePickle = false;
    bool _removeOnion = false;
    String? _selectedDrink;

    if (options.isNotEmpty && _isSetSelected(options, _selectedOptionIndex)) {
      _selectedDrink = '콜라';
    }

    return await showDialog<Map<String, dynamic>>(
      context: context,
      builder: (BuildContext dialogContext) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setStateInDialog) {
            int calculatePrice() {
              int price = 0;
              if (_selectedOptionIndex >= 0 && _selectedOptionIndex < options.length) {
                price = options[_selectedOptionIndex]['price'];
              }

              if (_selectedDrink == '과일 주스') {
                price += 600;
              }
              return price;
            }

            int currentCalculatedPrice = calculatePrice();

            return Dialog(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.w)),
              child: Container(
                padding: EdgeInsets.all(20.w),
                width: MediaQuery.of(context).size.width * 0.9,
                constraints: BoxConstraints(maxWidth: 600.w, maxHeight: 600.h),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '$burgerName 구성 선택',
                          style: TextStyle(fontSize: 22.sp, fontWeight: FontWeight.bold),
                        ),
                        IconButton(
                          icon: Icon(Icons.close, size: 24.sp),
                          onPressed: () {
                            Navigator.pop(context, null);
                          },
                        ),
                      ],
                    ),
                    const Divider(),
                    Flexible(
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('구성 선택:', style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w600)),
                            Column(
                              children: options.asMap().entries.map((entry) {
                                int idx = entry.key;
                                Map<String, dynamic> option = entry.value;
                                return RadioListTile<int>(
                                  title: Text('${option['optionName']} (${option['price']}원)', style: TextStyle(fontSize: 16.sp)),
                                  value: idx,
                                  groupValue: _selectedOptionIndex,
                                  onChanged: (int? value) {
                                    setStateInDialog(() {
                                      _selectedOptionIndex = value!;
                                      if (!_isSetSelected(options, _selectedOptionIndex)) {
                                        _selectedDrink = null;
                                      } else {
                                        if (_selectedDrink == null) {
                                          _selectedDrink = '콜라';
                                        }
                                      }
                                    });
                                  },
                                );
                              }).toList(),
                            ),
                            const Divider(),
                            Text('추가 옵션:', style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w600)),
                            CheckboxListTile(
                              title: Text('피클 제거', style: TextStyle(fontSize: 16.sp)),
                              value: _removePickle,
                              onChanged: (bool? value) {
                                setStateInDialog(() {
                                  _removePickle = value!;
                                });
                              },
                            ),
                            CheckboxListTile(
                              title: Text('양파 제거', style: TextStyle(fontSize: 16.sp)),
                              value: _removeOnion,
                              onChanged: (bool? value) {
                                setStateInDialog(() {
                                  _removeOnion = value!;
                                });
                              },
                            ),
                            if (_isSetSelected(options, _selectedOptionIndex))
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Divider(),
                                  Text('음료 선택:', style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w600)),
                                  ...['콜라', '제로콜라', '사이다', '과일 주스'].map((drink) {
                                    return RadioListTile<String>(
                                      title: Text(drink == '과일 주스' ? '$drink (+600원)' : drink, style: TextStyle(fontSize: 16.sp)),
                                      value: drink,
                                      groupValue: _selectedDrink,
                                      onChanged: (String? value) {
                                        setStateInDialog(() {
                                          _selectedDrink = value;
                                        });
                                      },
                                    );
                                  }).toList(),
                                ],
                              ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 20.h),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        '총 가격: ${currentCalculatedPrice}원',
                        style: TextStyle(fontSize: 22.sp, fontWeight: FontWeight.bold, color: Colors.blue),
                      ),
                    ),
                    SizedBox(height: 20.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context, null);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.grey,
                              minimumSize: Size(120.w, 50.h),
                              textStyle: TextStyle(fontSize: 20.sp),
                            ),
                            child: const Text('취소'),
                          ),
                        ),
                        SizedBox(width: 10.w),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: _selectedOptionIndex != null &&
                                (!_isSetSelected(options, _selectedOptionIndex) || _selectedDrink != null)
                                ? () {
                              Navigator.pop(context, {
                                'optionName': options[_selectedOptionIndex]['optionName'],
                                'finalPrice': currentCalculatedPrice,
                                'removePickle': _removePickle,
                                'removeOnion': _removeOnion,
                                'selectedDrink': _selectedDrink,
                              });
                            }
                                : null,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red,
                              minimumSize: Size(120.w, 50.h),
                              textStyle: TextStyle(fontSize: 20.sp),
                            ),
                            child: const Text('확인'),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  bool _isSetSelected(List<Map<String, dynamic>> options, int? selectedIndex) {
    if (selectedIndex == null || selectedIndex < 0 || selectedIndex >= options.length) return false;
    final String optionName = options[selectedIndex]['optionName'];
    return optionName.contains('세트');
  }

  // 사이드 메뉴 팝업 함수
  Future<void> _showSideMenuDialog() async {
    final List<Map<String, dynamic>> sideMenus = [
      _menus['사이드']![0], // 감자튀김
      _menus['사이드']![1], // 치즈스틱
      _menus['사이드']![2], // 어니언링
    ];

    List<Map<String, dynamic>> _selectedSideMenuItems = [];

    await showDialog<void>(
      context: context,
      builder: (BuildContext dialogContext) {
        return StatefulBuilder(
          builder: (context, setStateInDialog) {
            return Dialog(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.w)),
              child: Container(
                padding: EdgeInsets.all(20.w),
                width: MediaQuery.of(context).size.width * 0.9,
                constraints: BoxConstraints(maxWidth: 600.w, maxHeight: 650.h),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '함께 먹으면 더 맛있어요',
                          style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
                        ),
                        IconButton(
                          icon: Icon(Icons.close, size: 24.sp),
                          onPressed: () {
                            Navigator.pop(dialogContext);
                          },
                        ),
                      ],
                    ),
                    const Divider(),
                    Expanded(
                      child: GridView.builder(
                        padding: EdgeInsets.all(10.w),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 15.w,
                          mainAxisSpacing: 15.h,
                          childAspectRatio: 0.9,
                        ),
                        itemCount: sideMenus.length,
                        itemBuilder: (context, index) {
                          final item = sideMenus[index];
                          final bool isSelected = _selectedSideMenuItems.any((selectedItem) => selectedItem['name'] == item['name']);

                          return GestureDetector(
                            onTap: () {
                              setStateInDialog(() {
                                if (isSelected) {
                                  _selectedSideMenuItems.removeWhere((selectedItem) => selectedItem['name'] == item['name']);
                                } else {
                                  _selectedSideMenuItems.add(item);
                                }
                              });
                            },
                            child: Card(
                              elevation: isSelected ? 8 : 4,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.w),
                                side: isSelected
                                    ? const BorderSide(color: Colors.blue, width: 3)
                                    : BorderSide.none,
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(5.w),
                                    child: Image.asset(
                                      item['imageUrl'] ?? 'assets/images/burger.png', // 이미지 경로 추가
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
                                  ),
                                  SizedBox(height: 10.h),
                                  Text(
                                    item['name']!,
                                    style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
                                    textAlign: TextAlign.center,
                                  ),
                                  Text(
                                    '${item['price']}원',
                                    style: TextStyle(fontSize: 14.sp, color: Colors.black54),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    SizedBox(height: 20.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.pop(dialogContext);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.grey,
                              textStyle: TextStyle(fontSize: 20.sp),
                              padding: EdgeInsets.symmetric(vertical: 15.h),
                            ),
                            child: const Text('아니오'),
                          ),
                        ),
                        SizedBox(width: 10.w),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              setState(() {
                                for (var item in _selectedSideMenuItems) {
                                  final existingItemIndex = _orderList.indexWhere(
                                          (orderItem) => orderItem['name'] == item['name']);
                                  if (existingItemIndex != -1) {
                                    _orderList[existingItemIndex]['quantity']++;
                                  } else {
                                    _orderList.add({
                                      'name': item['name'],
                                      'price': item['price'],
                                      'quantity': 1,
                                      'isBurger': false,
                                      'imageUrl': item['imageUrl'] ?? 'assets/images/burger.png',
                                    });
                                  }
                                }
                              });
                              Navigator.pop(dialogContext);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green,
                              textStyle: TextStyle(fontSize: 20.sp),
                              padding: EdgeInsets.symmetric(vertical: 15.h),
                            ),
                            child: const Text('추가하기'),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );

    int total = _orderList.fold(0, (sum, item) => sum + (item['price'] * item['quantity'] as int)); // totalAmount 계산 로직 변경
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FourthPage(
          orderList: _orderList,
          totalAmount: total,
        ),
      ),
    ).then((_) {
      setState(() {
        _orderList.clear();
      });
    });
  }

  // Widget for the help bubble.
  Widget _buildHelpBubble({
    required String text,
    double? top,
    double? left,
    double? right,
    double? bottom,
  }) {
    return Positioned(
      top: top,
      left: left,
      right: right,
      bottom: bottom,
      child: Visibility(
        visible: _showHelpBubbles,
        child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.7), // 반투명한 배경
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
    // 총 결제 금액 계산 함수
    int _getTotalAmount() {
      int total = 0;
      for (var item in _orderList) {
        total += (item['price'] as int) * (item['quantity'] as int);
      }
      return total;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('메뉴 선택', style: TextStyle(fontSize: 22.sp)),
        actions: [
          // The new help button
          IconButton(
            icon: Icon(Icons.help_outline, size: 24.sp),
            onPressed: () {
              setState(() {
                _showHelpBubbles = !_showHelpBubbles;
              });
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          Column(
            children: [
              SizedBox(height: 20.h),
              Container(
                height: 80.h,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20.w),
                    topRight: Radius.circular(20.w),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      spreadRadius: 1.w,
                      blurRadius: 5.w,
                      offset: Offset(0, 3.h),
                    ),
                  ],
                ),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                  child: Row(
                    children: _menus.keys.map((category) {
                      String buttonText = category;
                      return Padding(
                        padding: EdgeInsets.symmetric(horizontal: 5.w),
                        child: ElevatedButton(
                          onPressed: () {
                            setState(() {
                              _selectedCategory = category;
                            });
                          },
                          style: ElevatedButton.styleFrom(
                            minimumSize: Size(100.w, 50.h),
                            backgroundColor: _selectedCategory == category ? Colors.blue : Colors.grey,
                            textStyle: TextStyle(fontSize: 18.sp),
                          ),
                          child: Text(buttonText),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  color: Colors.white,
                  child: GridView.builder(
                    padding: EdgeInsets.all(20.w),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 20.w,
                      mainAxisSpacing: 20.h,
                      childAspectRatio: 0.8, // 이미지 표시를 위해 비율 조정
                    ),
                    itemCount: _menus[_selectedCategory]!.length,
                    itemBuilder: (context, index) {
                      final menuData = _menus[_selectedCategory]![index];
                      final String? priceText = _selectedCategory != '버거' && menuData.containsKey('price')
                          ? '가격: ${menuData['price']}원'
                          : null;

                      return Card(
                        elevation: 4,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.w)),
                        child: InkWell(
                          onTap: () => _onMenuItemTap(menuData),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                child: ClipRRect(
                                  borderRadius: BorderRadius.vertical(top: Radius.circular(10.w)),
                                  child: Image.asset(
                                    menuData['imageUrl'] ?? 'assets/images/burger.png', // 이미지 경로 사용
                                    fit: BoxFit.cover,
                                    width: double.infinity,
                                    errorBuilder: (context, error, stackTrace) {
                                      return Container(
                                        color: Colors.grey[200],
                                        child: Center(
                                          child: Icon(Icons.broken_image, size: 40.w, color: Colors.grey),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(8.w),
                                child: Column(
                                  children: [
                                    Text(
                                      menuData['name']!,
                                      style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
                                      textAlign: TextAlign.center,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    if (priceText != null)
                                      Text(
                                        priceText,
                                        style: TextStyle(fontSize: 15.sp, color: Colors.black54),
                                        textAlign: TextAlign.center,
                                      ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
              Container(
                height: 150.h,
                color: Colors.black87,
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '주문 내역:',
                      style: TextStyle(color: Colors.white, fontSize: 16.sp, fontWeight: FontWeight.bold),
                    ),
                    Expanded(
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: _orderList.length,
                        itemBuilder: (context, index) {
                          final item = _orderList[index];
                          String itemName = item['name'];
                          String priceInfo = '${item['price']}원 x ${item['quantity']}';

                          return Padding(
                            padding: EdgeInsets.symmetric(horizontal: 4.w),
                            child: Card(
                              color: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.w),
                              ),
                              elevation: 2,
                              child: SizedBox(
                                width: 100.w, // 각 카드의 너비 고정
                                child: Stack(
                                  children: [
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(top: 8.h), // 상단 여백 추가
                                          child: Center(
                                            child: ClipRRect(
                                              borderRadius: BorderRadius.circular(5.w),
                                              child: Image.asset(
                                                item['imageUrl'] ?? 'assets/images/burger.png',
                                                width: 50.w,
                                                height: 50.h,
                                                fit: BoxFit.cover,
                                                errorBuilder: (context, error, stackTrace) {
                                                  return Container(
                                                    width: 50.w,
                                                    height: 50.h,
                                                    color: Colors.grey[200],
                                                    child: Center(
                                                      child: Icon(Icons.broken_image, size: 25.w, color: Colors.grey),
                                                    ),
                                                  );
                                                },
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: 1.h),
                                        Padding(
                                          padding: EdgeInsets.symmetric(horizontal: 4.w),
                                          child: Text(
                                            itemName,
                                            style: TextStyle(fontSize: 10.sp, color: Colors.black87, fontWeight: FontWeight.bold),
                                            textAlign: TextAlign.center,
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                        SizedBox(height: 1.h),
                                        Text(
                                          priceInfo,
                                          style: TextStyle(fontSize: 9.sp, color: Colors.grey),
                                          textAlign: TextAlign.center,
                                        ),
                                      ],
                                    ),
                                    Positioned(
                                      top: 0,
                                      right: 0,
                                      child: GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            _orderList.removeAt(index);
                                          });
                                        },
                                        child: Container(
                                          decoration: const BoxDecoration(
                                            color: Colors.black54,
                                            shape: BoxShape.circle,
                                          ),
                                          padding: EdgeInsets.all(2.w),
                                          child: Icon(Icons.close, size: 14.sp, color: Colors.white),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
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
                          setState(() {
                            _orderList.clear();
                          });
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
                        onPressed: _orderList.isEmpty
                            ? null
                            : () {
                          _showSideMenuDialog();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          textStyle: TextStyle(fontSize: 20.sp),
                        ),
                        child: Text('결제하기'), // 총 금액 표시
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          // Help bubbles are added here, as children of the Stack.
          // They are only visible when _showHelpBubbles is true.
          if (_showHelpBubbles) ...[
            // Bubble 1: "음식 종류를 여기서 선택하세요"
            _buildHelpBubble(
              text: "음식 종류를 선택하세요",
              top: -5.h,
              left: 20.w,
            ),
            // Bubble 2: "종류를 고르셨다면 음식을 선택하세요"
            _buildHelpBubble(
              text: "종류를 고르셨다면 음식을 선택하세요",
              top: 350.h,
              right: 60.w,
            ),
            // Bubble 3: "고른 음식이 여기에 보여집니다"
            _buildHelpBubble(
              text: "선택한 음식들이 이곳에 보여집니다\nx를 누르면 주문을 취소할 수 있습니다",
              bottom: 80.h,
              left: 20.w,
            ),
          ],
        ],
      ),
    );
  }
}
