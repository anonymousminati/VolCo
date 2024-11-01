import 'package:flutter/cupertino.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:volco/core/app_export.dart';
import 'package:volco/presentation/sign_in_screen/models/sign_in_model.dart';

class SignInController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  Rx<SignInModel> signInModelObj = SignInModel().obs;
  Rx<bool> isShowPassword = true.obs;
  @override
  void onClose() {
    super.onClose();
    emailController.dispose();
    passwordController.dispose();
  }
}
