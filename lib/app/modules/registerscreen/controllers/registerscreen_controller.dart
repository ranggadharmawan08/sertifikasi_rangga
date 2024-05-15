import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterscreenController extends GetxController {
  final CollectionReference _userCollection =
      FirebaseFirestore.instance.collection('user');
  final FirebaseAuth _auth = FirebaseAuth.instance;

  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmpasswordController = TextEditingController();

  Future<bool> isemailExists(String email) async {
    QuerySnapshot querySnapshot =
        await _userCollection.where('email', isEqualTo: email).get();
    return querySnapshot.docs.isNotEmpty;
  }

  Future<void> registerUser(
      String username, String email, String password) async {
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      String userId = userCredential.user!.uid;

      await _userCollection.doc(userId).set({
        'email': email,
        'password': password,
      });
    } catch (e) {
      print("Error registering user: $e");
      Get.snackbar(
          'Error', 'error registering user, try it back.',
          backgroundColor: Color(0xffd567cd), colorText: Color(0xffffffff));
    }
  }

  bool validateInputs(
      {required String username,
      required String email,
      required String password}) {
    if (username.isEmpty || email.isEmpty || password.isEmpty) {
      Get.snackbar('Error', 'all field cannot be empty',
          backgroundColor: Color(0xffd567cd), colorText: Color(0xffffffff));
      return false;
    } else if (!isValidEmail(email)) {
      Get.snackbar('Error', 'create a valid username and password',
          backgroundColor: Color(0xffd567cd), colorText: Color(0xffffffff));
      return false;
    } else if (password.length < 8) {
      Get.snackbar('Error', 'minimum 8 character password',
          backgroundColor: Color(0xffd567cd), colorText: Color(0xffffffff));
      return false;
    }
    return true;
  }

  bool isValidEmail(String email) {
    final RegExp emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return emailRegex.hasMatch(email);
  }
}
