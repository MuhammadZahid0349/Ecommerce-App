// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers, unused_local_variable, unnecessary_null_comparison, file_names

import 'package:ecommerce_app/Constants/ColorConstants.dart';
import 'package:ecommerce_app/Constants/app-constant.dart';
import 'package:ecommerce_app/Constants/utils.dart';
import 'package:ecommerce_app/controllers/sign-in-controller.dart';
import 'package:ecommerce_app/screens/admin-panel/admin-main-screen.dart';
import 'package:ecommerce_app/screens/auth%20screens/sign-up-screen.dart';
import 'package:ecommerce_app/screens/user-panel/main-screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../controllers/get-user-data-controller.dart';
import 'forget-password-screen.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final SignInController signInController = Get.put(SignInController());
  final GetUserDataController getUserDataController =
      Get.put(GetUserDataController());

  TextEditingController userEmail = TextEditingController();
  TextEditingController userPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return KeyboardVisibilityBuilder(builder: (context, isKeyboardVisible) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: logoColor,
          centerTitle: true,
          title: CustomizedText(
              text: "Sign In",
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
              isKeyboardVisible
                  ? Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: 20.w, horizontal: 10.h),
                      child: CustomizedText(
                          text: "Welcome to Wind Tech Ecomm App",
                          color: skyColor2,
                          size: 20.sp,
                          btwSpace: 0.3,
                          FontWeight: FontWeight.bold),
                    )
                  : Column(
                      children: [
                        Container(
                          height: 130.h,
                          width: Get.width,
                          color: logoColor,
                          child: Transform.scale(
                            alignment: Alignment.center,
                            scale: 1,
                            child: Lottie.asset('assets/images/ssicon.json'),
                          ),
                        ),
                      ],
                    ),
              25.h.heightBox,
              Container(
                margin: EdgeInsets.symmetric(horizontal: 5.0),
                width: Get.width,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: TextFormField(
                    controller: userEmail,
                    cursorColor: logoColor2,
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
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 5.0),
                width: Get.width,
                child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Obx(
                      () => TextFormField(
                        controller: userPassword,
                        obscureText: signInController.isPasswordVisible.value,
                        cursorColor: logoColor2,
                        keyboardType: TextInputType.visiblePassword,
                        decoration: InputDecoration(
                          hintText: "Password",
                          hintStyle: TextStyle(
                              color: skyColor1, fontWeight: FontWeight.w400),
                          prefixIcon: Icon(
                            Icons.password,
                            color: skyColor1,
                          ),
                          suffixIcon: GestureDetector(
                            onTap: () {
                              signInController.isPasswordVisible.toggle();
                            },
                            child: signInController.isPasswordVisible.value
                                ? Icon(
                                    Icons.visibility_off,
                                    color: skyColor1,
                                  )
                                : Icon(
                                    Icons.visibility,
                                    color: skyColor1,
                                  ),
                          ),
                          contentPadding: EdgeInsets.only(top: 2.0, left: 8.0),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                      ),
                    )),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 10.0),
                alignment: Alignment.centerRight,
                child: GestureDetector(
                  onTap: () {
                    Get.to(() => ForgetPasswordScreen());
                  },
                  child: Text(
                    "Forget Password?",
                    style: TextStyle(
                        color: logoColor2, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              40.h.heightBox,
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
                        text: "SIGN IN",
                        color: white,
                        size: 18.sp,
                        btwSpace: 0.3,
                        FontWeight: FontWeight.bold),
                    onPressed: () async {
                      String email = userEmail.text.trim();
                      String password = userPassword.text.trim();

                      if (email.isEmpty || password.isEmpty) {
                        Get.snackbar(
                          "Error",
                          "Please enter all details",
                          snackPosition: SnackPosition.BOTTOM,
                          backgroundColor: logoColor,
                          colorText: white,
                        );
                      } else {
                        UserCredential? userCredential = await signInController
                            .signInMethod(email, password);

                        var userData = await getUserDataController
                            .getUserData(userCredential!.user!.uid);

                        if (userCredential != null) {
                          if (userCredential.user!.emailVerified) {
                            //
                            if (userData[0]['isAdmin'] == true) {
                              Get.snackbar(
                                "Success Admin Login",
                                "login Successfully!",
                                snackPosition: SnackPosition.BOTTOM,
                                backgroundColor: logoColor,
                                colorText: white,
                              );
                              Get.offAll(() => AdminMainScreen());
                            } else {
                              Get.offAll(() => MainScreen());
                              Get.snackbar(
                                "Success User Login",
                                "login Successfully!",
                                snackPosition: SnackPosition.BOTTOM,
                                backgroundColor: logoColor,
                                colorText: white,
                              );
                            }
                          } else {
                            Get.snackbar(
                              "Error",
                              "Please verify your email before login",
                              snackPosition: SnackPosition.BOTTOM,
                              backgroundColor: logoColor,
                              colorText: white,
                            );
                          }
                        } else {
                          Get.snackbar(
                            "Error",
                            "Please try again",
                            snackPosition: SnackPosition.BOTTOM,
                            backgroundColor: logoColor,
                            colorText: white,
                          );
                        }
                      }
                    },
                  ),
                ),
              ),
              45.h.heightBox,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomizedText(
                    text: "Don't have an account? ",
                    color: logoColor,
                    size: 15.sp,
                  ),
                  5.w.widthBox,
                  GestureDetector(
                    onTap: () => Get.offAll(() => SignUpScreen()),
                    child: CustomizedText(
                        text: "Sign Up",
                        color: logoColor2,
                        size: 16.sp,
                        btwSpace: 0.5,
                        FontWeight: FontWeight.bold),
                  ),
                ],
              )
            ],
          ),
        ),
      );
    });
  }
}
