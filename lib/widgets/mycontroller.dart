import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_1/classes/cartlists.dart';
import 'package:get/get.dart';

class MyController extends GetxController {
  Map<dynamic, dynamic> profiledata = {}.obs;
  Map<dynamic, dynamic> admindata = {}.obs;
  Map<dynamic, dynamic> fooddata = {}.obs;
  Map<String, dynamic> registerdata = {};
  Map<dynamic, dynamic> currentproduct = {};
  late Cartlists cartList;
  late List<Cartlists> fullcartList = [];
  RxBool isAdmin = false.obs;
  RxBool isDriver = false.obs;
  Map<dynamic, dynamic> driverdata = {}.obs;
  final RxMap<String, int> cart = <String, int>{}.obs;
  List<Map<dynamic, dynamic>> productData = [{}].obs;

  void incrementQuantity(Cartlists item) {
    if (item.qty != null) {
      item.qty = item.qty! + 1;
      update();
    }
  }

  void decreaseQuantity(Cartlists item) {
    if (item.qty != null && item.qty! > 1) {
      item.qty = item.qty! - 1;
      update();
    }
  }

  void removeFromCart(Cartlists item) {
    fullcartList.remove(item);
    update();
  }

  void clearCart() {
    fullcartList.clear();
    update();
  }

  void addToCartList(Cartlists item) {
    fullcartList.add(item);
    update();
  }
}
