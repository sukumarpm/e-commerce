import 'package:ecommerce_1/services/navigation_service.dart';
import 'package:ecommerce_1/widgets/mycontroller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';

class MyCartPage extends StatefulWidget {
  const MyCartPage({super.key});

  @override
  State<MyCartPage> createState() => _MyCartPageState();
}

class _MyCartPageState extends State<MyCartPage> {
  final MyController c = Get.put(MyController());
  late NavigationService _navigationService;
  final GetIt _getIt = GetIt.instance;

  @override
  void initState() {
    super.initState();
    _navigationService = _getIt<NavigationService>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Cart'),
      ),
      body: c.fullcartList.isNotEmpty
          ? ListView.builder(
              itemCount: c.fullcartList.length,
              itemBuilder: (context, index) {
                final item = c.fullcartList[index];
                return Card(
                  margin:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  child: ListTile(
                    leading: Image.asset(
                      item.icon!,
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                    ),
                    title: Text(item.title!),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Price: \$${item.price}'),
                        Row(
                          children: [
                            IconButton(
                              icon: const Icon(Icons.remove),
                              onPressed: () {
                                setState(() {
                                  if (item.qty! > 1) {
                                    c.decreaseQuantity(item);
                                  } else {
                                    c.removeFromCart(item);
                                  }
                                });
                                //c.decreaseQuantity(item);
                              },
                            ),
                            Text(
                              '${item.qty}',
                              style: const TextStyle(fontSize: 16),
                            ),
                            IconButton(
                              icon: const Icon(Icons.add),
                              onPressed: () {
                                setState(() {
                                  c.incrementQuantity(item);
                                });
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () {
                        setState(() {
                          c.removeFromCart(item);
                        });
                      },
                    ),
                  ),
                );
              },
            )
          : Container(
              padding: const EdgeInsets.all(16),
              child: const Center(
                child: Text(
                  'Your cart is empty',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Total: \$${c.fullcartList.fold(0, (sum, item) => sum + (item.price! * double.parse(item.qty!.toString())).toInt())}',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            ElevatedButton(
              onPressed: () {
                // Add checkout functionality here
                _navigationService.pushNamed('/checkout');
              },
              child: const Text('Checkout'),
            ),
          ],
        ),
      ),
    );
  }
}
