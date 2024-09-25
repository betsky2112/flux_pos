import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/sales_provider.dart';
import '../models/sales_transaction.dart';
import 'package:intl/intl.dart';

class SalesReportScreen extends StatefulWidget {
  const SalesReportScreen({super.key});

  @override
  _SalesReportScreenState createState() => _SalesReportScreenState();
}

class _SalesReportScreenState extends State<SalesReportScreen> {
  DateTime _selectedDate = DateTime.now();
  bool _isMonthlyReport = false;

  void _pickDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
    );
    if (pickedDate != null && pickedDate != _selectedDate) {
      setState(() {
        _selectedDate = pickedDate;
      });
      if (_isMonthlyReport) {
        Provider.of<SalesProvider>(context, listen: false)
            .fetchSalesTransactionsByMonth(_selectedDate);
      } else {
        Provider.of<SalesProvider>(context, listen: false)
            .fetchSalesTransactionsByDay(_selectedDate);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Laporan Penjualan'),
        actions: [
          IconButton(
            icon: const Icon(Icons.calendar_today),
            onPressed: () => _pickDate(context),
          ),
          Switch(
            value: _isMonthlyReport,
            onChanged: (value) {
              setState(() {
                _isMonthlyReport = value;
                if (value) {
                  Provider.of<SalesProvider>(context, listen: false)
                      .fetchSalesTransactionsByMonth(_selectedDate);
                } else {
                  Provider.of<SalesProvider>(context, listen: false)
                      .fetchSalesTransactionsByDay(_selectedDate);
                }
              });
            },
            activeColor: Colors.white,
            inactiveThumbColor: Colors.grey,
          ),
        ],
      ),
      body: Consumer<SalesProvider>(
        builder: (context, salesProvider, child) {
          if (salesProvider.salesTransactions.isEmpty) {
            return const Center(child: Text('Belum ada transaksi untuk tanggal ini.'));
          }
          return ListView.builder(
            itemCount: salesProvider.salesTransactions.length,
            itemBuilder: (context, index) {
              final transaction = salesProvider.salesTransactions[index];
              return Card(
                margin: const EdgeInsets.all(10),
                child: ListTile(
                  title: Text(transaction.productName),
                  subtitle:
                      Text('Jumlah: ${transaction.quantity}, Total: Rp${transaction.totalPrice}'),
                  trailing: Text(DateFormat.yMMMd().format(transaction.date)),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
