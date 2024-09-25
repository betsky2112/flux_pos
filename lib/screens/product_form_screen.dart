import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/product.dart';
import '../providers/product_provider.dart';

class ProductFormScreen extends StatefulWidget {
  final Product? product;

  const ProductFormScreen({super.key, this.product});

  @override
  _ProductFormScreenState createState() => _ProductFormScreenState();
}

class _ProductFormScreenState extends State<ProductFormScreen> {
  final _formKey = GlobalKey<FormState>();
  late String _name;
  late double _price;
  late int _stock;

  @override
  void initState() {
    if (widget.product != null) {
      _name = widget.product!.name;
      _price = widget.product!.price;
      _stock = widget.product!.stock;
    } else {
      _name = '';
      _price = 0;
      _stock = 0;
    }
    super.initState();
  }

  void _saveForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      if (widget.product != null) {
        // Update produk yang ada
        Provider.of<ProductProvider>(context, listen: false).updateProduct(
          Product(
            id: widget.product!.id,
            name: _name,
            price: _price,
            stock: _stock,
          ),
        );
      } else {
        // Tambahkan produk baru
        Provider.of<ProductProvider>(context, listen: false).addProduct(
          Product(
            name: _name,
            price: _price,
            stock: _stock,
          ),
        );
      }
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.product == null ? 'Tambah Produk' : 'Edit Produk'),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: _saveForm,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                initialValue: _name,
                decoration: const InputDecoration(labelText: 'Nama Produk'),
                textInputAction: TextInputAction.next,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Masukkan nama produk';
                  }
                  return null;
                },
                onSaved: (value) {
                  _name = value!;
                },
              ),
              TextFormField(
                initialValue: _price.toString(),
                decoration: const InputDecoration(labelText: 'Harga Produk'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (double.tryParse(value!) == null) {
                    return 'Masukkan harga yang valid';
                  }
                  return null;
                },
                onSaved: (value) {
                  _price = double.parse(value!);
                },
              ),
              TextFormField(
                initialValue: _stock.toString(),
                decoration: const InputDecoration(labelText: 'Stok Produk'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (int.tryParse(value!) == null) {
                    return 'Masukkan stok yang valid';
                  }
                  return null;
                },
                onSaved: (value) {
                  _stock = int.parse(value!);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
