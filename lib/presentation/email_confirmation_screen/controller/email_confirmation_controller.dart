import 'package:flutter/cupertino.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:volco/core/app_export.dart';
import 'package:volco/core/utils/validation_functions.dart';
import 'package:volco/presentation/sign_in_screen/models/sign_in_model.dart';
import 'package:volco/presentation/sign_up_screen/models/sign_up_model.dart';
class SignUpController extends GetxController {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  final Rx<bool> isShowPassword = true.obs;

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty || !isValidEmail(value, isRequired: true)) {
      return "Please Enter a Valid Email".tr;
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty || !isValidPassword(value, isRequired: true)) {
      return "Please Enter a Valid Password".tr;
    }
    return null;
  }

  //validate confirm password
  String? validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty || !isValidPassword(value, isRequired: true)) {
      return "Please Enter a Valid Password".tr;
    }
    if (passwordController.text != confirmPasswordController.text) {
      return "Password does not match".tr;
    }
    return null;
  }

  void togglePasswordVisibility() {
    isShowPassword.value = !isShowPassword.value;
  }

  void signUpUser() {
    // Add sign-up logic here
    print("Sign Up clicked");
    // Get.offNamed(AppRoutes.homeScreen);
  }

  void signInWithGoogle() {
    AuthController().signInWithGoogle();
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
