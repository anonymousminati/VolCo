import 'package:flutter/material.dart';
import 'package:volco/core/app_export.dart';
import 'package:volco/core/utils/image_constant.dart';
import 'package:volco/presentation/onboarding_two_screen/controller/onboading_two_controller.dart';
import 'package:volco/widgets/custom_elevated_button.dart';
import 'package:volco/widgets/custom_image_view.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboadingTwoScreen extends GetWidget<OnboadingTwoController> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SizedBox(
          width: double.maxFinite,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              CustomImageView(
                imagePath: ImageConstant.imgVolunteerYourTime,
                height: 420.h,
                width: double.maxFinite,
              ),
              SizedBox(height: 36.h),
              _buildTeachOrphansSection(),
              SizedBox(height: 48.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTeachOrphansSection() {
    return Container(
      width: double.maxFinite,
      margin: EdgeInsets.symmetric(horizontal: 24.h),
      child: Column(
        children: [
          SizedBox(
            width: double.maxFinite,
            child: Text(
              "Volunteer Your Time".tr,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: theme.textTheme.headlineLarge!.copyWith(
                height: 1.50,
              ),
            ),
          ),
          SizedBox(height: 6.h),
          SizedBox(
            width: double.maxFinite,
            child: Text(
              "Find opportunities to teach, clean, donate, and more.".tr,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyLarge!.copyWith(
                height: 1.50,
              ),
            ),
          ),
          SizedBox(height: 98.h),
          SizedBox(
            height: 8.h,
            child: AnimatedSmoothIndicator(
              activeIndex: 1,
              count: 3,
              effect: ScrollingDotsEffect(
                spacing: 6,
                activeDotColor: theme.colorScheme.primary,
                dotColor: appTheme.blueGray900,
                dotHeight: 8.h,
                dotWidth: 8.h,
              ),
            ),
          ),
          SizedBox(height: 32.h),
          SizedBox(
            width: double.maxFinite,
            child: Row(
              children: [
                Expanded(
                  child: CustomElevatedButton(
                    text: "skip".tr,
                    buttonStyle: CustomButtonStyle.fillBlueGray,
                    onPressed: () {
                      onTapSkip();
                    },
                  ),
                ),
                SizedBox(width: 20.h),
                Expanded(
                  child: CustomElevatedButton(
                    text: "next".tr,
                    onPressed: () {
                      onTapNext();
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Navigates to the letsYouInScreen when the action is triggered.
  void onTapSkip() {
    Get.toNamed(
      AppRoutes.letsYouInScreen,
    );
  }

  /// Navigates to the onboardingTwoScreen when the action is triggered.
  void onTapNext() {
    Get.toNamed(
      AppRoutes.onboardingThreeScreen,
    );
  }
}
