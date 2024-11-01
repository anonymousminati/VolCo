import 'package:flutter/material.dart';
import 'package:volco/core/app_export.dart';
import 'package:volco/core/utils/image_constant.dart';
import 'package:volco/presentation/welcome_screen/controller/welcome_controller.dart';
import 'package:volco/widgets/custom_image_view.dart';

class WelcomeScreen extends GetWidget<WelcomeController> {
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
                imagePath: ImageConstant.imgWelcomeRectangle1,
                height: 420.h,
                width: double.maxFinite,
              ),
              SizedBox(height: 76.h),
              _buildWelcomeMessage()
            ],
          ),
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildWelcomeMessage() {
    return Container(
      width: double.maxFinite,
      margin: EdgeInsets.symmetric(horizontal: 24.h),
      padding: EdgeInsets.only(left: 8.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "welcome_to".tr,
            style: theme.textTheme.displayMedium,
          ),
          SizedBox(height: 22.h),
          Text(
            "Volco".tr,
            style: theme.textTheme.displayLarge,
          ),
          SizedBox(height: 40.h),
          SizedBox(
            width: 320.h,
            child: Text(
              '"Let\'s Make World Beautiful"'.tr,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: CustomTextStyles.titleMediumSemiBold_1.copyWith(
                height: 1.50,
                fontStyle: FontStyle.italic
              ),
            ),
          )
        ],
      ),
    );
  }
}
