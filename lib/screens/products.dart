import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({super.key});

  @override
  _ProductsScreenState createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  final List<Map<String, dynamic>> _products = List.generate(10, (index) {
    return {
      'image': 'lib/assets/1000039563.jpg',
      'description': 'Product $index',
      'price': '\$${(index + 1) * 10}',
      'liked': false,
    };
  });

  void _loadMoreProducts() {
    print('Loading more products...');
    setState(() {
      _products.addAll(List.generate(10, (index) {
        return {
          'image': 'lib/assets/1000039563.jpg',
          'description': 'Product ${_products.length + index}',
          'price': '\$${(_products.length + index + 1) * 10}',
          'liked': false,
        };
      }));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Products'),
        actions: [
          ElevatedButton(
            onPressed: () {},
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.sort),
                  onPressed: () {
                    // Handle sort action
                  },
                ),
                const Text('Sort'),
              ],
            ),
          ),
          const SizedBox(width: 8.0),
          ElevatedButton(
            onPressed: () {},
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.filter_list),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        String? selectedSize;
                        String? selectedBrand;
                        String? selectedColor;
                        String? selectedGender;
                        String? selectedFabric;
                        String? selectedFit;
                        String? selectedPrice;
                        String? selectedRating;

                        return AlertDialog(
                          title: const Text('Filter Products'),
                          content: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text('Size'),
                                DropdownButton<String>(
                                  value: selectedSize,
                                  isExpanded: true,
                                  items: ['S', 'M', 'L', 'XL', 'XXL']
                                      .map((size) => DropdownMenuItem(
                                            value: size,
                                            child: Text(size),
                                          ))
                                      .toList(),
                                  onChanged: (value) {
                                    setState(() {
                                      selectedSize = value;
                                    });
                                  },
                                ),
                                const Text('Brand'),
                                DropdownButton<String>(
                                  value: selectedBrand,
                                  isExpanded: true,
                                  items: ['Brand A', 'Brand B', 'Brand C']
                                      .map((brand) => DropdownMenuItem(
                                            value: brand,
                                            child: Text(brand),
                                          ))
                                      .toList(),
                                  onChanged: (value) {
                                    setState(() {
                                      selectedBrand = value;
                                    });
                                  },
                                ),
                                const Text('Color'),
                                DropdownButton<String>(
                                  value: selectedColor,
                                  isExpanded: true,
                                  items: ['Red', 'Blue', 'Green', 'Black', 'White']
                                      .map((color) => DropdownMenuItem(
                                            value: color,
                                            child: Text(color),
                                          ))
                                      .toList(),
                                  onChanged: (value) {
                                    setState(() {
                                      selectedColor = value;
                                    });
                                  },
                                ),
                                const Text('Gender'),
                                DropdownButton<String>(
                                  value: selectedGender,
                                  isExpanded: true,
                                  items: ['Male', 'Female', 'Unisex']
                                      .map((gender) => DropdownMenuItem(
                                            value: gender,
                                            child: Text(gender),
                                          ))
                                      .toList(),
                                  onChanged: (value) {
                                    setState(() {
                                      selectedGender = value;
                                    });
                                  },
                                ),
                                const Text('Fabric'),
                                DropdownButton<String>(
                                  value: selectedFabric,
                                  isExpanded: true,
                                  items: ['Cotton', 'Polyester', 'Silk', 'Wool']
                                      .map((fabric) => DropdownMenuItem(
                                            value: fabric,
                                            child: Text(fabric),
                                          ))
                                      .toList(),
                                  onChanged: (value) {
                                    setState(() {
                                      selectedFabric = value;
                                    });
                                  },
                                ),
                                const Text('Fit'),
                                DropdownButton<String>(
                                  value: selectedFit,
                                  isExpanded: true,
                                  items: ['Slim', 'Regular', 'Loose']
                                      .map((fit) => DropdownMenuItem(
                                            value: fit,
                                            child: Text(fit),
                                          ))
                                      .toList(),
                                  onChanged: (value) {
                                    setState(() {
                                      selectedFit = value;
                                    });
                                  },
                                ),
                                const Text('Price'),
                                DropdownButton<String>(
                                  value: selectedPrice,
                                  isExpanded: true,
                                  items: ['\$0-\$50', '\$51-\$100', '\$101-\$200']
                                      .map((price) => DropdownMenuItem(
                                            value: price,
                                            child: Text(price),
                                          ))
                                      .toList(),
                                  onChanged: (value) {
                                    setState(() {
                                      selectedPrice = value;
                                    });
                                  },
                                ),
                                const Text('Rating'),
                                DropdownButton<String>(
                                  value: selectedRating,
                                  isExpanded: true,
                                  items: ['1 Star', '2 Stars', '3 Stars', '4 Stars', '5 Stars']
                                      .map((rating) => DropdownMenuItem(
                                            value: rating,
                                            child: Text(rating),
                                          ))
                                      .toList(),
                                  onChanged: (value) {
                                    setState(() {
                                      selectedRating = value;
                                    });
                                  },
                                ),
                              ],
                            ),
                          ),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: const Text('Cancel'),
                            ),
                            TextButton(
                              onPressed: () {
                                // Apply filters logic here
                                Navigator.of(context).pop();
                              },
                              child: const Text('Apply'),
                            ),
                          ],
                        );
                      },
                    );
                    // Handle filter action
                  },
                ),
                const Text('Filter'),
              ],
            ),
          ),
          const SizedBox(width: 8.0),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(8.0),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 8.0,
                mainAxisSpacing: 8.0,
                childAspectRatio: 0.7,
              ),
              itemCount: _products.length,
              itemBuilder: (context, index) {
                final product = _products[index];
                return Card(
                  elevation: 4.0,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Stack(
                        children: [
                          Image.asset(
                            product['image'],
                            width: double.infinity,
                            height: 150,
                            fit: BoxFit.cover,
                          ),
                          //   SvgPicture.asset(
                          //   'lib/assets/Group 41.svg',
                          //   width: double.infinity,
                          //   height: 150,
                          // ),
                          Positioned(
                            left: 130,
                            top: 0,
                            child: IconButton(
                              icon: Icon(
                                product['liked']
                                    ? Icons.favorite
                                    : Icons.favorite_border,
                                color:
                                    product['liked'] ? Colors.red : Colors.grey,
                              ),
                              onPressed: () {
                                setState(() {
                                  product['liked'] = !product['liked'];
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          product['description'],
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text(
                          product['price'],
                          style: const TextStyle(color: Colors.green),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          ElevatedButton(
            onPressed: _loadMoreProducts,
            child: const Text('Load More'),
          ),
        ],
      ),
    );
  }
}
