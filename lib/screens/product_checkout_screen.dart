import 'package:flutter/material.dart';
import '../services/payment_service.dart';

class ProductCheckoutScreen extends StatelessWidget {
  final String productName;
  final double totalPrice;
  final int quantity;

  const ProductCheckoutScreen({
    super.key,
    required this.productName,
    required this.totalPrice,
    required this.quantity,
  });

  void _startPayment() async {
    try {
      await PaymentService().startTransaction(
        productName: productName,
        totalPrice: totalPrice,
        quantity: quantity,
      );
      // Notifikasi transaksi berhasil
    } catch (error) {
      // Notifikasi error
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Checkout')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text('Produk: $productName'),
            Text('Harga: Rp$totalPrice'),
            Text('Jumlah: $quantity'),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _startPayment,
              child: const Text('Bayar Sekarang'),
            ),
          ],
        ),
      ),
    );
  }
}
