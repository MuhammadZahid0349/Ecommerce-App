// ignore_for_file: file_names, prefer_const_constructors, avoid_unnecessary_containers, prefer_const_literals_to_create_immutables

import 'package:animate_do/animate_do.dart';
import 'package:ecommerce_app/Constants/ColorConstants.dart';
import 'package:ecommerce_app/Constants/utils.dart';
import 'package:ecommerce_app/screens/auth%20screens/sign-in-screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:velocity_x/velocity_x.dart';
import '../../Constants/app-constant.dart';
import '../../controllers/google-sign-in-controller.dart';

class WelcomeScreen extends StatelessWidget {
  WelcomeScreen({super.key});

  final GoogleSignInController _googleSignInController =
      Get.put(GoogleSignInController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              height: 280.h,
              width: Get.width,
              color: logoColor,
              child: Transform.scale(
                alignment: Alignment.center,
                scale: 1.5,
                child: Lottie.asset('assets/images/ssicon.json'),
              ),
            ),
            20.h.heightBox,
            CustomizedText(
                text: "Happy Shopping",
                color: skyColor2,
                size: 20.sp,
                FontWeight: FontWeight.bold),
            60.h.heightBox,
            FadeInRight(
              delay: const Duration(milliseconds: 300),
              child: buildMaterialButton(
                buttonText: "Sign in with Google",
                buttonColor: logoColor,
                icon: FontAwesomeIcons.google,
                iconColor: white,
                onPressed: () {
                  _googleSignInController.signInWithGoogle();
                },
              ),
            ),
            20.h.heightBox,
            FadeInLeft(
              delay: const Duration(milliseconds: 400),
              child: buildMaterialButton(
                buttonText: "Sign in with Email",
                buttonColor: logoColor2,
                icon: Icons.email,
                size: 30.sp,
                iconColor: AppConstant.appTextColor,
                onPressed: () {
                  Get.to(() => SignInScreen());
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        color: white,
        height: 170.h,
        child: Lottie.asset('assets/images/buble.json'),
      ),
    );
  }

  Widget buildMaterialButton({
    String? buttonText,
    Color? buttonColor,
    Color? iconColor,
    IconData? icon,
    double? size,
    VoidCallback? onPressed,
  }) {
    return Material(
      child: Container(
        width: Get.width / 1.2,
        height: Get.height / 12,
        decoration: BoxDecoration(
          color: buttonColor,
          borderRadius: BorderRadius.circular(20.r),
        ),
        child: TextButton.icon(
          icon: Icon(
            icon,
            color: iconColor,
            size: size,
          ),
          label: Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.h),
            child: CustomizedText(
              text: buttonText,
              color: iconColor,
              size: 18.sp,
              FontWeight: FontWeight.bold,
            ),
          ),
          onPressed: onPressed,
        ),
      ),
    );
  }
}
