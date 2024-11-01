


import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:volco/core/app_export.dart';
import 'package:volco/presentation/welcome_screen/models/welcome_model.dart';
import 'package:volco/routes/app_routes.dart';

class WelcomeController extends GetxController{
  Rx<WelcomeModel> welcomeModelObj = WelcomeModel().obs;
  @override
  void onReady() {
    // TODO: implement onReady
    Future.delayed(const Duration(milliseconds: 3000),(){
      Get.offNamed(
        AppRoutes.onboardingOneScreen,
      );
    });
  }
}