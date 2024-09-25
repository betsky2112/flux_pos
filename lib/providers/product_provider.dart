import 'package:flutter/material.dart';
import '../models/product.dart';
import '../db/db_helper.dart';

class ProductProvider with ChangeNotifier {
  List<Product> _products = [];

  List<Product> get products => _products;

  Future<void> fetchProducts() async {
    _products = await DBHelper().getProducts();
    notifyListeners();
  }

  Future<void> addProduct(Product product) async {
    await DBHelper().insertProduct(product);
    await fetchProducts();
  }

  Future<void> updateProduct(Product product) async {
    await DBHelper().updateProduct(product);
    await fetchProducts();
  }

  Future<void> deleteProduct(int id) async {
    await DBHelper().deleteProduct(id);
    await fetchProducts();
  }
}
