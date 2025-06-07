import 'package:ecommerce_1/screens/bottombar.dart';
import 'package:ecommerce_1/services/auth_service.dart';
import 'package:ecommerce_1/services/navigation_service.dart';
import 'package:ecommerce_1/widgets/mycontroller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late NavigationService _navigationService;
  final GetIt _getIt = GetIt.instance;
  late AuthService _auth;
  final MyController c = Get.put(MyController());
  String selectedCategory = 'All';
  List categoryImage = [
    {
      'icon': 'lib/assets/Home/Frame 1597884529 (1).png',
      'title': 'Suit',
      'price': '120.00',
    },
    {
      'icon': 'lib/assets/Home/Frame 1597884529 (2).png',
      'title': 'Shirts',
      'price': '85.00',
    },
    {
      'icon': 'lib/assets/Home/Frame 1597884529 (3).png',
      'title': 'Shorts',
      'price': '90.00',
    },
    {
      'icon': 'lib/assets/Home/Frame 1597884529 (4).png',
      'title': 'Inner',
      'price': '120.00',
    },
    {
      'icon': 'lib/assets/Home/Frame 1597884529 (5).png',
      'title': 'Shirts',
      'price': '85.00',
    },
    {
      'icon': 'lib/assets/Home/Frame 1597884529.png',
      'title': 'Shorts',
      'price': '90.00',
    },
    {
      'icon': 'lib/assets/big-tent.png',
      'title': 'All',
      'price': '90.00',
    },
  ];
  List<Map<dynamic, dynamic>> allproducts = [{}];
  List productImage = [
    {
      'icon': 'lib/assets/Home/Frame 1597884508 (1).png',
      'title': 'Suit',
      'price': '120.00',
      'productId': '1',
    },
    {
      'icon': 'lib/assets/Home/Frame 1597884508 (2).png',
      'title': 'Shirts',
      'price': '85.00',
      'productId': '2',
    },
    {
      'icon': 'lib/assets/Home/Frame 1597884508 (3).png',
      'title': 'Watch',
      'price': '90.00',
      'productId': '3',
    },
    {
      'icon': 'lib/assets/Home/Frame 1597884508 (4).png',
      'title': 'Inner',
      'price': '120.00',
      'productId': '4',
    },
    {
      'icon': 'lib/assets/Home/Frame 1597884508 (5).png',
      'title': 'Bijou',
      'price': '85.00',
      'productId': '5',
    },
    {
      'icon': 'lib/assets/Home/Frame 1597884508.png',
      'title': 'ArtBook',
      'price': '90.00',
      'productId': '6',
    },
    {
      'icon': 'lib/assets/Home/Frame 1597884508 (3).png',
      'title': 'Skirts',
      'price': '90.00',
      'productId': '7',
    },
    {
      'icon': 'lib/assets/Home/Frame 1597884508 (4).png',
      'title': 'Pillows',
      'price': '120.00',
      'productId': '8',
    },
    {
      'icon': 'lib/assets/Home/Frame 1597884508 (1).png',
      'title': 'Bikes',
      'price': '120.00',
      'productId': '9',
    },
    {
      'icon': 'lib/assets/Home/Frame 1597884508 (2).png',
      'title': 'cycle',
      'price': '85.00',
      'productId': '10',
    },
    {
      'icon': 'lib/assets/Home/Frame 1597884508 (3).png',
      'title': 'Books',
      'price': '90.00',
      'productId': '11',
    },
    {
      'icon': 'lib/assets/Home/Frame 1597884508 (4).png',
      'title': 'Pots',
      'price': '120.00',
      'productId': '12',
    },
    {
      'icon': 'lib/assets/Home/Frame 1597884508 (5).png',
      'title': 'Ironbox',
      'price': '85.00',
      'productId': '13',
    },
    {
      'icon': 'lib/assets/Home/Frame 1597884508.png',
      'title': 'Medicine',
      'price': '90.00',
      'productId': '14',
    },
  ];
  Map<String, String> productCategories = {
    'Electronics':
        'https://via.placeholder.com/150/0000FF/808080?text=Electronics',
    'Fashion': 'https://via.placeholder.com/150/FF0000/FFFFFF?text=Fashion',
    'Home Appliances':
        'https://via.placeholder.com/150/00FF00/000000?text=Home+Appliances',
    'Books': 'https://via.placeholder.com/150/FFFF00/000000?text=Books',
    'Toys': 'https://via.placeholder.com/150/FF00FF/FFFFFF?text=Toys',
    'Sports': 'https://via.placeholder.com/150/00FFFF/000000?text=Sports',
    'Groceries': 'https://via.placeholder.com/150/FFA500/FFFFFF?text=Groceries',
    'Beauty': 'https://via.placeholder.com/150/800080/FFFFFF?text=Beauty',
    'Accessories':
        'https://via.placeholder.com/150/008080/FFFFFF?text=Accessories',
  };
  List filteredproductImage = [];
  late double _deviceHeight;
  late double _deviceWidth;

  @override
  void initState() {
    super.initState();

    _auth = _getIt<AuthService>();
    _navigationService = _getIt<NavigationService>();
    allproducts = c.productData;
    filteredproductImage = allproducts;
    Map<String, String> uniqueProductTypes = {};
    for (var product in allproducts) {
      if (product.containsKey('productType') &&
          product['productType'] != null) {
        uniqueProductTypes[product['productType']] = product['productType'];
      }
    }
    print('uniqueProductTypes: $uniqueProductTypes');
  }

  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      // appBar: AppBar(
      //   title: Column(
      //     children: [
      //       Image.asset(
      //         'lib/assets/logo/LogoBlack.png',
      //         fit: BoxFit.cover,
      //         width: 50,
      //         height: 50,
      //       ),
      //     ],
      //   ),
      //   centerTitle: true,
      // ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Location',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'Nellai,654098',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                    Icon(Icons.location_on)
                  ]),
              const SizedBox(height: 16),
              // Search Box and Filter Button
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      onChanged: (value) {
                        setState(() {
                          filteredproductImage = allproducts
                              .where((product) => product['name']
                                  .toLowerCase()
                                  .contains(value.toLowerCase()))
                              .toList();
                        });
                      },
                      onSubmitted: (value) {
                        setState(() {
                          filteredproductImage = allproducts
                              .where((product) => product['name']
                                  .toLowerCase()
                                  .contains(value.toLowerCase()))
                              .toList();
                        });
                      },
                      decoration: InputDecoration(
                        hintText: 'Search products...',
                        prefixIcon: const Icon(Icons.search),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  ElevatedButton.icon(
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
                                    items: [
                                      'Red',
                                      'Blue',
                                      'Green',
                                      'Black',
                                      'White'
                                    ]
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
                                    items:
                                        ['Cotton', 'Polyester', 'Silk', 'Wool']
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
                                    items: [
                                      '\$0-\$50',
                                      '\$51-\$100',
                                      '\$101-\$200'
                                    ]
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
                                    items: [
                                      '1 Star',
                                      '2 Stars',
                                      '3 Stars',
                                      '4 Stars',
                                      '5 Stars'
                                    ]
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
                                child: const Text('Apply',
                                    style: TextStyle(
                                      color: Colors.black54,
                                    )),
                              ),
                            ],
                          );
                        },
                      );
                      // Handle filter action
                    },
                    icon: const Icon(Icons.filter_list),
                    label: const Text('Filter'),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              // Filter Chips
              Wrap(
                spacing: 8.0,
                children: [
                  FilterChip(
                    label: const Text('All'),
                    selected: selectedCategory == 'All',
                    labelStyle: TextStyle(
                      color: selectedCategory == 'All'
                          ? Colors.white
                          : Colors.black,
                    ),
                    onSelected: (bool selected) {
                      setState(() {
                        selectedCategory = 'All';
                        filteredproductImage = allproducts;
                      });
                    },
                  ),
                  ...productCategories.keys.map((category) {
                    return FilterChip(
                      label: Text(category),
                      selected: selectedCategory == category,
                      labelStyle: TextStyle(
                        color: selectedCategory == category
                            ? Colors.white
                            : Colors.black,
                      ),
                      onSelected: (bool selected) {
                        setState(() {
                          selectedCategory = category;
                          filteredproductImage = allproducts
                              .where((product) =>
                                  product['productType'] == category)
                              .toList();
                        });
                      },
                    );
                  }),
                ],
              ),
              const SizedBox(height: 16),
              // Horizontal Scrollable ListView
              // const Text(
              //   'Categories',
              //   style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              // ),
              // const SizedBox(height: 8),
              // SizedBox(
              //   height: 110,
              //   child: ListView.builder(
              //     scrollDirection: Axis.horizontal,
              //     itemCount: categoryImage.length,
              //     itemBuilder: (context, index) {
              //       return GestureDetector(
              //         onTap: () {
              //           setState(() {
              //             if (categoryImage[index]['title'] != 'All') {
              //               filteredproductImage = allproducts
              //                   .where((product) =>
              //                       product['name'] ==
              //                       categoryImage[index]['title'])
              //                   .toList();
              //             } else {
              //               filteredproductImage = allproducts;
              //             }
              //             selectedCategory = categoryImage[index]['title'];
              //           });
              //         },
              //         child: Container(
              //           width: 90,
              //           margin: const EdgeInsets.only(right: 8.0),
              //           decoration: BoxDecoration(
              //             color:
              //                 selectedCategory == categoryImage[index]['title']
              //                     ? Colors.black38.withOpacity(0.2)
              //                     : Colors.transparent,
              //             borderRadius: BorderRadius.circular(8.0),
              //           ),
              //           child: Center(
              //             child: Column(
              //               children: [
              //                 Image.asset(categoryImage[index]['icon'],
              //                     width: 80, height: 80),
              //                 const SizedBox(height: 8),
              //                 Text(
              //                   '${categoryImage[index]['title']}',
              //                   style: GoogleFonts.poppins(
              //                     fontSize: 12,
              //                     fontWeight: FontWeight.w500,
              //                   ),
              //                   textAlign: TextAlign.center,
              //                 ),
              //               ],
              //             ),
              //           ),
              //         ),
              //       );
              //     },
              //   ),
              // ),
              // const SizedBox(height: 16),
              // Vertical Scrollable GridView
              const Text(
                'Products',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              // Expanded(
              //   child: GridView.builder(
              //     gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              //       crossAxisCount: 2,
              //       crossAxisSpacing: 8.0,
              //       mainAxisSpacing: 8.0,
              //       childAspectRatio: (100 / 150),
              //     ),
              //     itemCount: filteredproductImage.length,
              //     itemBuilder: (context, index) {
              //       return SizedBox(
              //         height: _deviceHeight * 0.45,
              //         width: _deviceWidth * 0.45,
              //         child: Card(
              //           elevation: 4,
              //           shape: RoundedRectangleBorder(
              //             borderRadius: BorderRadius.circular(8.0),
              //           ),
              //           child: Column(
              //             crossAxisAlignment: CrossAxisAlignment.center,
              //             children: [
              //               Expanded(
              //                 child: GestureDetector(
              //                   child: ClipRRect(
              //                     borderRadius: const BorderRadius.vertical(
              //                       top: Radius.circular(8.0),
              //                     ),
              //                     child: Image.asset(
              //                       filteredproductImage[index]['icon'],
              //                       fit: BoxFit.cover,
              //                     ),
              //                   ),
              //                   onTap: () {
              //                     print(filteredproductImage[index]
              //                         .runtimeType); //
              //                     Get.find<MyController>().currentproduct =
              //                         filteredproductImage[index];
              //                     _navigationService.pushNamed("/viewproduct");
              //                   },
              //                 ),
              //               ),
              //               Padding(
              //                 padding: const EdgeInsets.all(8.0),
              //                 child: Column(
              //                   crossAxisAlignment: CrossAxisAlignment.start,
              //                   children: [
              //                     Text(
              //                       filteredproductImage[index]['title'],
              //                       style: GoogleFonts.poppins(
              //                         fontSize: 14,
              //                         fontWeight: FontWeight.bold,
              //                       ),
              //                     ),
              //                     const SizedBox(height: 4),
              //                     Text(
              //                       '\$${filteredproductImage[index]['price']}',
              //                       style: GoogleFonts.poppins(
              //                         fontSize: 12,
              //                         color: Colors.grey[600],
              //                       ),
              //                     ),
              //                   ],
              //                 ),
              //               ),
              //             ],
              //           ),
              //         ),
              //       );
              //     },
              //   ),
              // ),
              Expanded(
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 8.0,
                    mainAxisSpacing: 8.0,
                    childAspectRatio: (100 / 150),
                  ),
                  itemCount: filteredproductImage.length,
                  itemBuilder: (context, index) {
                    return SizedBox(
                      height: _deviceHeight * 0.45,
                      width: _deviceWidth * 0.45,
                      child: Card(
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: GestureDetector(
                                child: ClipRRect(
                                  borderRadius: const BorderRadius.vertical(
                                    top: Radius.circular(8.0),
                                  ),
                                  child: Image.asset(
                                    // filteredproductImage[index]['icon'],
                                    filteredproductImage[index]['imageurl'] ??
                                        '',
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                onTap: () {
                                  print(filteredproductImage[index]
                                      .runtimeType); //
                                  Get.find<MyController>().currentproduct =
                                      filteredproductImage[index];
                                  _navigationService.pushNamed("/viewproduct");
                                },
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    filteredproductImage[index]['name'] ?? '',
                                    style: GoogleFonts.poppins(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    '\$${filteredproductImage[index]['price'] ?? '0.00'}',
                                    style: GoogleFonts.poppins(
                                      fontSize: 12,
                                      color: Colors.grey[600],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: 0,
        onTap: (index) {
          if (index == 0) {
            _navigationService.pushReplacedNamed("/home");
          } else if (index == 1) {
            _navigationService.pushReplacedNamed("/categories");
          } else if (index == 2) {
            _navigationService.pushReplacedNamed("/mycart");
          } else if (index == 3) {
            _navigationService.pushNamed("/userprofile");
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _navigationService.pushNamed("/addproduct");
        },
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
