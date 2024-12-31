import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:volco/core/app_export.dart';
import 'package:volco/core/utils/image_constant.dart';
import 'package:volco/core/utils/supabase_handler.dart';
import 'package:volco/presentation/avatar_capture_screen/models/avatar_capture_model.dart';

class AvatarCaptureController extends GetxController {
  Rx<AvatarCaptureModel> avatarCaptureModelObj = AvatarCaptureModel().obs;
  SupabaseService supabaseService = SupabaseService();
  final SupabaseClient _supabaseClient = SupabaseHandler().supabaseClient;
  AuthController authController = Get.find<AuthController>();

  Rx<File?> pickedImage = Rx<File?>(null);

  final ImagePicker _imagePicker = ImagePicker();

  Future<void> pickImage() async {
    try {
      final pickedFile = await _imagePicker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        pickedImage.value = File(pickedFile.path);
      } else {
        Get.snackbar("No Image Selected", "Please select an image to upload.");
      }
    } catch (e) {
      print("Error picking image: $e");
      Get.snackbar("Error", "Unable to pick an image.");
    }
  }

  Future<void> uploadAvatar() async {
    if (pickedImage.value == null) {
      Get.snackbar("Error", "No image selected.");
      return;
    }

    // Show the bottom sheet with a progress indicator
    Get.bottomSheet(
      Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
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
      // Upload image
      final publicUrl = await supabaseService.uploadImage(pickedImage.value!);

      if (publicUrl != null) {
        print("Public URL: $publicUrl");

        // Update user's profile with avatar URL
        final userId = await supabaseService.getUserId();
        if (userId != null) {
          final updateSuccess = await supabaseService.updateRecord(
            "profiles",
            {"avatar_url": publicUrl},
            "id",
            userId,
          );

          if (updateSuccess) {
            Get.back(); // Close the bottom sheet
            Get.snackbar("Success", "Avatar uploaded successfully.");

            // Show the success message in the bottom sheet
            Get.bottomSheet(
              Container(
                height: double.infinity,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
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
              isDismissible: false,
            );

            // Redirect after 1.5 seconds
            await Future.delayed(const Duration(seconds: 2, milliseconds: 100));
            Get.offAllNamed(AppRoutes.userDetailsScreen);
          } else {
            Get.back();
            print("Failed to update avtar url");// Close the bottom sheet
            Get.snackbar("Error", "Failed to avatar url.");
          }
        }
      }
    } catch (e) {
      Get.back(); // Close the bottom sheet
      print("Error uploading avatar: $e");
      Get.snackbar("Error", "Failed to upload avatar: $e");
    }
  }
}
