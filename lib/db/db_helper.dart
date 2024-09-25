import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/product.dart';
import '../models/sales_transaction.dart';

class DBHelper {
  static final DBHelper _instance = DBHelper._internal();
  factory DBHelper() => _instance;
  DBHelper._internal();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB();
    return _database!;
  }

  _initDB() async {
    String path = join(await getDatabasesPath(), 'kasir_app.db');
    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE products (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        price REAL NOT NULL,
        stock INTEGER NOT NULL
      )
    ''');
  }

  // Insert Product
  Future<int> insertProduct(Product product) async {
    final db = await database;
    return await db.insert('products', product.toMap());
  }

  // Get All Products
  Future<List<Product>> getProducts() async {
    final db = await database;
    var result = await db.query('products');
    return result.map((data) => Product.fromMap(data)).toList();
  }

  // Update Product
  Future<int> updateProduct(Product product) async {
    final db = await database;
    return await db.update(
      'products',
      product.toMap(),
      where: 'id = ?',
      whereArgs: [product.id],
    );
  }

  // Delete Product
  Future<int> deleteProduct(int id) async {
    final db = await database;
    return await db.delete(
      'products',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // Insert Sales Transaction
  Future<int> insertSalesTransaction(SalesTransaction transaction) async {
    final db = await database;
    return await db.insert('sales_transactions', transaction.toMap());
  }

  // Get Sales Transactions by Day
  Future<List<SalesTransaction>> getSalesTransactionsByDay(DateTime day) async {
    final db = await database;
    String date = day.toIso8601String().substring(0, 10); // Only use YYYY-MM-DD
    var result = await db.query(
      'sales_transactions',
      where: 'date LIKE ?',
      whereArgs: ['%$date%'],
    );
    return result.map((data) => SalesTransaction.fromMap(data)).toList();
  }

  // Get Sales Transactions by Month
  Future<List<SalesTransaction>> getSalesTransactionsByMonth(DateTime month) async {
    final db = await database;
    String date = month.toIso8601String().substring(0, 7); // Only use YYYY-MM
    var result = await db.query(
      'sales_transactions',
      where: 'date LIKE ?',
      whereArgs: ['%$date%'],
    );
    return result.map((data) => SalesTransaction.fromMap(data)).toList();
  }
}
