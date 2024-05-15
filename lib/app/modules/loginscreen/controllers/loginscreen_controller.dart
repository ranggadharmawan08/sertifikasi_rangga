import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sertifikasi_rangga/app/modules/home/views/home_view.dart';

class LoginscreenController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final CollectionReference _userCollection =
      FirebaseFirestore.instance.collection('user');
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<bool> checkCredentials(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      QuerySnapshot querySnapshot =
          await _userCollection.where('email', isEqualTo: email).get();
      return querySnapshot.docs.isNotEmpty;
    } catch (e) {
      return false;
    }
  }

  Future<void> loginUser() async {
    String email = emailController.text;
    String password = passwordController.text;

    if (email.isEmpty || password.isEmpty) {
      Get.snackbar('Error', 'email and password cannot be empty',
          backgroundColor: Color(0xffd567cd), colorText: Color(0xffffffff));
      return;
    }

    bool isValidCredentials = await checkCredentials(email, password);

    if (isValidCredentials) {
      Get.snackbar('Success', 'Login successful',
          backgroundColor: Color(0xffd567cd), colorText: Color(0xffffffff));
      Get.off(
        () => HomeView(),
        transition: Transition.cupertinoDialog,
        duration: Duration(milliseconds: 500),
      );
    } else {
      Get.snackbar('Error', 'Incorrect username or password',
          backgroundColor: Color(0xffd567cd), colorText: Color(0xffffffff));
    }
  }
}
