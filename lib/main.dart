import 'package:flutter/material.dart';
import 'package:easy_dynamic_theme/easy_dynamic_theme.dart';
import 'package:flux_pos/screens/product_screen.dart';
import 'package:provider/provider.dart';

import 'providers/product_provider.dart';
import 'providers/sales_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return EasyDynamicThemeWidget(
      child: Builder(
        builder: (context) {
          return MultiProvider(
            providers: [
              ChangeNotifierProvider(create: (_) => ProductProvider()),
              ChangeNotifierProvider(create: (_) => SalesProvider()),
            ],
            child: MaterialApp(
              theme: ThemeData.light(),
              darkTheme: ThemeData.dark(),
              themeMode: EasyDynamicTheme.of(context).themeMode,
              home: const ProductScreen(),
            ),
          );
        },
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Aplikasi Kasir'),
      ),
      body: const Center(child: Text('Selamat Datang!')),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          EasyDynamicTheme.of(context).changeTheme();
        },
        child: const Icon(Icons.brightness_6),
      ),
    );
  }
}
