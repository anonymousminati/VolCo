import 'package:flutter/cupertino.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:volco/core/app_export.dart';
import 'package:volco/core/utils/authentication.dart';
import 'package:volco/core/utils/validation_functions.dart';
import 'package:volco/presentation/reset_password_screen/models/reset_password_model.dart';

class ResetPasswordController extends GetxController {
  TextEditingController passwordController = TextEditingController();
  Rx<ResetPasswordModel> resetPasswordModelObj = ResetPasswordModel().obs;
  final SupabaseClient supabaseClient = SupabaseHandler().supabaseClient;
  AuthController authController = Get.find<AuthController>();

  /// Validates the password field
  String? validatePassword(String? value) {
    if (value == null || value.isEmpty || !isValidPassword(value, isRequired: true)) {
      return "Please Enter a Valid Password".tr;
    }
    return null;
  }

  /// Resets the user's password
  Future<void> resetPassword() async {
    final newPassword = passwordController.text.trim();

    if (newPassword.isEmpty) {
      Get.snackbar("Error", "Password cannot be empty".tr);
      return;
    }

    try {
      // Fetch the user's email from the arguments or session
      // final email = Get.arguments?['email'];
      //
      // if (email == null) {
      //   Get.snackbar("Error", "Email not provided. Please retry.".tr);
      //   return;
      // }

      // Update the password in Supabase
        final response = await authController.resetPassword(newPassword);

      if (response.user != null) {
        Get.snackbar("Success", "Password updated successfully!".tr);

        // Navigate to login screen or another desired route
        Get.offAllNamed(AppRoutes.letsYouInScreen);
      } else {

        Get.snackbar("Error", "Failed to update password. Please try again.".tr);
      }
    } catch (e) {
      print("Error resetting password: $e");
      Get.snackbar("Error", "An error occurred: $e".tr);
    }
  }

  @override
  void onClose() {
    super.onClose();
    passwordController.dispose();
  }
}
