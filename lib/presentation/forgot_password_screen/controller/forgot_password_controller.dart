import 'package:flutter/cupertino.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:volco/core/app_export.dart';
import 'package:volco/core/utils/authentication.dart';
import 'package:volco/core/utils/validation_functions.dart';
import 'package:volco/presentation/forgot_password_screen/models/forgot_password_model.dart';

class ForgotPasswordController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController otpController = TextEditingController();
  Rx<ForgotPasswordModel> forgotPasswordModelObj = ForgotPasswordModel().obs;
  final SupabaseClient supabaseClient = SupabaseHandler().supabaseClient;
  AuthController authController = Get.find<AuthController>();
  RxBool isOtpSent = false.obs; // Observable to track OTP sent state

  /// Validates the email field.
  String? validateEmail(String? value) {
    if (value == null || value.isEmpty || !isValidEmail(value, isRequired: true)) {
      return "Please Enter a Valid Email".tr;
    }
    return null;
  }

  /// Sends an OTP to the entered email.
  Future<void> sendOtp() async {
    final email = emailController.text.trim();
    if (validateEmail(email) == null) {
      try {
        // Call Supabase function to send OTP
        final response = await  authController.sendOTPonEmail(email);
        if (response) {
          Get.snackbar('Success', 'OTP sent successfully to your email.');
          isOtpSent.value = true; // Update state to show OTP input
        }
      } catch (e) {
        print('Error sending OTP: $e');
        Get.snackbar('Error', e.toString());
      }
    } else {
      print('Validation Error: Invalid email address.');
      Get.snackbar('Validation Error', 'Please enter a valid email address.');
    }
  }

  /// Verifies the entered OTP.
  Future<void> verifyOtp(String otp) async {
    final email = emailController.text.trim();
    try {
      // Call Supabase function to verify OTP
      final response = await authController.verifyOTP(email, otp);
      if (response != null) {
        Get.offAndToNamed(AppRoutes.resetPasswordScreen);

        Get.snackbar('Success', 'OTP verified successfully.');
        // Navigate to reset password screen or home screen
        print('Navigate to reset password screen or home screen');
      }
    } catch (e) {
      print('Error verifying OTP: $e');
      Get.snackbar('Error', e.toString());
    }
  }

  /// Resets the OTP sent state for re-entry if needed.
  void resetOtpState() {
    isOtpSent.value = false;
    otpController.clear();
  }

  @override
  void onClose() {
    super.onClose();
    emailController.dispose();
    otpController.dispose();
  }
}
