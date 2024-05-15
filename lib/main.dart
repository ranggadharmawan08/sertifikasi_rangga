import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'app/routes/app_pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: FirebaseOptions(
          apiKey: "AIzaSyBfjCrkvtcgrMztUy6xLLKeQpyhitx0RGY",
          appId: "1:442736718269:android:bcd09bdcfb5bdc1974e2d4",
          messagingSenderId: "442736718269",
          projectId: "sertifikasirangga",
          storageBucket: "gs://sertifikasirangga.appspot.com"));
  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Application",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
    ),
  );
}
