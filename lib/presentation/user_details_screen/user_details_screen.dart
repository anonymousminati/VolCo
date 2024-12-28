import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:volco/presentation/user_details_screen/controller/user_details_controller.dart';

class UserDetailsScreen extends StatelessWidget {
  final UserDetailsController controller = Get.put(UserDetailsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Details'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Profile Image Picker
            Center(
              child: Obx(() {
                return GestureDetector(
                  onTap: () => controller.pickImage(),
                  child: CircleAvatar(
                    radius: 50,
                    backgroundImage: controller.pickedImage.value != null
                        ? FileImage(File(controller.pickedImage.value!.path))
                        : null,
                    child: controller.pickedImage.value == null
                        ? const Icon(Icons.camera_alt, size: 50)
                        : null,
                  ),
                );
              }),
            ),
            const SizedBox(height: 20),

            // First Name
            TextField(
              controller: controller.firstNameController,
              decoration: const InputDecoration(
                labelText: 'First Name',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),

            // Last Name
            TextField(
              controller: controller.lastNameController,
              decoration: const InputDecoration(
                labelText: 'Last Name',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),

            // Email
            TextField(
              controller: controller.emailController,
              decoration: const InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 10),

            // Mobile Number
            TextField(
              controller: controller.mobileNumberController,
              decoration: const InputDecoration(
                labelText: 'Mobile Number',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.phone,
            ),
            const SizedBox(height: 10),

            // Location
            TextField(
              controller: controller.locationController,
              decoration: const InputDecoration(
                labelText: 'Location',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),

            // Skills
            TextField(
              controller: controller.skillsController,
              decoration: const InputDecoration(
                labelText: 'Skills',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),

            // Age
            TextField(
              controller: controller.ageController,
              decoration: const InputDecoration(
                labelText: 'Age',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 20),

            // Save Button
            Center(
              child: ElevatedButton(
                onPressed: () async {
                  // Pass the picked image file (or null if no image selected) to saveUserDetails
                  final File? imageFile = controller.pickedImage.value != null
                      ? File(controller.pickedImage.value!.path)
                      : null;

                  bool success = await controller.saveUserDetails(imageFile);
                  if (success) {
                    Get.snackbar(
                      'Success',
                      'User details saved successfully!',
                      snackPosition: SnackPosition.BOTTOM,
                      backgroundColor: Colors.green,
                      colorText: Colors.white,
                    );
                  } else {
                    Get.snackbar(
                      'Error',
                      'Failed to save user details.',
                      snackPosition: SnackPosition.BOTTOM,
                      backgroundColor: Colors.red,
                      colorText: Colors.white,
                    );
                  }
                },
                child: const Text('Save Details'),
              ),
            ),

          ],
        ),
      ),
    );
  }
}
