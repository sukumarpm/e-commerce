import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_1/services/auth_service.dart';
import 'package:ecommerce_1/services/navigation_service.dart';
import 'package:ecommerce_1/widgets/custom_form.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  late double _deviceHeight;
  late double _deviceWidth;
  String? phone;
  String? password;
  String? name;
  late AuthService _auth;
  final FirebaseFirestore _firebase = FirebaseFirestore.instance;
  late NavigationService _navigationService;
  final GetIt _getIt = GetIt.instance;
  final _registerFormKey = GlobalKey<FormState>();
  Map<String, dynamic> registerData = {};

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
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _registerFormKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text(
                    'Create an Account',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  Text('Name',
                      style: GoogleFonts.sen(
                          textStyle: const TextStyle(
                              color: Color.fromARGB(255, 9, 0, 0),
                              fontSize: 14))),
                  SizedBox(
                    width: _deviceWidth * .9,
                    child: CustomFormField(
                      onSaved: (value) {
                        setState(() {
                          name = value;
                        });
                      },
                      regEx: r"^[a-zA-Z ]+$",
                      hintText: "Enter your name",
                      initialValue: null,
                      obscureText: false,
                      height: _deviceHeight * .1,
                      keytype: TextInputType.name,
                    ),
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
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: () async {
                      // Handle registration logic
                      if (_registerFormKey.currentState!.validate()) {
                        _registerFormKey.currentState!.save();
                        // Perform registration
                        print('name:$name, phone:$phone, password:$password');
                        final QuerySnapshot resulta = await _firebase
                            .collection("customers")
                            .where("_phone", isEqualTo: phone!)
                            .get();
                        final List<DocumentSnapshot> documents = resulta.docs;
                        if (kDebugMode) {
                          print('documents.isNotEmpty:$documents');
                        }
                        if (documents.isNotEmpty) {
                          //exists
                          // if (kDebugMode) {
                          //   print('Exists');
                          // }

                          Get.snackbar('Oops!. ',
                              'Account with this Phone number already exist! Please try with different number',
                              barBlur: 1,
                              backgroundColor: Colors.white,
                              margin: EdgeInsets.all(_deviceHeight * .1),
                              duration: const Duration(seconds: 2),
                              snackPosition: SnackPosition.BOTTOM);
                        } else {
                          //not exists
                          String? result =
                              await _auth.registerUserUsingEmailAndPassword(
                                  '$phone@ecommerce.com',
                                  password!,
                                  '',
                                  '',
                                  name);
                          if (kDebugMode) {
                            print('uid: $result');
                          }
                          await _firebase
                              .collection('customers')
                              .doc(phone)
                              .set({
                            "_phone": phone,
                            "_password": password,
                            "_name": name,
                            "_uid": result,
                          });
                          _navigationService.pushReplacedNamed("/home");
                        }
                      }
                    },
                    child: const Text('Register'),
                  ),
                  Row(
                    children: [
                      Checkbox(
                        value: false,
                        onChanged: (bool? value) {
                          // Handle checkbox state change
                        },
                      ),
                      const Expanded(
                        child: Text(
                            'I agree to the Terms & Conditions and Privacy Policy'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 48),
                  const Row(
                    children: [
                      Expanded(
                        child: Divider(thickness: 1),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text('OR'),
                      ),
                      Expanded(
                        child: Divider(thickness: 1),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
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
                  SizedBox(height: _deviceHeight * .15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Already have an account? "),
                      GestureDetector(
                        onTap: () {
                          // Navigate to login page
                          Navigator.pushNamed(context, '/login');
                        },
                        child: const Text(
                          "Login",
                          style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
