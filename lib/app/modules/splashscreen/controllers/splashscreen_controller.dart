import 'package:get/get.dart';
import 'package:sertifikasi_rangga/app/modules/loginscreen/views/loginscreen_view.dart';

class SplashscreenController extends GetxController {
  @override
  void onReady(){
    super.onReady();
    Future.delayed(Duration(seconds: 2), () {
      Get.off(
        () => LoginscreenView(),
        transition: Transition.fade,
        duration: Duration(seconds: 3),
      );
    });
  }
}
