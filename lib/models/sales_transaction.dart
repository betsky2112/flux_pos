class SalesTransaction {
  int? id;
  String productName;
  double totalPrice;
  int quantity;
  DateTime date;

  SalesTransaction({
    this.id,
    required this.productName,
    required this.totalPrice,
    required this.quantity,
    required this.date,
  });

  // Convert SalesTransaction object to Map for SQLite
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'productName': productName,
      'totalPrice': totalPrice,
      'quantity': quantity,
      'date': date.toIso8601String(),
    };
  }

  // Convert Map to SalesTransaction object
  factory SalesTransaction.fromMap(Map<String, dynamic> map) {
    return SalesTransaction(
      id: map['id'],
      productName: map['productName'],
      totalPrice: map['totalPrice'],
      quantity: map['quantity'],
      date: DateTime.parse(map['date']),
    );
  }
}
