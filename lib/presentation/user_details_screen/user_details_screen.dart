import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:volco/core/app_export.dart';
import 'package:volco/core/utils/image_constant.dart';
import 'package:volco/core/utils/supabase_handler.dart';
import 'package:volco/core/utils/validation_functions.dart';
import 'package:volco/presentation/user_details_screen/controller/user_details_controller.dart';

class UserDetailsScreen extends StatelessWidget {
  final UserDetailsController controller = Get.put(UserDetailsController());
  GlobalKey<FormState> _userDetailsformKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Form(
          key: _userDetailsformKey,
          child: SizedBox(
            width: double.maxFinite,
            child: SingleChildScrollView(
              child: Container(
                width: double.maxFinite,
                padding: EdgeInsets.only(
                  left: 24.h,
                  right: 24.h,
                  top: 10.h,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomImageView(
                      imagePath: ImageConstant.imgArrowLeft,
                      height: 28.h,
                      width: 30.h,
                    ),
                    SizedBox(height: 70.h),
                    Text(
                      "Serve for Good".tr,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.displayMedium!.copyWith(
                        height: 1.50,
                      ),
                    ),
                    SizedBox(height: 24.h),
                    // Profile Image Picker
                    // Center(
                    //   child: Obx(() {
                    //     return GestureDetector(
                    //       onTap: () => controller.pickImage(),
                    //       child: CircleAvatar(
                    //         radius: 50,
                    //         backgroundImage: controller.pickedImage.value != null
                    //             ? FileImage(File(controller.pickedImage.value!.path))
                    //             : null,
                    //         child: controller.pickedImage.value == null
                    //             ? const Icon(Icons.camera_alt, size: 50)
                    //             : null,
                    //       ),
                    //     );
                    //   }),
                    // ),
                    // SizedBox(height: 24.h),
                    _buildUsersDetailsFormSection(),
                    // Save Button
                    SizedBox(height: 24.h),
                    CustomElevatedButton(
                      text: "Submit".tr,
                      onPressed: () async {
                        if (_userDetailsformKey.currentState!.validate()) {
                          // final File? imageFile = controller.pickedImage.value != null
                          //     ? File(controller.pickedImage.value!.path)
                          //     : null;
                          // String? userId = await SupabaseService().getUserId();
                          // print("user id from submit button: $userId");
                          bool success = await controller.updateUserDetailswithoutFile();
                          if (success) {
                            print('User details saved successfully!');
                            Get.snackbar(
                              'Success',
                              'User details saved successfully!',
                              snackPosition: SnackPosition.BOTTOM,
                              backgroundColor: Colors.green,
                              colorText: Colors.white,
                            );
                          } else {
                            print('Failed to save user details.');
                            Get.snackbar(
                              'Error',
                              'Failed to save user details.',
                              snackPosition: SnackPosition.BOTTOM,
                              backgroundColor: Colors.red,
                              colorText: Colors.white,
                            );
                          }

                          // Optionally navigate after a successful update (if needed)
                          if (success) {
                            Get.offNamed(AppRoutes.homeScreen);
                          }
                        }
                      },
                    ),

                    CustomElevatedButton(
                      text: "Submit 2".tr,
                      onPressed: () async {
                        try{
                          final User? user = await SupabaseService().getUserData();
                          String userId = user?.id ?? '';

                          final testResponse = await Supabase.instance.client
                              .from('profiles')
                              .select()
                              .eq('id', userId.toString());

                          print("Test Query Response: ${testResponse}");
                        }catch (e){
                          print("Error in Test Query: $e");
                        }

                      },
                    ),

                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildUsersDetailsFormSection() {
    return SizedBox(
      width: double.maxFinite,
      child: Column(
        children: [
          // First Name
          CustomTextFormField(
            controller: controller.firstNameController,
            hintText: "First Name".tr,
            textInputType: TextInputType.text,
            textInputAction: TextInputAction.next,
            prefix: Container(
              margin: EdgeInsets.fromLTRB(20.h, 18.h, 12.h, 18.h),
              child: CustomImageView(
                imagePath: ImageConstant.imgTextSvg,
                height: 18.h,
                width: 20.h,
                fit: BoxFit.contain,
              ),
            ),
            prefixConstraints: BoxConstraints(
              maxHeight: 60.h,
            ),
            contentPadding: EdgeInsets.symmetric(
              horizontal: 20.h,
              vertical: 18.h,
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'First Name is required'.tr;
              }
              if (!isText(value, isRequired: true)) {
                return 'First Name should contain only alphabets'.tr;
              }
              return null;
            },
          ),
          SizedBox(height: 24.h),

          // Last Name
          CustomTextFormField(
            controller: controller.lastNameController,
            hintText: "Last Name".tr,
            textInputType: TextInputType.text,
            textInputAction: TextInputAction.next,
            prefix: Container(
              margin: EdgeInsets.fromLTRB(20.h, 18.h, 12.h, 18.h),
              child: CustomImageView(
                imagePath: ImageConstant.imgTextSvg,
                height: 18.h,
                width: 20.h,
                fit: BoxFit.contain,
              ),
            ),
            prefixConstraints: BoxConstraints(
              maxHeight: 60.h,
            ),
            contentPadding: EdgeInsets.symmetric(
              horizontal: 20.h,
              vertical: 18.h,
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Last Name is required'.tr;
              }
              if (!isText(value, isRequired: true)) {
                return 'Last Name should contain only alphabets'.tr;
              }
              return null;
            },
          ),
          SizedBox(height: 24.h),

          // Email
          CustomTextFormField(
            controller: controller.emailController,
            hintText: "Email".tr,
            textInputType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            prefix: Container(
              margin: EdgeInsets.fromLTRB(20.h, 18.h, 12.h, 18.h),
              child: CustomImageView(
                imagePath: ImageConstant.imgEmail,
                height: 18.h,
                width: 20.h,
                fit: BoxFit.contain,
              ),
            ),
            prefixConstraints: BoxConstraints(
              maxHeight: 60.h,
            ),
            contentPadding: EdgeInsets.symmetric(
              horizontal: 20.h,
              vertical: 18.h,
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Email is required'.tr;
              }
              if (!isValidEmail(value, isRequired: true)) {
                return 'Enter a valid email address'.tr;
              }
              return null;
            },
          ),
          SizedBox(height: 24.h),

          // Phone Number
          CustomTextFormField(
            controller: controller.mobileNumberController,
            hintText: "Phone Number".tr,
            textInputType: TextInputType.phone,
            textInputAction: TextInputAction.next,
            prefix: Container(
              margin: EdgeInsets.fromLTRB(20.h, 18.h, 12.h, 18.h),
              child: CustomImageView(
                imagePath: ImageConstant.imgNoteSkyBlue,
                height: 18.h,
                width: 20.h,
                fit: BoxFit.contain,
              ),
            ),
            prefixConstraints: BoxConstraints(
              maxHeight: 60.h,
            ),
            contentPadding: EdgeInsets.symmetric(
              horizontal: 20.h,
              vertical: 18.h,
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Phone Number is required'.tr;
              }
              if (!isValidPhone(value, isRequired: true)) {
                return 'Enter a valid phone number'.tr;
              }
              return null;
            },
          ),
          SizedBox(height: 24.h),

          // Address
          CustomTextFormField(
            controller: controller.locationController,
            hintText: "Location".tr,
            textInputType: TextInputType.text,
            textInputAction: TextInputAction.done,
            prefix: Container(
              margin: EdgeInsets.fromLTRB(20.h, 18.h, 12.h, 18.h),
              child: CustomImageView(
                imagePath: ImageConstant.imgLocation,
                height: 18.h,
                width: 20.h,
                fit: BoxFit.contain,
              ),
            ),
            prefixConstraints: BoxConstraints(
              maxHeight: 60.h,
            ),
            contentPadding: EdgeInsets.symmetric(
              horizontal: 20.h,
              vertical: 18.h,
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Address is required'.tr;
              }
              return null;
            },
          ),
          SizedBox(height: 24.h),
          CustomTextFormField(
            controller: controller.skillsController,
            hintText: "Skills".tr,
            textInputType: TextInputType.text,
            textInputAction: TextInputAction.done,
            prefix: Container(
              margin: EdgeInsets.fromLTRB(20.h, 18.h, 12.h, 18.h),
              child: CustomImageView(
                imagePath: ImageConstant.imgNoteSkyBlue,
                height: 18.h,
                width: 20.h,
                fit: BoxFit.contain,
              ),
            ),
            prefixConstraints: BoxConstraints(
              maxHeight: 60.h,
            ),
            contentPadding: EdgeInsets.symmetric(
              horizontal: 20.h,
              vertical: 18.h,
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Address is required'.tr;
              }
              return null;
            },
          ),
          SizedBox(height: 24.h),
          CustomTextFormField(
            controller: controller.ageController,
            hintText: "Age".tr,
            textInputType: TextInputType.number,
            textInputAction: TextInputAction.done,
            prefix: Container(
              margin: EdgeInsets.fromLTRB(20.h, 18.h, 12.h, 18.h),
              child: CustomImageView(
                imagePath: ImageConstant.imgProfileWhite,
                height: 18.h,
                width: 20.h,
                fit: BoxFit.contain,
              ),
            ),
            prefixConstraints: BoxConstraints(
              maxHeight: 60.h,
            ),
            contentPadding: EdgeInsets.symmetric(
              horizontal: 20.h,
              vertical: 18.h,
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'age is required'.tr;
              }
              return null;
            },
          ),
        ],
      ),
    );
  }

}
