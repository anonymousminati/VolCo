import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:lottie/lottie.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:volco/core/app_export.dart';
import 'package:volco/core/utils/image_constant.dart';
import 'package:volco/core/utils/validation_functions.dart';
import 'package:volco/presentation/sign_in_screen/models/sign_in_model.dart';

class SignInController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  Rx<SignInModel> signInModelObj = SignInModel().obs;
  Rx<bool> isShowPassword = true.obs;
  final SupabaseClient supabaseClient = SupabaseHandler().supabaseClient;
  final SupabaseService supabaseService = SupabaseService();
  final AuthController authController = Get.find<AuthController>();


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

  void togglePasswordVisibility() {
    isShowPassword.value = !isShowPassword.value;
  }

  Future<void> signInUser() async {
    if (
        emailController.text.isEmpty ||
        passwordController.text.isEmpty
       ) {
      Get.snackbar("Error", "All fields are required");
      return;
    }
    Get.bottomSheet(
      Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          color: appTheme.gray800,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset(ImageConstant.uploadAnimationLottie,),
          ],
        ),
      ),
      isDismissible: false,
    );

    try {
      await Future.delayed(const Duration(seconds: 2));

      print("before");
      final response = await supabaseClient.auth.signInWithPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      print("after response: $response");
      final Session? session = response.session;
      print("session: $session");
      final User? user = response.user;
      print("user: $user");
      if (response.user != null) {
        Get.back(); // Close the bottom sheet
        // Get.snackbar("Success", "Avatar uploaded successfully.");

        // Show the success message in the bottom sheet
        Get.bottomSheet(
            Container(
              height: double.infinity,
              width: double.infinity,
              decoration: BoxDecoration(
                color: appTheme.gray800,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Lottie.asset(ImageConstant.uploadSuccessAnimationLottie,),
                ],
              ),
            ),
            isDismissible: false,);
        await PrefUtils().setSupabaseAuthSession(session!.refreshToken!);
        print("session stored successfully");
        // supabaseService.insertRecord("profiles", {
        //   "id": user!.id,
        //   "full_name": fullNameController.text,
        //   "username": emailController.text,
        // });
        Get.snackbar("Success", "User signed In successfully");

        bool? isProfileFilled = await authController.checkAllFieldsFilled(user!.id);
        await Future.delayed(const Duration(seconds: 2, milliseconds: 100));
        if(isProfileFilled == false){

          Get.offNamed(AppRoutes.avatarCaptureScreen);
        }
        else{
          Get.offNamed(AppRoutes.homeScreen);
        }


        // Navigate to the next screen, e.g., Get.offNamed(AppRoutes.homeScreen);
      } else {
        //throw error
        print("Failed to sign up");
        Get.back(); // Close the bottom sheet
        Get.snackbar("Error", "Failed to sign up");
      }
    } catch (e) {
      Get.back();
      print( "Failed to sign up: $e");
      Get.snackbar("Error", "Failed to sign up: $e");
    }
  }



  @override
  void onClose() {
    super.onClose();
    emailController.dispose();
    passwordController.dispose();
  }
}
