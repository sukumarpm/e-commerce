import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_1/services/navigation_service.dart';
import 'package:get_it/get_it.dart';
import 'package:ecommerce_1/screens/bottombar.dart';

class AddStockPage extends StatefulWidget {
  const AddStockPage({super.key});

  @override
  _AddStockPageState createState() => _AddStockPageState();
}

class _AddStockPageState extends State<AddStockPage> {
  final _formKey = GlobalKey<FormState>();
  String _productName = '';
  int _quantity = 0;
  double _price = 0.0;
  String _searchQuery = '';
  List<Map<String, dynamic>> _searchResults = [];

  void _saveStock() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      final querySnapshot = await FirebaseFirestore.instance
          .collection('stocks')
          .where('productName', isEqualTo: _productName)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        // Update existing stock
        final docId = querySnapshot.docs.first.id;
        final existingData = querySnapshot.docs.first.data();
        final updatedQuantity = existingData['quantity'] + _quantity;

        await FirebaseFirestore.instance
            .collection('stocks')
            .doc(docId)
            .update({
          'quantity': updatedQuantity,
          'price': _price, // Update price if needed
        });

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Stock updated successfully!')),
        );
      } else {
        // Add new stock
        await FirebaseFirestore.instance.collection('stocks').add({
          'productName': _productName,
          'quantity': _quantity,
          'price': _price,
        });

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Stock added successfully!')),
        );
      }

      // Clear form
      _formKey.currentState!.reset();
    }
  }

  void _searchProduct(String query) async {
    final results = await FirebaseFirestore.instance
        .collection('stocks')
        .where('productName', isGreaterThanOrEqualTo: query)
        .where('productName', isLessThanOrEqualTo: '$query\uf8ff')
        .get();

    setState(() {
      _searchResults = results.docs
          .map((doc) => {
                'id': doc.id,
                'productName': doc['productName'],
                'quantity': doc['quantity'],
                'price': doc['price'],
              })
          .toList();
    });
  }

  void _deleteProduct(String productId) async {
    // Check if there are open orders with this product
    final openOrders = await FirebaseFirestore.instance
        .collection('orders')
        .where('productId', isEqualTo: productId)
        .where('status',
            isEqualTo: 'open') // Assuming 'open' indicates active orders
        .get();

    if (openOrders.docs.isNotEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Cannot delete product with open orders!')),
      );
      return;
    }

    // Proceed to delete the product
    await FirebaseFirestore.instance
        .collection('stocks')
        .doc(productId)
        .delete();

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Product deleted successfully!')),
    );

    // Refresh search results
    _searchProduct(_searchQuery);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Stock'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              decoration: const InputDecoration(
                labelText: 'Search Product',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                setState(() {
                  _searchQuery = value;
                });
                _searchProduct(value);
              },
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: _searchResults.length,
                itemBuilder: (context, index) {
                  final product = _searchResults[index];
                  return ListTile(
                    title: Text(product['productName']),
                    subtitle: Text(
                        'Quantity: ${product['quantity']}, Price: \$${product['price']}'),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () => _deleteProduct(product['id']),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: Form(
                key: _formKey,
                child: ListView(
                  children: [
                    TextFormField(
                      decoration:
                          const InputDecoration(labelText: 'Product Name'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter product name';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _productName = value!;
                      },
                    ),
                    TextFormField(
                      decoration: const InputDecoration(labelText: 'Quantity'),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || int.tryParse(value) == null) {
                          return 'Please enter a valid quantity';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _quantity = int.parse(value!);
                      },
                    ),
                    TextFormField(
                      decoration: const InputDecoration(labelText: 'Price'),
                      keyboardType:
                          const TextInputType.numberWithOptions(decimal: true),
                      validator: (value) {
                        if (value == null || double.tryParse(value) == null) {
                          return 'Please enter a valid price';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _price = double.parse(value!);
                      },
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: _saveStock,
                      child: const Text('Save Stock'),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
