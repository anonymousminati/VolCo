import 'package:flutter/material.dart';
import 'package:volco/core/app_export.dart';
import 'package:volco/core/utils/image_constant.dart';
import 'package:volco/core/utils/validation_functions.dart';
import 'package:volco/presentation/sign_in_screen/controller/sign_in_controller.dart';
import 'package:volco/widgets/custom_elevated_button.dart';
import 'package:volco/widgets/custom_image_view.dart';
import 'package:volco/widgets/custom_text_form_field.dart';

class SignInScreen extends GetWidget<SignInController> {
  GlobalKey<FormState> _signinformKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Form(
          key: _signinformKey,
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
                      onTap: () {
                        Get.back();
                      },
                    ),
                    SizedBox(height: 70.h),
                    Text(
                      "Login To Your Account".tr,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.displayMedium!.copyWith(
                        height: 1.50,
                      ),
                    ),
                    SizedBox(height: 20.h),
                    _buildLoginSection(),
                    SizedBox(height: 56.h),
                    _buildDividerSection(),
                    SizedBox(height: 32.h),
                    Container(
                      width: double.maxFinite,
                      margin: EdgeInsets.symmetric(horizontal: 38.h),
                      child: Row(
                        children: [
                          Expanded(
                            child: Container(
                              height: 60.h,
                              decoration: BoxDecoration(
                                color: appTheme.blueGray900,
                                borderRadius: BorderRadiusStyle.roundedBorder16,
                                border: Border.all(
                                  color: appTheme.gray700,
                                  width: 1.h,
                                ),
                              ),
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  CustomImageView(
                                    imagePath: ImageConstant.imgFacebook,
                                    height: 24.h,
                                    width: 26.h,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(width: 20.h),
                          Expanded(
                            child: GestureDetector(
                              onTap: (){
                                AuthController().signInWithGoogle();
                              },
                              child: Container(
                                height: 60.h,
                                decoration: BoxDecoration(
                                  color: appTheme.blueGray900,
                                  borderRadius: BorderRadiusStyle.roundedBorder16,
                                  border: Border.all(
                                    color: appTheme.gray700,
                                    width: 1.h,
                                  ),
                                ),
                                child: Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    CustomImageView(
                                      imagePath: ImageConstant.imgGoogle,
                                      height: 24.h,
                                      width: 26.h,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 20.h),
                          Expanded(
                            child: Container(
                              height: 60.h,
                              decoration: BoxDecoration(
                                color: appTheme.blueGray900,
                                borderRadius: BorderRadiusStyle.roundedBorder16,
                                border: Border.all(
                                  color: appTheme.gray700,
                                  width: 1.h,
                                ),
                              ),
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  CustomImageView(
                                    imagePath: ImageConstant.imgApple,
                                    height: 24.h,
                                    width: 26.h,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 48.h),
                    Align(
                      alignment: Alignment.center,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "don't have an account?".tr,
                            style: CustomTextStyles.bodyMediumGray50,
                          ),
                          SizedBox(width: 8.h),
                          GestureDetector(
                            onTap: () {
                              onTapTxtSignupone();
                            },
                            child: Text(
                              "sign up".tr,
                              style: CustomTextStyles.titleSmallPrimary,
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLoginSection() {
    return SizedBox(
        width: double.maxFinite,
        child: Column(
          children: [
            CustomTextFormField(
              controller: controller.emailController,
              hintText: "email".tr,
              textInputType: TextInputType.emailAddress,
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
                controller.validateEmail(value);
              },
            ),
            SizedBox(height: 24.h),
            Obx(() => CustomTextFormField(
                  controller: controller.passwordController,
                  hintText: "password".tr,
                  textInputType: TextInputType.visiblePassword,
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
                  suffix: InkWell(
                    onTap: () {
                      controller.togglePasswordVisibility();
                    },
                    child: Container(
                      margin: EdgeInsets.fromLTRB(16.h, 18.h, 20.h, 18.h),
                      child: CustomImageView(
                        imagePath: controller.isShowPassword.value
                            ? ImageConstant.imgEyeSlash
                            : ImageConstant.imgEye,
                        height: 18.h,
                        width: 20.h,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  suffixConstraints: BoxConstraints(
                    maxHeight: 60.h,
                  ),
                  obscureText: controller.isShowPassword.value,
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 20.h,
                    vertical: 18.h,
                  ),
                  validator: (value) {
                    controller.validatePassword(value);
                  },
                )),
            SizedBox(height: 24.h),
            SizedBox(
              width: double.maxFinite,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: Container(
                      height: 24.h,
                      width: 24.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                          4.h,
                        ),
                        border: Border.all(
                          color: theme.colorScheme.primary,
                          width: 1.h,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 12.h),
                    child: Text(
                      "remember me!".tr,
                      style: theme.textTheme.titleSmall,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 24.h),
            CustomElevatedButton(
              text: "Sign In".tr,
              onPressed: (){
               controller.signInUser();

              },
            ),
            SizedBox(height: 24.h),
            GestureDetector(
              onTap: () {
                onTapTxtForgotPassword();
              },
              child: Text(
                "forgot the Password?".tr,
                style: CustomTextStyles.titleMediumPrimary,
              ),
            )
          ],
        ));
  }

  /// Section Widget
  Widget _buildDividerSection() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 18.h),
      width: double.maxFinite,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(bottom: 8.h),
              child: Divider(),
            ),
          ),
          SizedBox(width: 20.h),
          Align(
            alignment: Alignment.center,
            child: Text(
              "or Continue with".tr,
              style: CustomTextStyles.titleMediumGray50,
            ),
          ),
          SizedBox(width: 20.h),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(bottom: 8.h),
              child: Divider(),
            ),
          ),
        ],
      ),
    );
  }

  onTapTxtForgotPassword() {
    Get.toNamed(
      AppRoutes.forgotPasswordScreen ,
    );
  }
  /// Navigates to the signUpBlankScreen when the action is triggered.
  onTapTxtSignupone() {
    Get.toNamed(
      AppRoutes.signUpScreen,
    );
  }
}
