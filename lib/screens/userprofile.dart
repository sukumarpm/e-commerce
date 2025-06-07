import 'package:ecommerce_1/screens/bottombar.dart';
import 'package:ecommerce_1/services/auth_service.dart';
import 'package:ecommerce_1/services/navigation_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({super.key});

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  late NavigationService _navigationService;
  final GetIt _getIt = GetIt.instance;
  late double _deviceHeight;
  late double _deviceWidth;
  late AuthService _auth;

  @override
  void initState() {
    super.initState();
    _navigationService = _getIt<NavigationService>();
    _auth = _getIt<AuthService>();
  }

  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Row(
          children: [
            // IconButton(
            //   icon: const Icon(Icons.arrow_back),
            //   onPressed: () {
            //     _navigationService.pushNamed("/home");
            //   },
            // ),
            Text('User Profile'),
          ],
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
      body: Column(
        children: [
          SizedBox(
            height: _deviceHeight * 0.65,
            width: _deviceWidth,
            child: ListView(
              children: [
                ListTile(
                  leading: const Icon(Icons.shopping_bag),
                  title: const Text('My Orders'),
                  onTap: () {
                    // Navigate to My Orders screen
                  },
                  trailing: const Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.grey,
                    size: Checkbox.width,
                  ),
                ),
                ListTile(
                  leading: const Icon(Icons.person),
                  title: const Text('My Details'),
                  onTap: () {
                    // Navigate to My Details screen
                  },
                  trailing: const Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.grey,
                    size: Checkbox.width,
                  ),
                ),
                ListTile(
                  leading: const Icon(Icons.location_on),
                  title: const Text('Addresses'),
                  onTap: () {
                    // Navigate to Addresses screen
                  },
                  trailing: const Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.grey,
                    size: Checkbox.width,
                  ),
                ),
                ListTile(
                  leading: const Icon(Icons.history),
                  title: const Text('Order History'),
                  onTap: () {
                    // Navigate to Order History screen
                  },
                  trailing: const Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.grey,
                    size: Checkbox.width,
                  ),
                ),
                ListTile(
                  leading: const Icon(Icons.payment),
                  title: const Text('Payment Setup'),
                  onTap: () {
                    // Navigate to Payment Setup screen
                  },
                  trailing: const Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.grey,
                    size: Checkbox.width,
                  ),
                ),
                ListTile(
                  leading: const Icon(Icons.notifications),
                  title: const Text('Notifications'),
                  onTap: () {
                    // Navigate to Notifications screen
                  },
                  trailing: const Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.grey,
                    size: Checkbox.width,
                  ),
                ),
                ListTile(
                  leading: const Icon(Icons.help_outline),
                  title: const Text('FAQ'),
                  onTap: () {
                    // Navigate to FAQ screen
                  },
                  trailing: const Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.grey,
                    size: Checkbox.width,
                  ),
                ),
                ListTile(
                  leading: const Icon(Icons.help),
                  title: const Text('Help'),
                  onTap: () {
                    // Navigate to Help screen
                  },
                  trailing: const Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.grey,
                    size: Checkbox.width,
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: GestureDetector(
                      onTap: () {
                        _auth.logout();
                        Get.snackbar(
                            'Thanks!.', 'You are logged out successfully!',
                            barBlur: 1,
                            backgroundColor: Colors.white,
                            margin: const EdgeInsets.all(20),
                            duration: const Duration(seconds: 5),
                            snackPosition: SnackPosition.BOTTOM);
                        _navigationService.pushReplacedNamed("/login");
                      },
                      child: const Row(
                        children: [
                          Icon(
                            Icons.logout_rounded,
                            size: 36,
                            color: Colors.red,
                          ),
                          Text('Logout'),
                        ],
                      ),
                    )),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: 3,
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
