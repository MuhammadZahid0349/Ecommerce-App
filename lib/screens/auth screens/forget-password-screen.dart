// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers, unused_local_variable, file_names

import 'package:ecommerce_app/Constants/ColorConstants.dart';
import 'package:ecommerce_app/Constants/app-constant.dart';
import 'package:ecommerce_app/Constants/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../controllers/forget-password-controller.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  final ForgerPasswordController forgerPasswordController =
      Get.put(ForgerPasswordController());
  TextEditingController userEmail = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return KeyboardVisibilityBuilder(builder: (context, isKeyboardVisible) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: logoColor,
          centerTitle: true,
          title: CustomizedText(
              text: "Forget Password",
              color: white,
              size: 20.sp,
              FontWeight: FontWeight.bold),
          leading: GestureDetector(
            onTap: () {
              Get.back();
            },
            child: Icon(
              Icons.arrow_back_ios_new,
              color: white,
              size: 20.sp,
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 160.h,
                width: Get.width,
                color: logoColor,
                child: Transform.scale(
                  alignment: Alignment.center,
                  scale: 1.2,
                  child: Lottie.asset('assets/images/ssicon.json'),
                ),
              ),
              30.h.heightBox,
              Container(
                margin: EdgeInsets.symmetric(horizontal: 5.0),
                width: Get.width,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: TextFormField(
                    controller: userEmail,
                    cursorColor: logoColor,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      hintText: "Email",
                      hintStyle: TextStyle(
                          color: skyColor1, fontWeight: FontWeight.w400),
                      prefixIcon: Icon(
                        Icons.email,
                        color: skyColor1,
                      ),
                      contentPadding: EdgeInsets.only(top: 2.0, left: 8.0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                ),
              ),
              30.h.heightBox,
              Material(
                child: Container(
                  width: Get.width / 2,
                  height: Get.height / 18,
                  decoration: BoxDecoration(
                    color: logoColor,
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: TextButton(
                    child: CustomizedText(
                        text: "Forget",
                        color: white,
                        size: 18.sp,
                        btwSpace: 0.3,
                        FontWeight: FontWeight.bold),
                    onPressed: () async {
                      String email = userEmail.text.trim();
                      if (email.isEmpty) {
                        Get.snackbar(
                          "Error",
                          "Please enter all details",
                          snackPosition: SnackPosition.BOTTOM,
                          backgroundColor: logoColor,
                          colorText: white,
                        );
                      } else {
                        String email = userEmail.text.trim();
                        forgerPasswordController.ForgetPasswordMethod(email);
                      }
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
