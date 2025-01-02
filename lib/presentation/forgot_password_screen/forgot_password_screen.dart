import 'package:flutter/material.dart';
import 'package:new_pinput/new_pinput.dart';
import 'package:volco/core/app_export.dart';
import 'package:volco/core/utils/image_constant.dart';
import 'package:volco/presentation/forgot_password_screen/controller/forgot_password_controller.dart';
import 'package:volco/widgets/custom_elevated_button.dart';
import 'package:volco/widgets/custom_image_view.dart';
import 'package:volco/widgets/custom_text_form_field.dart';

class ForgotPasswordScreen extends GetWidget<ForgotPasswordController> {
  GlobalKey<FormState> _forgotPasswordformKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Form(
          key: _forgotPasswordformKey,
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
                      "It Happens, Everybody Forgot 😊".tr,
                      style: theme.textTheme.displayMedium!.copyWith(height: 1.50),
                    ),
                    SizedBox(height: 15.h),
                    Text(
                      "Enter your email!".tr,
                      style: theme.textTheme.displayMedium!.copyWith(
                        height: 1.50,
                        fontSize: 25.fSize,
                      ),
                    ),
                    SizedBox(height: 20.h),
                    Obx(() {
                      // Dynamically switch between sections based on `isOtpSent`
                      return controller.isOtpSent.value
                          ? _buildPinPut()
                          : _buildEmailSection();
                    }),
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

  Widget _buildPinPut() {
    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: TextStyle(
        fontSize: 20,
        color: Color.fromRGBO(30, 60, 87, 1),
        fontWeight: FontWeight.w600,
      ),
      decoration: BoxDecoration(
        border: Border.all(color: Color.fromRGBO(234, 239, 243, 1)),
        borderRadius: BorderRadius.circular(20),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(color: Color.fromRGBO(114, 178, 238, 1)),
      borderRadius: BorderRadius.circular(8),
    );

    final submittedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration?.copyWith(
        color: Color.fromRGBO(234, 239, 243, 1),
      ),
    );

    return Column(
      children: [
        Pinput(
          length: 6,
          autofocus: true,
          controller: controller.otpController,
          defaultPinTheme: defaultPinTheme,
          focusedPinTheme: focusedPinTheme,
          submittedPinTheme: submittedPinTheme,
        ),
        SizedBox(height: 24.h),
        CustomElevatedButton(
          text: "Verify OTP".tr,
          onPressed: () {
            controller.verifyOtp(controller.otpController.text);
          },
        ),
      ],
    );
  }

  Widget _buildEmailSection() {
    return Column(
      children: [
        CustomTextFormField(
          controller: controller.emailController,
          hintText: "email".tr,
          textInputType: TextInputType.emailAddress,
          validator: (value) => controller.validateEmail(value),
        ),
        SizedBox(height: 24.h),
        CustomElevatedButton(
          text: "Send OTP".tr,
          onPressed: () {
            controller.sendOtp();
          },
        ),
      ],
    );
  }
}
