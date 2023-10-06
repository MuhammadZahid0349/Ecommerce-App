import 'package:ecommerce_app/firebase_options.dart';
import 'package:ecommerce_app/screens/splash%20screen/splash-screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return GetMaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'WT Ecomm',
            builder: EasyLoading.init(),
            theme: ThemeData(
              useMaterial3: true,
              scaffoldBackgroundColor: Colors.white,
              // appBarTheme: const AppBarTheme(
              //   backgroundColor: Color(0xff001828),
              // ),
              // textTheme: const TextTheme(
              //   bodyText1: TextStyle(
              //       color: Colors.white), // Set default text color
              //   bodyText2: TextStyle(
              //       color: Colors.white), // Set default text color
              // ),
              // primaryColor: const Color(0xff001828)
            ),
            home: const SplashScreen(),
          );
        });
  }
}
