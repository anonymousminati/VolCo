import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:volco/core/app_export.dart';
import 'package:volco/core/utils/validation_functions.dart';

class SignUpController extends GetxController {
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  final Rx<bool> isShowPassword = true.obs;
  final SupabaseClient supabaseClient = SupabaseHandler().supabaseClient;
  final SupabaseService supabaseService = SupabaseService();
  final AuthController authController = Get.find<AuthController>();
  String? validateFullName(String? value) {
    if (value == null || value.isEmpty) {
      return "Please Enter Your Full Name".tr;
    }
    return null;
  }

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

  Future<void> signUpUser() async {
    if (fullNameController.text.isEmpty ||
        emailController.text.isEmpty ||
        passwordController.text.isEmpty ||
        confirmPasswordController.text.isEmpty) {
      Get.snackbar("Error", "All fields are required");
      return;
    }

    try {
      print("before");
      final response = await supabaseClient.auth.signUp(
        email: emailController.text,
        password: passwordController.text,
        data: {'full_name': fullNameController.text},
      );
      print("after");
      final Session? session = response.session;
      print("session: $session");
      final User? user = response.user;
      print("user: $user");
      if (response.user != null) {
        await PrefUtils.instance.setSupabaseAuthSession(session!.refreshToken!);
        print("session stored successfully");
        // supabaseService.insertRecord("profiles", {
        //   "id": user!.id,
        //   "full_name": fullNameController.text,
        //   "username": emailController.text,
        // });
        Get.snackbar("Success", "User signed up successfully");
        Get.offNamed(AppRoutes.avatarCaptureScreen);



        // Navigate to the next screen, e.g., Get.offNamed(AppRoutes.homeScreen);
      } else {
       //throw error
        print("Failed to sign up");
      }
    } catch (e) {
      print( "Failed to sign up: $e");
      Get.snackbar("Error", "Failed to sign up: $e");
    }
  }

  @override
  void onClose() {
    fullNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }
}
