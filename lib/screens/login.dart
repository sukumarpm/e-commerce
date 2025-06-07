import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_1/services/auth_service.dart';
import 'package:ecommerce_1/services/navigation_service.dart';
import 'package:ecommerce_1/widgets/custom_form.dart';
import 'package:ecommerce_1/widgets/mycontroller.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late double _deviceHeight;
  late double _deviceWidth;
  final _loginFormKey = GlobalKey<FormState>();
  String? phone;
  String? password;
  late AuthService _auth;
  final FirebaseFirestore _firebase = FirebaseFirestore.instance;
  late NavigationService _navigationService;
  final GetIt _getIt = GetIt.instance;
  bool isAdmin = false;

  @override
  void initState() {
    super.initState();
    _auth = _getIt<AuthService>();
    _navigationService = _getIt<NavigationService>();
  }

  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _loginFormKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'Welcome Back!',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              Text(
                'PHONE NUMBER',
                style: GoogleFonts.sen(
                    textStyle: const TextStyle(
                        color: Color.fromARGB(255, 9, 0, 0), fontSize: 14)),
              ),
              SizedBox(
                width: _deviceWidth * .9,
                child: CustomFormField(
                  onSaved: (value) {
                    setState(() {
                      phone = value;
                    });
                  },
                  regEx: r"^(?:[+0]9)?[0-9]{10}$",
                  hintText: "+91",
                  initialValue: null,
                  obscureText: false,
                  height: _deviceHeight * .1,
                  keytype: TextInputType.emailAddress,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'PASSWORD',
                style: GoogleFonts.sen(
                    textStyle: const TextStyle(
                        color: Color.fromARGB(255, 9, 0, 0), fontSize: 14)),
              ),
              SizedBox(
                width: _deviceWidth * .9,
                child: CustomFormField(
                  onSaved: (value) {
                    setState(() {
                      password = value;
                    });
                  },
                  regEx: r".{6,}",
                  hintText: "* * * * * *",
                  initialValue: null,
                  obscureText: true,
                  height: _deviceHeight * .1,
                  keytype: TextInputType.visiblePassword,
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  if (_loginFormKey.currentState!.validate()) {
                    _loginFormKey.currentState!.save();
                    print('phone: $phone, password: $password');
                    // Perform login action
                    // For example, you can call an API to authenticate the user
                    // and navigate to the home screen if successful.
                    // Navigator.pushReplacementNamed(context, '/home');
                    if (_loginFormKey.currentState!.validate()) {
                      _loginFormKey.currentState!.save();

                      if (kDebugMode) {
                        print("====== LOGIN DETAILS =====");
                        print("phone: $phone");
                        print("address: $password");
                        print("====== EVENT END =====");
                      }

                      final QuerySnapshot resulta = await _firebase
                          .collection("customers")
                          .where("_phone", isEqualTo: phone)
                          .get();

                      List<Object?> data = resulta.docs.map((e) {
                        return e.data();
                      }).toList();
                      if (kDebugMode) {
                        print('data:${data.toString()}');
                      }

                      // final List<DocumentSnapshot> documents = resulta.docs;
                      // if (documents.isNotEmpty) {
                      if (data.isNotEmpty) {
                        Map<dynamic, dynamic> userData = data[0] as Map;
                        if (kDebugMode) {
                          print('result - Login 1:${userData['_password']}');
                        }
                        if (userData['_password'] == password) {
                          String fakeemail = '$phone@ecommerce.com';
                          bool result = await _auth.loginUsingEmailAndPassword(
                              fakeemail, password!, "", "", "");
                          if (result) {
                            //get user
                            final QuerySnapshot resulta = await _firebase
                                .collection("admin")
                                .where("_phone", isEqualTo: phone)
                                .get();

                            List<Object?> dataadmin = resulta.docs.map((e) {
                              return e.data();
                            }).toList();
                            if (kDebugMode) {
                              print('dataadmin:$dataadmin');
                            }
                            if (dataadmin.isNotEmpty) {
                              isAdmin = true;
                              Map<dynamic, dynamic> adminData =
                                  dataadmin[0] as Map;
                              Get.find<MyController>().isAdmin = true.obs;
                              Get.find<MyController>().admindata = adminData;
                            } else {
                              isAdmin = false;
                            }

                            // if (kDebugMode) {
                            //   print('dataadmin:$dataadmin');
                            // }

                            //get user
                            Get.find<MyController>().profiledata = userData;
                            // Get.snackbar('Welcome!. ', userData['name'] + '!',
                            //     barBlur: 1,
                            //     backgroundColor: Colors.white,
                            //     margin: EdgeInsets.all(_deviceHeight * .1),
                            //     duration: const Duration(seconds: 5),
                            //     snackPosition: SnackPosition.BOTTOM);
                            if (isAdmin) {
                              _navigationService.pushNamed("/adminhome");
                            } else {
                              _navigationService.pushNamed("/home");
                            }
                          } else {
                            Get.snackbar('Oops!. ',
                                'Problem logging in now. Please retry after sometime or contact admin.',
                                barBlur: 1,
                                backgroundColor: Colors.white,
                                margin: EdgeInsets.all(_deviceHeight * .1),
                                duration: const Duration(seconds: 5),
                                snackPosition: SnackPosition.BOTTOM);
                          }
                        } else {
                          Get.snackbar('Oops!. ',
                              'Phone/Passcode is incorrect. Please retry.',
                              barBlur: 1,
                              backgroundColor: Colors.white,
                              margin: EdgeInsets.all(_deviceHeight * .1),
                              duration: const Duration(seconds: 5),
                              snackPosition: SnackPosition.BOTTOM);
                        }
                      } else {
                        Get.snackbar(
                            'Oops!. ', 'This account is not registered.',
                            barBlur: 1,
                            backgroundColor: Colors.white,
                            margin: EdgeInsets.all(_deviceHeight * .1),
                            duration: const Duration(seconds: 5),
                            snackPosition: SnackPosition.BOTTOM);
                      }
                    } else {
                      // if (kDebugMode) {
                      //   print('result : validation error');
                      // }
                    }
                    //_navigationService.pushReplacedNamed("/home");
                  }
                  // Handle login logic
                },
                child: const Text('Login'),
              ),
              const SizedBox(height: 40),
              const Text(
                'Or login with',
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: SvgPicture.asset(
                      'lib/assets/Frame 1597884494.svg',
                    ),
                  ),
                  const SizedBox(width: 20),
                  Center(
                    child: SvgPicture.asset(
                      'lib/assets/Group 8189.svg',
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              TextButton(
                onPressed: () {
                  // Navigate to registration page
                  Navigator.pushNamed(context, '/register');
                },
                child: const Text('Don\'t have an account? Sign up',
                    style: TextStyle(
                      color: Color.fromARGB(255, 9, 0, 0),
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
