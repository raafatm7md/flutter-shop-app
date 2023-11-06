import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shop_app/services/service.dart';
import 'package:shop_app/services/shared.dart';
import 'package:shop_app/views/home_screen.dart';
import 'package:shop_app/views/login_screen.dart';
import 'package:shop_app/views/onboarding_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.init();
  await CacheHelper.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          titleSpacing: 20,
          titleTextStyle: TextStyle(
              color: Colors.black, fontSize: 20.0, fontWeight: FontWeight.bold),
          elevation: 0.0,
          systemOverlayStyle: SystemUiOverlayStyle(
              statusBarColor: Colors.white,
              statusBarIconBrightness: Brightness.dark),
          iconTheme: IconThemeData(
            color: Colors.black,
          ),
        ),
        // textTheme: const TextTheme(
        //   bodyText1: TextStyle(
        //       fontSize: 18,
        //       fontWeight: FontWeight.w600,
        //       color: Colors.black
        //   ),
        // ),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
            type: BottomNavigationBarType.fixed,
            selectedItemColor: Colors.blue,
            unselectedItemColor: Colors.grey,
            elevation: 20.0),
        fontFamily: 'Jannah',
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: CacheHelper.getData('onBoarding') == true
          ? CacheHelper.getData('token') != null
              ? const HomePage()
              : LoginScreen()
          : const OnBoardingScreen(),
    );
  }
}
