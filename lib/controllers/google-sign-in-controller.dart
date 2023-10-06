// ignore_for_file: file_names, unused_local_variable, unused_field, avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/controllers/get-device-token-controller.dart';
import 'package:ecommerce_app/controllers/get-user-data-controller.dart';
import 'package:ecommerce_app/models/user-model.dart';
import 'package:ecommerce_app/screens/admin-panel/admin-main-screen.dart';
import 'package:ecommerce_app/screens/user-panel/main-screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../Constants/ColorConstants.dart';

class GoogleSignInController extends GetxController {
  final GoogleSignIn googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final GetUserDataController getUserDataController =
      Get.put(GetUserDataController());

  Future<void> signInWithGoogle() async {
    final GetDeviceTokenController getDeviceTokenController =
        Get.put(GetDeviceTokenController());

    try {
      final GoogleSignInAccount? googleSignInAccount =
          await googleSignIn.signIn();

      if (googleSignInAccount != null) {
        EasyLoading.show(status: "Please wait..");

        final GoogleSignInAuthentication googleSignInAuthentication =
            await googleSignInAccount.authentication;

        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken,
        );

        final UserCredential userCredential =
            await _auth.signInWithCredential(credential);

        final User? user = userCredential.user;
        if (user != null) {
          // Check if the user already exists in Firestore
          final userDoc =
              await firestore.collection('users').doc(user.uid).get();

          if (userDoc.exists) {
            // User already exists, update their details
            await firestore.collection('users').doc(user.uid).update({
              "username": user.displayName.toString(),
              "email": user.email.toString(),
              "phone": user.phoneNumber.toString(),
              "userImg": user.photoURL.toString(),
              "userDeviceToken":
                  getDeviceTokenController.deviceToken.toString(),
              // Update other fields as needed
            });
          } else {
            // User doesn't exist, create a new document
            UserModel userModel = UserModel(
              uId: user.uid,
              username: user.displayName.toString(),
              email: user.email.toString(),
              phone: user.phoneNumber.toString(),
              userImg: user.photoURL.toString(),
              userDeviceToken: getDeviceTokenController.deviceToken.toString(),
              country: '',
              userAddress: '',
              street: '',
              isAdmin: false,
              isActive: true,
              createdOn: DateTime.now(),
              city: '',
            );

            await firestore
                .collection('users')
                .doc(user.uid)
                .set(userModel.toMap());
          }
          var userData =
              await getUserDataController.getUserData(userCredential.user!.uid);

          EasyLoading.dismiss();
          if (userData[0]['isAdmin'] == true) {
            // Get.snackbar(
            //   "Success Admin Login",
            //   "login Successfully!",
            //   snackPosition: SnackPosition.BOTTOM,
            //   backgroundColor: logoColor,
            //   colorText: white,
            // );
            Get.offAll(() => AdminMainScreen());
          } else {
            Get.offAll(() => MainScreen());
            // Get.snackbar(
            //   "Success User Login",
            //   "login Successfully!",
            //   snackPosition: SnackPosition.BOTTOM,
            //   backgroundColor: logoColor,
            //   colorText: white,
            // );
          }
        }
      }
    } catch (e) {
      EasyLoading.dismiss();
      print("error $e");
    }
  }
}
