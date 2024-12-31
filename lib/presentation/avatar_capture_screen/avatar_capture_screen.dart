import 'dart:io';

import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:volco/core/app_export.dart';
import 'package:volco/core/utils/image_constant.dart';
import 'package:volco/presentation/avatar_capture_screen/controller/avatar_capture_controller.dart';
import 'package:volco/widgets/border_beam_animation.dart';
import 'package:volco/widgets/custom_elevated_button.dart';
import 'package:volco/widgets/custom_image_view.dart';

class AvatarCaptureScreen extends GetWidget<AvatarCaptureController> {


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: SizedBox(
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
                    onTap: () {
                      Get.back();
                    },
                  ),
                  SizedBox(height: 70.h),
                  Text(
                    textAlign:TextAlign.center ,
                    "Upload your Avatar".tr,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.displayMedium!.copyWith(
                      height: 1.50,
                    ),
                  ),
                  SizedBox(height: 70.h),
                  // Profile Image Picker
                  Center(
                    child: Obx(() {
                      return BorderBeam(
                        duration: 7,
                        colorFrom: Colors.blue,
                        colorTo: Colors.purple,
                        borderWidth: 4,
                        staticBorderColor:
                        const Color.fromARGB(255, 39, 39, 42), //rgb(39 39 42)
                        borderRadius: BorderRadius.circular(166.h),
                        padding: EdgeInsets.all(16),
                        child: GestureDetector(
                          onTap: () => controller.pickImage(),
                          child: CircleAvatar(
                            radius: 150.h,
                            backgroundImage: controller.pickedImage.value != null
                                ? FileImage(File(controller.pickedImage.value!.path))
                                : null,
                            child: controller.pickedImage.value == null
                                ? const Icon(Icons.camera_alt, size: 50)
                                : null,
                          ),
                        ),
                      );
                    }),
                  ),
                  SizedBox(height: 70.h),

                  CustomElevatedButton(
                    text: "Upload and Next".tr,
                    onPressed:()=> controller.uploadAvatar(),
                  ),
                  SizedBox(height: 56.h),

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }



}
