// lib/models/confirmation_screen.dart
import 'package:flutter/material.dart';
import '../models/cart.dart';
import 'receipt_screen.dart'; // 영수증 화면 import
import '../theme/colors.dart';

class ConfirmationScreen extends StatefulWidget {
  final List<CartItem> cart;
  final Function onOrderConfirmed;

  const ConfirmationScreen({
    super.key,
    required this.cart,
    required this.onOrderConfirmed,
  });

  @override
  State<ConfirmationScreen> createState() => _ConfirmationScreenState();
}

class _ConfirmationScreenState extends State<ConfirmationScreen> {
  bool _isLoading = false;

  int get _totalPrice {
    return widget.cart.fold(0, (sum, item) => sum + item.totalPrice);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('주문 확인', style: TextStyle(color: Colors.white)),
        backgroundColor: primaryColor,
      ),
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: widget.cart.length,
                  itemBuilder: (context, index) {
                    final item = widget.cart[index];
                    return ListTile(
                      leading: Image.asset(
                        item.product.imagePath,
                        width: 50,
                        height: 50,
                        fit: BoxFit.cover,
                      ),
                      title: Text(
                        item.product.name,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(item.product.description),
                      trailing: Text(
                        '${item.quantity}개  ${item.totalPrice}원',
                        style: const TextStyle(fontSize: 16),
                      ),
                    );
                  },
                ),
              ),
              const Divider(height: 1, thickness: 2),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '최종 결제금액',
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '$_totalPrice원',
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: accentColor,
                    foregroundColor: Colors.black,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 40,
                      vertical: 20,
                    ),
                    textStyle: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                    minimumSize: const Size(double.infinity, 50),
                  ),
                  onPressed: _showPaymentDialog,
                  child: const Text('결제하기'),
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

  void _showPaymentDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: const Text('결제 수단 선택'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.credit_card),
              title: const Text('카드 결제'),
              onTap: () => _processOrder(context),
            ),
            ListTile(
              leading: const Icon(Icons.qr_code),
              title: const Text('페이 결제'),
              onTap: () => _processOrder(context),
            ),
          ],
        ),
      ),
    );
  }

  void _processOrder(BuildContext dialogContext) async {
    Navigator.of(dialogContext).pop();
    setState(() => _isLoading = true);
    await Future.delayed(const Duration(seconds: 2));
    if (!mounted) return;
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => ReceiptScreen(
          cart: widget.cart,
          totalPrice: _totalPrice,
          onConfirmed: widget.onOrderConfirmed,
        ),
      ),
    );
  }
}
