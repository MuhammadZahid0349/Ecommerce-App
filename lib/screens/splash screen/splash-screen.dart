import 'dart:async';
import 'package:ecommerce_app/Constants/ColorConstants.dart';
import 'package:ecommerce_app/Constants/app-constant.dart';
import 'package:ecommerce_app/Constants/utils.dart';
import 'package:ecommerce_app/controllers/get-user-data-controller.dart';
import 'package:ecommerce_app/screens/admin-panel/admin-main-screen.dart';
import 'package:ecommerce_app/screens/auth-ui/welcome-screen.dart';
import 'package:ecommerce_app/screens/user-panel/main-screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  User? user = FirebaseAuth.instance.currentUser;
  @override
  void initState() {
    super.initState();
    // Timer(Duration(seconds: 3), () {
    //   // loggdin(context);
    // });
  }

  Future<void> loggdin(BuildContext context) async {
    if (user != null) {
      final GetUserDataController getUserDataController =
          Get.put(GetUserDataController());
      var userData = await getUserDataController.getUserData(user!.uid);

      if (userData[0]['isAdmin'] == true) {
        Get.offAll(() => AdminMainScreen());
      } else {
        Get.offAll(() => MainScreen());
      }
    } else {
      Get.to(() => WelcomeScreen());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: logoColor,
      body: Container(
        child: Column(
          children: [
            Expanded(
              child: Transform.scale(
                alignment: Alignment.center,
                scale: 2.5,
                child: Lottie.asset('assets/images/ssicon.json'),
              ),
            ),
            Container(
                margin: EdgeInsets.only(bottom: 20.0),
                width: Get.width,
                alignment: Alignment.center,
                child: CustomizedText(
                    text: "Powered By Wind Tech",
                    color: white,
                    size: 12.sp,
                    FontWeight: FontWeight.bold))
          ],
        ),
      ),
    );
  }
}
