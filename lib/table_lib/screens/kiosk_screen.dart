// lib/screens/kiosk_screen.dart
import 'package:flutter/material.dart';
import '../data/mock_data.dart';
import '../models/cart.dart';
import '../theme/colors.dart';
import '../widgets/cart_panel.dart';
import 'confirmation_screen.dart';
import '../models/product.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:provider/provider.dart';
import 'package:animate_do/animate_do.dart';
import '../providers/provider.dart';
import '../widgets/product_detail.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});
  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen>
    with TickerProviderStateMixin {
  final FlutterTts _flutterTts = FlutterTts();
  final List<CartItem> _cart = [];
  int _selectedCategoryId = 0;
  List<Product> _displayedProducts = [];
  bool _isLoading = false;
  final GlobalKey _cartIconKey = GlobalKey();

  // [수정 1] 각 상품의 고유한 키를 저장할 Map 변수 추가
  final Map<int, GlobalKey> _productKeys = {};
  OverlayEntry? _overlayEntry;

  @override
  void initState() {
    super.initState();
    _initializeTts();

    // [수정 2] 모든 메뉴에 대해 고유한 GlobalKey를 미리 생성합니다.
    for (var product in mockProducts) {
      _productKeys[product.id] = GlobalKey();
    }

    _updateDisplayedProducts();
  }

  @override
  void dispose() {
    _flutterTts.stop();
    super.dispose();
  }

  // --- 로직 함수들 ---
  void _initializeTts() async {
    await _flutterTts.setLanguage("ko-KR");
    await _flutterTts.setSpeechRate(0.5);
  }

  Future<void> _speak(String text) async {
    await _flutterTts.stop();
    await _flutterTts.speak(text);
  }

  void _onCategorySelected(int categoryId, String categoryName) async {
    setState(() => _isLoading = true);
    _speak("$categoryName 카테고리를 선택했습니다.");
    await Future.delayed(const Duration(milliseconds: 300));
    setState(() {
      _selectedCategoryId = categoryId;
      _updateDisplayedProducts();
      _isLoading = false;
    });
  }

  void _updateDisplayedProducts() {
    setState(() {
      if (_selectedCategoryId == 0) {
        _displayedProducts = mockProducts;
      } else {
        _displayedProducts = mockProducts
            .where((p) => p.categoryId == _selectedCategoryId)
            .toList();
      }
    });
  }

  void _addToCart(Product product) {
    setState(() {
      _speak("${product.name}을 장바구니에 담았습니다.");
      for (var item in _cart) {
        if (item.product.id == product.id) {
          item.quantity++;
          return;
        }
      }
      _cart.add(CartItem(product: product));
    });
  }

  void _updateCartItem(CartItem cartItem, int change) {
    setState(() {
      cartItem.quantity += change;
      if (cartItem.quantity <= 0) {
        _cart.remove(cartItem);
      }
    });
  }

  void _clearCart() {
    setState(() {
      _cart.clear();
    });
  }

  void _navigateToConfirmation() async {
    setState(() => _isLoading = true);
    await Future.delayed(const Duration(seconds: 1));
    setState(() => _isLoading = false);
    if (!mounted) return;

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            ConfirmationScreen(cart: _cart, onOrderConfirmed: _clearCart),
      ),
    );
  }

  void _showProductDetail(Product product) async {
    final result = await showDialog<bool>(
      context: context,
      builder: (context) =>
          ProductDetailDialog(product: product, tts: _flutterTts),
    );
    if (result == true) {
      _addToCart(product);
    }
  }

  void _showSettingsDialog() {
    final settings = Provider.of<SettingsProvider>(context, listen: false);
    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setDialogState) => AlertDialog(
          title: const Text('설정'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('글씨 크기 조절'),
              Slider(
                value: settings.fontScale,
                min: 0.8,
                max: 1.5,
                divisions: 7,
                label: settings.fontScale.toStringAsFixed(1),
                onChanged: (value) {
                  setDialogState(() {
                    settings.setFontScale(value);
                  });
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('닫기'),
            ),
          ],
        ),
      ),
    );
  }

  void _showHelpDialog() {
    const helpText =
        "1. 왼쪽 '카테고리'에서 메뉴 종류를 선택하세요.\n\n"
        "2. '메뉴'를 터치하여 장바구니에 담으세요.\n\n"
        "3. 오른쪽 '장바구니'에서 수량을 조절하거나 주문할 메뉴를 확인하세요.\n\n"
        "4. '주문하기'를 눌러 최종 확인 후 결제를 완료하세요.";
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('키오스크 사용법 안내'),
        content: const Text(helpText),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('확인'),
          ),
        ],
      ),
    );
  }

  // [추가] 장바구니 담기 애니메이션 실행 함수
  void _runAddToCartAnimation(GlobalKey productKey, Product product) {
    if (_cartIconKey.currentContext == null ||
        productKey.currentContext == null) {
      _addToCart(product); // 키를 찾을 수 없는 예외 상황에서는 애니메이션 없이 바로 추가
      return;
    }

    final RenderBox productRenderBox =
        productKey.currentContext!.findRenderObject() as RenderBox;
    final productPosition = productRenderBox.localToGlobal(Offset.zero);
    final RenderBox cartRenderBox =
        _cartIconKey.currentContext!.findRenderObject() as RenderBox;
    final cartPosition = cartRenderBox.localToGlobal(Offset.zero);

    final itemSize = productRenderBox.size;

    _overlayEntry?.remove();
    _overlayEntry = OverlayEntry(
      builder: (context) {
        return TweenAnimationBuilder(
          tween: Tween<double>(begin: 0.0, end: 1.0),
          duration: const Duration(milliseconds: 600),
          builder: (context, value, child) {
            final position = Offset.lerp(productPosition, cartPosition, value)!;
            final size = Size.lerp(itemSize, const Size(40, 40), value)!;
            return Positioned(
              left: position.dx,
              top: position.dy,
              child: Opacity(
                opacity: 1.0 - (value * 0.7),
                child: Material(
                  color: Colors.transparent,
                  child: Image.asset(
                    product.imagePath,
                    width: size.width,
                    height: size.height,
                  ),
                ),
              ),
            );
          },
        );
      },
    );

    Overlay.of(context).insert(_overlayEntry!);
    Future.delayed(const Duration(milliseconds: 600), () {
      _overlayEntry?.remove();
      _overlayEntry = null;
      _addToCart(product); // 애니메이션이 끝난 후 실제 장바구니에 아이템 추가
    });
  }

  // --- UI 구현 ---
  @override
  Widget build(BuildContext context) {
    final settings = Provider.of<SettingsProvider>(context);
    final fontScale = settings.fontScale;

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: Text(
          '테이블 오더',
          style: TextStyle(
            fontSize: 20 * fontScale,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: primaryColor,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.settings_outlined, color: Colors.white),
            onPressed: _showSettingsDialog,
            tooltip: '설정',
          ),
          IconButton(
            icon: const Icon(Icons.help_outline, color: Colors.white),
            onPressed: _showHelpDialog,
            tooltip: '도움말 보기',
          ),
        ],
      ),
      body: Stack(
        children: [
          Row(
            children: [
              _buildCategorySidebar(fontScale),
              const VerticalDivider(width: 1),
              Expanded(flex: 3, child: _buildProductGrid(fontScale)),
              const VerticalDivider(width: 1),
              Expanded(
                flex: 2,
                child: CartPanel(
                  cartIconKey: _cartIconKey,
                  cart: _cart,
                  onUpdateItem: _updateCartItem,
                  onClearCart: _clearCart,
                  onCheckout: _navigateToConfirmation,
                ),
              ),
            ],
          ),
          if (_isLoading)
            Container(
              color: Colors.black.withOpacity(0.5),
              child: const Center(
                child: CircularProgressIndicator(color: Colors.white),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildCategorySidebar(double fontScale) {
    return Container(
      width: 160,
      color: Colors.white,
      child: ListView.builder(
        itemCount: mockCategories.length,
        itemBuilder: (context, index) {
          final category = mockCategories[index];
          final isSelected = category['id'] == _selectedCategoryId;
          return Material(
            color: isSelected ? accentColor.withAlpha(26) : Colors.transparent,
            child: InkWell(
              onTap: () =>
                  _onCategorySelected(category['id'], category['name']),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 16.0,
                  horizontal: 12.0,
                ),
                decoration: BoxDecoration(
                  border: Border(
                    left: BorderSide(
                      color: isSelected ? accentColor : Colors.transparent,
                      width: 4,
                    ),
                  ),
                ),
                child: Text(
                  category['name']!,
                  style: TextStyle(
                    fontSize: 16 * fontScale,
                    fontWeight: isSelected
                        ? FontWeight.bold
                        : FontWeight.normal,
                    color: textColor,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildProductGrid(double fontScale) {
    final screenWidth = MediaQuery.of(context).size.width;
    final gridWidth = screenWidth * 3 / 5;
    final crossAxisCount = (gridWidth / 220).floor().clamp(2, 4);

    return GridView.builder(
      padding: const EdgeInsets.all(16.0),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: 16.0,
        mainAxisSpacing: 16.0,
        childAspectRatio: 0.8,
      ),
      itemCount: _displayedProducts.length,
      itemBuilder: (context, index) {
        final product = _displayedProducts[index];
        // [수정 3] 매번 새로 만들지 않고, Map에서 고유한 키를 가져옵니다.
        final productKey = _productKeys[product.id]!;

        return Bounce(
          duration: const Duration(milliseconds: 150),
          from: 5,
          child: InkWell(
            key: productKey, // 가져온 키를 위젯에 할당
            onTap: () => _runAddToCartAnimation(
              productKey,
              product,
            ), // 수정된 부분: 애니메이션 함수 호출
            child: Card(
              clipBehavior: Clip.antiAlias,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: Stack(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(
                        child: Image.asset(
                          product.imagePath,
                          fit: BoxFit.cover,
                          errorBuilder: (c, e, s) => const Icon(Icons.error),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          product.name,
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14 * fontScale,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: Text(
                          '${product.price}원',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                            fontSize: 14 * fontScale,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Positioned(
                    top: 4,
                    right: 4,
                    child: IconButton(
                      icon: const Icon(
                        Icons.info_outline,
                        color: Colors.white70,
                        shadows: [Shadow(color: Colors.black54, blurRadius: 4)],
                      ),
                      onPressed: () => _showProductDetail(product),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
