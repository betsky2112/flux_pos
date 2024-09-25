import 'dart:convert';
import 'package:http/http.dart' as http;

class PaymentService {
  static const String apiUrl = '/backend/backend.js';

  Future<void> startTransaction({
    required String productName,
    required double totalPrice,
    required int quantity,
  }) async {
    final response = await http.post(
      Uri.parse('$apiUrl/createTransaction'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'amount': totalPrice,
        'firstName': 'User',
        'lastName': 'Example',
        'email': 'user@example.com',
        'phone': '081234567890',
      }),
    );

    if (response.statusCode == 200) {
      // Handle successful transaction response
      print('Transaction data: ${json.decode(response.body)}');
      // Misalnya, membuka Snap Payment URL
    } else {
      throw Exception('Failed to create transaction');
    }
  }
}
