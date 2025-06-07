import 'package:ecommerce_1/classes/cartlists.dart';
import 'package:ecommerce_1/services/navigation_service.dart';
import 'package:ecommerce_1/widgets/mycontroller.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_it/get_it.dart';

class ViewProduct extends StatefulWidget {
  const ViewProduct({super.key});

  @override
  _ViewProductState createState() => _ViewProductState();
}

class _ViewProductState extends State<ViewProduct> {
  int _currentImageIndex = 0;
  bool _isLiked = false;
  String _selectedSize = '';
  late NavigationService _navigationService;
  final GetIt _getIt = GetIt.instance;
  final MyController c = Get.put(MyController());
  late final Map<dynamic, dynamic> productdetails;
  final List<String> _images = [
    'https://via.placeholder.com/400',
    'https://via.placeholder.com/400',
    'https://via.placeholder.com/400',
  ];
  final List<String> _sizes = ['S', 'M', 'L', 'XL'];
  final bool _inStock = true;
  final double _price = 49.99;
  late double _quantity = 1;
  late double _deviceHeight;
  late double _deviceWidth;
  late List<Cartlists> fullcartListL;

  @override
  initState() {
    super.initState();
    _currentImageIndex = 0;
    _isLiked = false;
    _selectedSize = '';
    productdetails = c.currentproduct;
    fullcartListL = c.fullcartList;
    print(productdetails);
    _navigationService = _getIt<NavigationService>();
  }

  Future<void> addToCart() async {
    bool productExists = false;
    print('productId: ${productdetails['productId'].runtimeType}');
    try {
      final productDoc = await FirebaseFirestore.instance
          .collection('stock')
          .doc(productdetails['productId'].toString())
          .get();

      if (productDoc.exists) {
        print('Product found: ${productDoc.data()}');
        final availableStock = productDoc.data()?['quantity'] ?? 0;

        if (availableStock >= _quantity) {
          // Add the product to the cart list

          for (var item in fullcartListL) {
            if (item.productId == productdetails['productId'].toString()) {
              productExists = true;
              item.qty = item.qty! + _quantity; // Update the quantity
              break;
            }
          }
          print('imageurl: ${productdetails['imageurl'].runtimeType}');
          print('productId: ${productdetails['productId'].runtimeType}');
          print('price: ${productdetails['price'].runtimeType}');
          print('description: ${productdetails['name'].runtimeType}');
          if (!productExists) {
            fullcartListL.add(Cartlists(
              icon: productdetails['imageurl'],
              title: productdetails['name'],
              price: productdetails['price'],
              productId: productdetails['productId'],
              qty: _quantity,
            ));
          } else {
            Get.snackbar('Info', 'Product quantity updated in the cart.');
          }
          for (var element in fullcartListL) {
            print('title:${element.title}');
            print('price:${element.price}');
            print('productId:${element.productId}');
            print('icon:${element.icon}');
            print('qty:${element.qty}');
          }

          Get.find<MyController>().fullcartList = fullcartListL;
          _navigationService.pushNamed("/mycart");
          Get.snackbar('Success', 'Product added to cart successfully!');
        } else {
          Get.snackbar('Error', 'Not enough stock available.');
        }
      } else {
        Get.snackbar('Error', 'Product not found.');
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to add product to cart: $e');
      print('Error adding product to cart: $e');
    }
  }

  Future<void> addtocartA() async {
    // fullcartListL.add(Cartlists(
    //   icon: productdetails['icon'],
    //   title: productdetails['title'],
    //   price: productdetails['price'],
    //   productId: productdetails['productId'],
    //   qty: _quantity,
    // ));
    bool productExists = false;
    for (var item in fullcartListL) {
      if (item.productId == productdetails['productId']) {
        productExists = true;
        item.qty = item.qty! + _quantity; // Update the quantity
        break;
      }
    }
    if (!productExists) {
      fullcartListL.add(Cartlists(
        icon: productdetails['icon'],
        title: productdetails['title'],
        price: productdetails['price'],
        productId: productdetails['productId'],
        qty: _quantity,
      ));
    } else {
      Get.snackbar('Info', 'Product quantity updated in the cart.');
    }
    for (var element in fullcartListL) {
      print('title:${element.title}');
      print('price:${element.price}');
      print('productId:${element.productId}');
      print('icon:${element.icon}');
      print('qty:${element.qty}');
    }

    Get.find<MyController>().fullcartList = fullcartListL;
    _navigationService.pushNamed("/mycart");
  }

  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'Product Details',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                CarouselSlider(
                  items: _images
                      .map(
                        (image) => Image.asset(
                          productdetails['imageurl'] ??
                              'lib/assets/Home/Frame 1597884508 (4).png',
                          fit: BoxFit.contain,
                        ),
                      )
                      .toList(),
                  options: CarouselOptions(
                    height: _deviceHeight * 0.40,
                    viewportFraction: 1.0,
                    onPageChanged: (index, reason) {
                      setState(() {
                        _currentImageIndex = index;
                      });
                    },
                  ),
                ),
                Positioned(
                  top: 10,
                  right: 10,
                  child: IconButton(
                    icon: Icon(
                      _isLiked ? Icons.favorite : Icons.favorite_border,
                      color: _isLiked ? Colors.red : Colors.grey,
                    ),
                    onPressed: () {
                      setState(() {
                        _isLiked = !_isLiked;
                      });
                    },
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: _images.asMap().entries.map((entry) {
                return GestureDetector(
                  onTap: () => setState(() {
                    _currentImageIndex = entry.key;
                  }),
                  child: Container(
                    width: 8.0,
                    height: 8.0,
                    margin: const EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 4.0),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: _currentImageIndex == entry.key
                          ? Colors.blue
                          : Colors.grey,
                    ),
                  ),
                );
              }).toList(),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    productdetails['name'] ?? 'Default Title',
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    productdetails['description'] ?? 'Default description',
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Select Size',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8.0,
                    children: _sizes.map((size) {
                      return ChoiceChip(
                        label: Text(size),
                        selected: _selectedSize == size,
                        onSelected: (selected) {
                          setState(() {
                            _selectedSize = selected ? size : '';
                          });
                        },
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    _inStock ? 'In Stock' : 'Out of Stock',
                    style: TextStyle(
                      fontSize: 16,
                      color: _inStock ? Colors.green : Colors.red,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    '\$${(productdetails['price'] != null ? double.tryParse(productdetails['price']!.toString()) ?? 0.00 : 0.00).toStringAsFixed(2)}',
                    style: const TextStyle(
                        fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  DropdownButton<int>(
                    value: _quantity.toInt(),
                    items: List.generate(
                      10,
                      (index) => DropdownMenuItem<int>(
                        value: index + 1,
                        child: Text('${index + 1}'),
                      ),
                    ),
                    onChanged: (value) {
                      setState(() {
                        // Handle the selected value here
                        _quantity = value!.toDouble();
                        print('Selected quantity: $value');
                      });
                    },
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: _deviceWidth * 0.6,
                        height: 50,
                        child: ElevatedButton.icon(
                          onPressed: _inStock
                              ? () {
                                  // Add to cart logic
                                  if (_selectedSize.isEmpty) {
                                    Get.snackbar('Error',
                                        'Please select a size before adding to cart.');
                                  } else {
                                    addToCart();

                                    if (kDebugMode) {
                                      print('c.cart: ${c.cart}');
                                    }
                                  }
                                }
                              : null,
                          icon: const Icon(Icons.shopping_cart),
                          label: const Text('Add to Cart'),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.share),
                        onPressed: () {
                          // Share product logic
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
