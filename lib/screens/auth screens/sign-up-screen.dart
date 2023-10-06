import 'package:ecommerce_app/Constants/ColorConstants.dart';
import 'package:ecommerce_app/Constants/app-constant.dart';
import 'package:ecommerce_app/Constants/utils.dart';
import 'package:ecommerce_app/screens/auth%20screens/sign-in-screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../controllers/sign-up-controller.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final SignUpController signUpController = Get.put(SignUpController());

  TextEditingController username = TextEditingController();
  TextEditingController userEmail = TextEditingController();
  TextEditingController userPhone = TextEditingController();
  TextEditingController userCity = TextEditingController();
  TextEditingController userPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return KeyboardVisibilityBuilder(builder: (context, isKeyboardVisible) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: logoColor,
          centerTitle: true,
          title: CustomizedText(
              text: "Sign Up",
              color: white,
              size: 20.sp,
              FontWeight: FontWeight.bold),
          actions: [
            Container(
              height: 80.h,
              width: 80.w,
              color: logoColor,
              child: Transform.scale(
                alignment: Alignment.center,
                scale: 0.8,
                child: Lottie.asset('assets/images/ssicon.json'),
              ),
            ),
          ],
        ),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              20.h.heightBox,
              Container(
                alignment: Alignment.center,
                child: CustomizedText(
                    text: "Welcome to Wind Tech\nEcomm App",
                    color: skyColor2,
                    size: 20.sp,
                    btwSpace: 1,
                    FontWeight: FontWeight.bold),
              ),
              25.h.heightBox,
              buildInputContainer(
                controller: userEmail,
                keyboardType: TextInputType.emailAddress,
                hintText: "Email",
                prefixIcon: const Icon(
                  Icons.email,
                  color: skyColor1,
                ),
              ),
              buildInputContainer(
                controller: username,
                keyboardType: TextInputType.name,
                hintText: "UserName",
                prefixIcon: const Icon(
                  Icons.person,
                  color: skyColor1,
                ),
              ),
              buildInputContainer(
                controller: userPhone,
                keyboardType: TextInputType.number,
                hintText: "Phone",
                prefixIcon: const Icon(
                  Icons.phone,
                  color: skyColor1,
                ),
              ),
              buildInputContainer(
                controller: userCity,
                keyboardType: TextInputType.streetAddress,
                hintText: "City",
                prefixIcon: const Icon(
                  Icons.location_pin,
                  color: skyColor1,
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
                      obscureText: signUpController.isPasswordVisible.value,
                      cursorColor: logoColor,
                      keyboardType: TextInputType.visiblePassword,
                      decoration: InputDecoration(
                        hintText: "Password",
                        hintStyle: const TextStyle(
                            color: skyColor1, fontWeight: FontWeight.w400),
                        prefixIcon: const Icon(
                          Icons.password,
                          color: skyColor1,
                        ),
                        suffixIcon: GestureDetector(
                          onTap: () {
                            signUpController.isPasswordVisible.toggle();
                          },
                          child: signUpController.isPasswordVisible.value
                              ? const Icon(
                                  Icons.visibility_off,
                                  color: skyColor1,
                                )
                              : const Icon(
                                  Icons.visibility,
                                  color: skyColor1,
                                ),
                        ),
                        contentPadding:
                            const EdgeInsets.only(top: 2.0, left: 8.0),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
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
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  child: TextButton(
                    child: CustomizedText(
                        text: "SIGN UP",
                        color: white,
                        size: 18.sp,
                        btwSpace: 0.3,
                        FontWeight: FontWeight.bold),
                    onPressed: () async {
                      String name = username.text.trim();
                      String email = userEmail.text.trim();
                      String phone = userPhone.text.trim();
                      String city = userCity.text.trim();
                      String password = userPassword.text.trim();
                      String userDeviceToken = '';

                      if (name.isEmpty ||
                          email.isEmpty ||
                          phone.isEmpty ||
                          city.isEmpty ||
                          password.isEmpty) {
                        Get.snackbar(
                          "Error",
                          "Please enter all details",
                          snackPosition: SnackPosition.BOTTOM,
                          backgroundColor: logoColor,
                          colorText: white,
                        );
                      } else {
                        UserCredential? userCredential =
                            await signUpController.signUpMethod(
                          name,
                          email,
                          phone,
                          city,
                          password,
                          userDeviceToken,
                        );

                        if (userCredential != null) {
                          Get.snackbar(
                            "Verification email sent.",
                            "Please check your email.",
                            snackPosition: SnackPosition.BOTTOM,
                            backgroundColor: logoColor,
                            colorText: white,
                          );

                          FirebaseAuth.instance.signOut();
                          Get.offAll(() => const SignInScreen());
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
                    text: "Already have an account? ",
                    color: logoColor,
                    size: 15.sp,
                  ),
                  5.w.widthBox,
                  GestureDetector(
                    onTap: () => Get.offAll(() => const SignInScreen()),
                    child: CustomizedText(
                        text: "Sign In",
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

  Widget buildInputContainer({
    TextEditingController? controller,
    TextInputType keyboardType = TextInputType.text,
    String? hintText,
    Icon? prefixIcon,
    EdgeInsetsGeometry contentPadding =
        const EdgeInsets.only(top: 2.0, left: 8.0),
    bool obscureText = false,
    bool isPasswordVisible = true,
    VoidCallback? togglePasswordVisibility,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5.0),
      width: Get.width,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: TextFormField(
          controller: controller,
          obscureText: obscureText && !isPasswordVisible,
          cursorColor: logoColor2,
          keyboardType: keyboardType,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle:
                const TextStyle(color: skyColor1, fontWeight: FontWeight.w400),
            prefixIcon: prefixIcon,
            suffixIcon: obscureText
                ? GestureDetector(
                    onTap: togglePasswordVisibility,
                    child: isPasswordVisible
                        ? const Icon(
                            Icons.visibility_off,
                            color: skyColor1,
                          )
                        : const Icon(
                            Icons.visibility,
                            color: skyColor1,
                          ),
                  )
                : null,
            contentPadding: contentPadding,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
        ),
      ),
    );
  }
}
