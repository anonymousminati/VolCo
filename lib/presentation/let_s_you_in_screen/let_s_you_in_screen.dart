import 'package:flutter/material.dart';
import 'package:volco/core/app_export.dart';
import 'package:volco/core/utils/image_constant.dart';
import 'package:volco/presentation/let_s_you_in_screen/controller/let_s_you_in_controller.dart';
import 'package:volco/presentation/onboarding_three_screen/controller/onboading_three_controller.dart';

import 'package:volco/widgets/custom_elevated_button.dart';
import 'package:volco/widgets/custom_image_view.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class LetSYouInScreen extends GetWidget<LetsYouInController> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
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
                children: [
                  CustomImageView(
                    imagePath: ImageConstant.imgArrowLeft,
                    height: 28.h,
                    width: 30.h,
                    alignment: Alignment.centerLeft,
                  ),
                  SizedBox(height: 134.h),
                  Text(
                    "Let's You In".tr,
                    style: theme.textTheme.displayMedium,
                  ),
                  SizedBox(height: 90.h),
                  _buildSocialMediaLoginSection(),
                  SizedBox(height: 58.h),
                  _buildDividerRow(),
                  SizedBox(height: 56.h),
                  _buildPasswordSignInButton(),
                  SizedBox(height: 100.h),
                  Row(
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
                  SizedBox(height: 36.h)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildFacebookLoginButton() {
    return CustomElevatedButton(
      height: 60.h,
      text: "Continue with Facebook".tr,
      leftIcon: Container(
        margin: EdgeInsets.only(right: 12.h),
        child: CustomImageView(
          imagePath: ImageConstant.imgFacebook,
          height: 24.h,
          width: 24.h,
          fit: BoxFit.contain,
        ),
      ),
      buttonStyle: CustomButtonStyle.fillBlueGrayTL16,
      buttonTextStyle: CustomTextStyles.titleMediumSemiBold,
    );
  }

  Widget _buildGoogleLoginButton() {
    return CustomElevatedButton(
      height: 60.h,
      text: "Continue with Google".tr,
      leftIcon: Container(
        margin: EdgeInsets.only(right: 12.h),
        child: CustomImageView(
          imagePath: ImageConstant.imgGoogle,
          height: 24.h,
          width: 24.h,
          fit: BoxFit.contain,
        ),
      ),
      buttonStyle: CustomButtonStyle.fillBlueGrayTL16,
      buttonTextStyle: CustomTextStyles.titleMediumSemiBold,
    );
  }

  Widget _buildAppleLoginButton() {
    return CustomElevatedButton(
      height: 60.h,
      text: "Continue with Apple".tr,
      leftIcon: Container(
        margin: EdgeInsets.only(right: 12.h),
        child: CustomImageView(
          imagePath: ImageConstant.imgApple,
          height: 24.h,
          width: 24.h,
          fit: BoxFit.contain,
        ),
      ),
      buttonStyle: CustomButtonStyle.fillBlueGrayTL16,
      buttonTextStyle: CustomTextStyles.titleMediumSemiBold,
    );
  }

  Widget _buildSocialMediaLoginSection() {
    return SizedBox(
      width: double.maxFinite,
      child: Column(
        children: [
          _buildFacebookLoginButton(),
          SizedBox(height: 16.h),
          _buildGoogleLoginButton(),
          SizedBox(height: 16.h),
          _buildAppleLoginButton(),
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildDividerRow() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 18.h),
      width: double.maxFinite,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(top: 2.h),
              child: Divider(),
            ),
          ),
          SizedBox(width: 16.h),
          CustomImageView(
            imagePath: ImageConstant.imgOr,
            height: 8.h,
            width: 16.h,
            alignment: Alignment.center,
          ),
          SizedBox(width: 16.h),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(top: 2.h),
              child: Divider(),
            ),
          ),
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildPasswordSignInButton() {
    return CustomElevatedButton(
      text: "Sign In with Password".tr,
      onPressed: () {
        onTapPasswordSignInButton();
      },
    );
  }

  /// Navigates to the signInScreen when the action is triggered.
  onTapPasswordSignInButton() {
    Get.toNamed(
      AppRoutes.signInScreen,
    );
  }

  /// Navigates to the signUpBlankScreen when the action is triggered.
  onTapTxtSignupone() {
    // Get.toNamed(
    //   AppRoutes.signUpBlankScreen,
    // );
  }
}
