import 'package:flutter/material.dart';
import 'package:new_pinput/new_pinput.dart';
import 'package:volco/core/app_export.dart';
import 'package:volco/core/utils/image_constant.dart';
import 'package:volco/presentation/forgot_password_screen/controller/forgot_password_controller.dart';
import 'package:volco/presentation/reset_password_screen/controller/reset_password_controller.dart';
import 'package:volco/widgets/custom_elevated_button.dart';
import 'package:volco/widgets/custom_image_view.dart';
import 'package:volco/widgets/custom_text_form_field.dart';

class ResetPasswordScreen extends GetWidget<ResetPasswordController> {
  GlobalKey<FormState> _resetPasswordformKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Form(
          key: _resetPasswordformKey,
          child: SizedBox(
            width: double.maxFinite,
            child: SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 24.h, vertical: 10.h),
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
                      "Next Time don't forgot🔐".tr,
                      style: theme.textTheme.displayMedium!.copyWith(height: 1.50),
                    ),
                    SizedBox(height: 15.h),
                    Text(
                      "Enter new Password!".tr,
                      style: theme.textTheme.displayMedium!.copyWith(
                        height: 1.50,
                        fontSize: 25.fSize,
                      ),
                    ),
                    SizedBox(height: 20.h),

                          _buildEmailAndResetPasswordSection()
                   ,
                    SizedBox(height: 48.h),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }



  Widget _buildEmailAndResetPasswordSection() {
    return Column(
      children: [
        CustomTextFormField(
          controller: controller.passwordController,
          hintText: "new password".tr,
          textInputType: TextInputType.emailAddress,
          validator: (value) => controller.validatePassword(value),
        ),
        SizedBox(height: 24.h),
        CustomElevatedButton(
          text: "Submit".tr,
          onPressed: () {
            if (_resetPasswordformKey.currentState!.validate()) {
print("reset Password");
controller.resetPassword();
            }
          },
        ),
      ],
    );
  }
}
