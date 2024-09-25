import 'package:flutter/material.dart';
import 'package:flux_pos/screens/product_form_screen.dart';
import 'package:provider/provider.dart';
import '../providers/product_provider.dart';
import '../models/product.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Manajemen Produk'),
      ),
      body: Consumer<ProductProvider>(
        builder: (context, productProvider, child) {
          return productProvider.products.isEmpty
              ? const Center(child: Text('Belum ada produk.'))
              : ListView.builder(
                  itemCount: productProvider.products.length,
                  itemBuilder: (context, index) {
                    final product = productProvider.products[index];
                    return Card(
                      margin: const EdgeInsets.all(10),
                      elevation: 5,
                      child: ListTile(
                        contentPadding: const EdgeInsets.all(15),
                        title: Text(
                          product.name,
                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Harga: Rp${product.price.toStringAsFixed(0)}'),
                            Text('Stok: ${product.stock}'),
                          ],
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.edit),
                              onPressed: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => ProductFormScreen(product: product),
                                  ),
                                );
                              },
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete),
                              onPressed: () {
                                Provider.of<ProductProvider>(context, listen: false)
                                    .deleteProduct(product.id!);
                              },
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Logika Tambah Produk
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => const ProductFormScreen()),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
