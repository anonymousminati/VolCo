import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:volco/core/utils/supabase_handler.dart';
import 'package:volco/presentation/user_details_screen/models/user_details_model.dart';

class UserDetailsController extends GetxController {
  // Text controllers
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final mobileNumberController = TextEditingController();
  final locationController = TextEditingController();
  final skillsController = TextEditingController();
  final ageController = TextEditingController();

  // Image picker state
  Rxn<XFile> pickedImage = Rxn<XFile>();

  // Method to pick an image
  Future<void> pickImage() async {
    final picker = ImagePicker();
    final selectedImage = await picker.pickImage(source: ImageSource.gallery);
    if (selectedImage != null) {
      pickedImage.value = selectedImage;
    }
  }

  // Method to save user details
  Future<bool> saveUserDetails(File? file) async {
    try {
      // Prepare user details
      final userDetails = UserDetailsModel(
        firstName: firstNameController.text.trim(),
        lastName: lastNameController.text.trim(),
        email: emailController.text.trim(),
        mobileNumber: mobileNumberController.text.trim(),
        location: locationController.text.trim(),
        skills: skillsController.text.trim(),
        age: ageController.text.isNotEmpty ? int.tryParse(ageController.text.trim()) : null,
      );

      if (!userDetails.isValid()) {
        throw Exception("Invalid user details.");
      }

      // Insert user details without avatar URL
      final supabaseService = SupabaseService();
      final insertResult = await supabaseService.insertRecord('profiles', userDetails.toJson());

      if (!insertResult) return false;

      // Upload avatar if it exists
      if (pickedImage.value != null) {
        String? profileImageUrl;
        try {
          profileImageUrl = await supabaseService.uploadImage(File(pickedImage.value!.path));
        } catch (e) {
          if (e.toString().contains("RLS violation")) {
            Get.snackbar("Error", "You don't have permission to upload images.");
            return false;
          }
          print("Image upload failed: $e");
          return false;
        }

        // Update the profile with the avatar URL
        final email = userDetails.email; // Assuming email is unique
        final updateResult = await supabaseService.updateRecord(
          'profiles',
          {'avatars': profileImageUrl},
          'email',
          email,
        );

        if (!updateResult) return false;
      }

      return true;
    } catch (e) {
      print("Error saving user details: $e");
      return false;
    }
  }

  @override
  void onClose() {
    // Dispose of text controllers
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    mobileNumberController.dispose();
    locationController.dispose();
    skillsController.dispose();
    ageController.dispose();
    super.onClose();
  }
}
