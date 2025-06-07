// import 'package:ecommerce_1/screens/getlocation.dart';
import 'package:ecommerce_1/screens/addproduct.dart';
import 'package:ecommerce_1/screens/categories.dart';
import 'package:ecommerce_1/screens/checkout.dart';
import 'package:ecommerce_1/screens/home.dart';
import 'package:ecommerce_1/screens/login.dart';
import 'package:ecommerce_1/screens/mycart.dart';
import 'package:ecommerce_1/screens/notification.dart';
import 'package:ecommerce_1/screens/otpverify.dart';
import 'package:ecommerce_1/screens/products.dart';
import 'package:ecommerce_1/screens/register.dart';
import 'package:ecommerce_1/screens/userprofile.dart';
import 'package:ecommerce_1/screens/viewproduct.dart';
import 'package:ecommerce_1/screens/wishlist.dart';
import 'package:flutter/material.dart';

class NavigationService {
  late GlobalKey<NavigatorState> _navigatorKey;

  final Map<String, Widget Function(BuildContext)> _routes = {
    "/home": (context) => const HomeScreen(),
    "/login": (context) => const LoginPage(),
    "/register": (context) => const RegisterPage(),
    "/otpverify": (context) => const OTPVerifyPage(),
    "/addproduct": (context) => const AddProduct(),
    "/mycart": (context) => MyCartPage(),
    "/userprofile": (context) => const UserProfile(),
    "/viewproduct": (context) => const ViewProduct(),
    "/products": (context) => const ProductsScreen(),
    "/wishlist": (context) => const WishlistScreen(),
    "/categories": (context) => const CategoriesPage(),
    "/notifications": (context) => const NotificationPage(),
    "/checkout": (context) => const CheckoutPage(),
  };

  GlobalKey<NavigatorState>? get navigatorKey {
    return _navigatorKey;
  }

  Map<String, Widget Function(BuildContext)> get routes {
    return _routes;
  }

  NavigationService() {
    _navigatorKey = GlobalKey<NavigatorState>();
  }

  void pushNamed(String routeName) {
    _navigatorKey.currentState?.pushNamed(routeName);
  }

  void pushNamedWithArguments(
      String routeName, final Map<String, String> arguments) {
    _navigatorKey.currentState?.pushNamed(routeName, arguments: arguments);
  }

  void pushReplacedNamed(String routeName) {
    _navigatorKey.currentState?.pushReplacementNamed(routeName);
  }

  void goBack() {
    _navigatorKey.currentState?.pop();
  }
}
