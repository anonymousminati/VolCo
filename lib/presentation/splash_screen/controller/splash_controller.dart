


import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:volco/core/app_export.dart';
import 'package:volco/presentation/splash_screen/models/splash_model.dart';
import 'package:volco/routes/app_routes.dart';

class SplashController extends GetxController{
  Rx<SplashModel> splashModelObj = SplashModel().obs;

  @override
  void onReady() {
    // TODO: implement onReady
    Future.delayed(const Duration(milliseconds: 3000),(){
      Get.offNamed(
        AppRoutes.welcomeScreen,
      );
    });
  }
}