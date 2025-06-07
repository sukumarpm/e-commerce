import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_1/services/auth_service.dart';
import 'package:ecommerce_1/services/navigation_service.dart';
import 'package:ecommerce_1/services/utils.dart';
import 'package:ecommerce_1/firebase_options.dart';
import 'package:ecommerce_1/themes/theme_modes.dart';
import 'package:ecommerce_1/widgets/mycontroller.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:ecommerce_1/themes/theme_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'dart:async';
import 'package:provider/provider.dart';
import 'package:flutter_svg/flutter_svg.dart';

void main() async {
  await setup();
  runApp(
    ChangeNotifierProvider(
        create: (context) => ThemeProvider(),
        // child: const MaterialApp(home: Rating())),
        child: MaterialApp(theme: lightTheme, home: const OnBoard())),
  );
}

Future<void> setup() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupFirebase();
  await registerservice();
}

Future<void> setupFirebase() async {
  await Firebase.initializeApp(
    name: "ecommerce",
    options: DefaultFirebaseOptions.currentPlatform,
  );
}

class MyApp extends StatelessWidget {
  late AuthService _auth;
  late NavigationService _navigationService;
  final MyController c = Get.put(MyController());

  MyApp({super.key}) {
    final GetIt getIt = GetIt.instance;
    _auth = getIt.get<AuthService>();
    _navigationService = getIt.get<NavigationService>();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    if (kDebugMode) {
      print(' c.isDrive:${c.isDriver}');
    }
    return GetMaterialApp(
      navigatorKey: _navigationService.navigatorKey,
      title: 'Flutter Demo',
      theme: lightTheme,
      initialRoute: _auth.user != null
          ? c.isAdmin == true.obs
              ? "/adminhome"
              : c.isDriver == true.obs
                  ? "/driverhome"
                  : "/home"
          : "/login",
      // // initialRoute: _auth.user != null ? "/mydeliveries" : "/dropdown",
      // // initialRoute: _auth.user != null ? "/home" : "/imageup",
      // // initialRoute: _auth.user != null ? "/register" : "/fmlogo",
      // initialRoute: "/login",
      routes: _navigationService.routes,
    );
  }
}

class OnBoard extends StatefulWidget {
  const OnBoard({super.key});

  @override
  State<OnBoard> createState() => _OnBoardState();
}

class _OnBoardState extends State<OnBoard> {
  late NavigationService _navigationService;
  final GetIt _getIt = GetIt.instance;
  late double _deviceHeight;
  late double _deviceWidth;

  @override
  void initState() {
    super.initState();
    _navigationService = _getIt.get<NavigationService>();
  }

  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      // body: StreamBuilder<List<FoodSource>>(
      //   stream: getAllUsers(),
      //   builder: (context, snapshot) {
      //     if (snapshot.hasData) {
      //       final List<FoodSource> users = snapshot.data as List<FoodSource>;
      //       return ListView(
      //           children: users.map((user) {
      //         return ListTile(
      //           leading: CircleAvatar(child: Text('${user.itemname}')),
      //           title: Text(user.itemdescription!),
      //           subtitle: Text(user.rate!),
      //         );
      //       }).toList());
      //     } else if (snapshot.hasError) {
      //       print('Error:${snapshot.error}');
      //       return const Center(child: Text('Something went wrong.'));
      //     } else {
      //       return const Text('Loading Users...');
      //     }
      //   },
      // ),
      body: Center(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.fromLTRB(
              5, MediaQuery.of(context).size.height * .1, 5, 5),
          child: Column(
            children: [
              Image.asset(
                'lib/assets/logo/LogoBlack.png',
                fit: BoxFit.contain,
                height: 175,
                width: 175,
              ),
              ImageSlideshow(
                /// Width of the [ImageSlideshow].
                width: MediaQuery.of(context).size.width * .7,

                /// Height of the [ImageSlideshow].
                height: MediaQuery.of(context).size.height * .6,

                /// The page to show when first creating the [ImageSlideshow].
                initialPage: 0,

                /// The color to paint the indicator.
                indicatorColor: Theme.of(context).colorScheme.tertiary,

                /// The color to paint behind th indicator.
                indicatorBackgroundColor: const Color.fromARGB(255, 24, 10, 10),

                /// Called whenever the page in the center of the viewport changes.
                onPageChanged: (value) {
                  // if (kDebugMode) {
                  //   print('Page changed: $value');
                  // }
                },

                /// Auto scroll interval.
                /// Do not auto scroll with null or 0.
                autoPlayInterval: 3000,

                /// Loops back to first slide.
                isLoop: true,

                /// The widgets to display in the [ImageSlideshow].
                /// Add the sample image file into the images folder
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Center(
                        child: SvgPicture.asset(
                          'lib/assets/Group 41.svg',
                          width: _deviceWidth * .2,
                          height: _deviceHeight * .2,
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Text(
                            "Welcome to SKY",
                          ),
                          Text(
                            'Explore the latest trends and exclusive collections.',
                            textAlign: TextAlign.center,
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge!
                                .copyWith(
                                    fontWeight: FontWeight.w300, fontSize: 18),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Center(
                        child: SvgPicture.asset(
                          'lib/assets/OBJECTS_x0A_.svg',
                          width: _deviceWidth * .2,
                          height: _deviceHeight * .2,
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Text(
                            'Explore Unlimited Options',
                          ),
                          Text(
                            'Add to cart, pay with ease, and track your order in real time.',
                            textAlign: TextAlign.center,
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge!
                                .copyWith(
                                    fontWeight: FontWeight.w300, fontSize: 18),
                          )
                        ],
                      )
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Center(
                        child: SvgPicture.asset(
                          'lib/assets/OBJECTS.svg',
                          width: _deviceWidth * .2,
                          height: _deviceHeight * .2,
                        ),
                      ),
                      Column(
                        children: [
                          const Text(
                            'Order with Confidence',
                          ),
                          Text(
                            'Get your favorite outfits delivered to your doorstep.',
                            textAlign: TextAlign.center,
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge!
                                .copyWith(
                                    fontWeight: FontWeight.w300, fontSize: 18),
                          ),
                        ],
                      ),
                    ],
                  ),

                  // Image.asset(
                  //   'lib/assets/images/user/onboading/bro.png',
                  //   fit: BoxFit.contain,
                  // ),
                  // Image.asset(
                  //   'lib/assets/images/onboard/pana.png',
                  //   fit: BoxFit.contain,
                  // ),
                  // Image.asset(
                  //   'lib/assets/images/user/onboading/rafiki.png',
                  //   fit: BoxFit.contain,
                  // ),
                ],
              ),
              addVerticalSpace(10),
              SizedBox(
                  width: MediaQuery.of(context).size.width * .8,
                  child: ElevatedButton(
                      child: const Text("GET STARTED"),
                      onPressed: () {
                        // _navigationService.pushReplacedNamed("/login");
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (context) => MyApp()));
                      })),
              // addVerticalSpace(10),
              // Text(
              //   'Skip',
              //   textAlign: TextAlign.center,
              //   style: Theme.of(context)
              //       .textTheme
              //       .titleLarge!
              //       .copyWith(fontWeight: FontWeight.w300, fontSize: 18),
              // )
            ],
          ),
        ),
      ),
    );
  }
}
