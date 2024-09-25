import 'package:flutter/material.dart';
import '../models/sales_transaction.dart';
import '../db/db_helper.dart';

class SalesProvider with ChangeNotifier {
  List<SalesTransaction> _salesTransactions = [];

  List<SalesTransaction> get salesTransactions => _salesTransactions;

  Future<void> fetchSalesTransactionsByDay(DateTime day) async {
    _salesTransactions = await DBHelper().getSalesTransactionsByDay(day);
    notifyListeners();
  }

  Future<void> fetchSalesTransactionsByMonth(DateTime month) async {
    _salesTransactions = await DBHelper().getSalesTransactionsByMonth(month);
    notifyListeners();
  }

  Future<void> addSalesTransaction(SalesTransaction transaction) async {
    await DBHelper().insertSalesTransaction(transaction);
    // Optionally: Fetch latest data to update UI
  }
}
