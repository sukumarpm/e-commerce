import 'package:ecommerce_1/screens/bottombar.dart';
import 'package:ecommerce_1/services/navigation_service.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class CategoriesPage extends StatefulWidget {
  const CategoriesPage({super.key});

  @override
  State<CategoriesPage> createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesPage> {
  late NavigationService _navigationService;
  final GetIt _getIt = GetIt.instance;
  final List<String> categories = [
    'Electronics',
    'Fashion',
    'Home & Kitchen',
    'Books',
    'Toys',
    'Sports',
    'Beauty & Personal Care',
  ];
  @override
  void initState() {
    super.initState();
    _navigationService = _getIt<NavigationService>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Categories'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            _navigationService.pushReplacedNamed("/home");
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notification_important),
            onPressed: () {
              _navigationService.pushReplacedNamed("/notifications");
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: categories.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(categories[index]),
            trailing: const Icon(Icons.arrow_forward),
            onTap: () {
              // Navigate to the products page for the selected category
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      ProductsPage(category: categories[index]),
                ),
              );
            },
          );
        },
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: 1,
        onTap: (index) {
          if (index == 0) {
            _navigationService.pushReplacedNamed("/home");
          } else if (index == 1) {
            _navigationService.pushReplacedNamed("/categories");
          } else if (index == 2) {
            _navigationService.pushReplacedNamed("/mycart");
          } else if (index == 3) {
            _navigationService.pushReplacedNamed("/userprofile");
          }
        },
      ),
    );
  }
}

class ProductsPage extends StatefulWidget {
  final String category;

  const ProductsPage({super.key, required this.category});

  @override
  State<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.category} Products'),
      ),
      body: Center(
        child: Text('Display products for ${widget.category} here'),
      ),
    );
  }
}
