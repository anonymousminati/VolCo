import 'package:flutter/material.dart';
import 'package:volco/core/app_export.dart';
import 'package:volco/core/utils/image_constant.dart';
import 'package:volco/presentation/splash_screen/controller/splash_controller.dart';
import 'package:volco/widgets/custom_image_view.dart';

class SplashScreen extends GetWidget<SplashController> {
  @override
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          width: double.maxFinite,
          padding: EdgeInsets.all(24.h),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [_buildFloatingIconSection(), SizedBox(height: 26.h)],
          ),
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildFloatingIconSection() {
    return SizedBox(
      width: double.maxFinite,
      child: Column(
        children: [
          CustomImageView(
            imagePath: ImageConstant.imgLogoStandard,
            height: 80.h,
            width: 80.h,
          ),
          SizedBox(height: 46.h),
          Text(
            "VolCo".tr,
            style: theme.textTheme.displayMedium,
          ),
        ],
      ),
    );
  }
}
