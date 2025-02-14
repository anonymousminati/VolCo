import 'dart:async';

import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:volco/core/app_export.dart';
import 'package:volco/core/utils/authentication.dart';
import 'package:volco/core/utils/image_constant.dart';
import 'package:volco/presentation/home_screen/controller/home_controller.dart';
import 'package:volco/presentation/home_screen/models/homescreenlist_item_model.dart';
import 'package:volco/presentation/home_screen/widget/homescreenlist_item_widget.dart';
import 'package:volco/widgets/custom_outlined_button.dart';

class HomeScreenInitialPage extends StatelessWidget {
  HomeScreenInitialPage({super.key});

  HomeController controller = Get.find<HomeController>();



  @override
  Widget build(BuildContext context) {
    print("user avatar print from updateuserdetailswithoutfiles ${controller.avatarUrl}");

    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Container(
        width: double.maxFinite,
        padding: EdgeInsets.symmetric(vertical: 8.h),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildFloatingIconColumn(),
            SizedBox(height: 32.h),
            CustomElevatedButton(
              text: "Submit".tr,
              onPressed: () async {

                    // Navigate to home screen if event creation is successful.
                    Get.offAllNamed(AppRoutes.eventDescriptionScreen,arguments: {
                      "eventCreatedId":46,
                      "eventCategory":"Cleaning"

                    });

              },
            ),

            SizedBox(height: 4.h),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchBar() {
    return CustomTextFormField(
      controller: controller.searchBarController,
      hintText: "search".tr,
      hintStyle: CustomTextStyles.bodyMediumGray500,
      textInputAction: TextInputAction.done,
      prefix: Container(
        margin: EdgeInsets.fromLTRB(20.h, 18.h, 12.h, 18.h),
        child: CustomImageView(
          imagePath: ImageConstant.imgSearchGray,
          height: 18.h,
          width: 20.h,
          fit: BoxFit.contain,
        ),
      ),
      prefixConstraints: BoxConstraints(
        maxHeight: 56.h,
      ),
      suffix: Container(
        margin: EdgeInsets.fromLTRB(16.h, 18.h, 20.h, 18.h),
        child: CustomImageView(
          imagePath: ImageConstant.imgSearchContrast,
          height: 18.h,
          width: 12.h,
          fit: BoxFit.contain,
        ),
      ),
      suffixConstraints: BoxConstraints(
        maxHeight: 56.h,
      ),
      contentPadding: EdgeInsets.symmetric(
        horizontal: 20.h,
        vertical: 18.h,
      ),
    );
  }

  /// Section Widget
  Widget _buildRecommendedButton() {
    return CustomElevatedButton(
      height: 38.h,
      width: 150.h,
      text: "recommended".tr,
      buttonStyle: CustomButtonStyle.fillPrimaryTL18,
      buttonTextStyle: CustomTextStyles.titleMediumSemiBold,
    );
  }

  /// Section Widget
  Widget _buildPopularButton() {
    return Expanded(
      child: CustomOutlinedButton(
        text: "popular".tr,
      ),
    );
  }

  /// Section Widget
  Widget _buildTrendingButton() {
    return Expanded(
      child: CustomOutlinedButton(
        text: "trending".tr,
      ),
    );
  }

  Widget _buildFloatingIconColumn() {

    return Container(
      width: double.maxFinite,
      margin: EdgeInsets.symmetric(horizontal: 24.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: double.maxFinite,
            child: Row(
              children: [
                CustomImageView(
                  imagePath: ImageConstant.imgLogoStandard,
                  height: 32.h,
                  width: 34.h,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 16.h),
                  child: Text(
                    "VolCo".tr,
                    style: theme.textTheme.headlineSmall,
                  ),
                ),
                Spacer(),
                CustomImageView(
                  imagePath: ImageConstant.imgLocation,
                  height: 28.h,
                  width: 30.h,
                  onTap: () {
AuthController().logout();
                  },
                ),
                CustomImageView(
                  imagePath: ImageConstant.imgBellBlue,
                  height: 28.h,
                  width: 30.h,
                  onTap: () {
                    onTapImgIconsone();
                  },
                ),
                Obx(
                  () => CustomImageView(
                    imagePath:controller.avatarUrl.value.isEmpty
                        ? ImageConstant.imgProfileSkyBlue // Fallback if URL is empty
                        : controller.avatarUrl.value,
                    height: 28.h,
                    width: 30.h,
                    margin: EdgeInsets.only(left: 20.h),
                    radius: BorderRadius.circular(14.h),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 34.h),
          Text(
            "hello Prathamesh".tr,
            style: theme.textTheme.headlineLarge,
          ),
          SizedBox(height: 22.h),
          _buildSearchBar(),
          SizedBox(height: 30.h),
          SizedBox(
            width: double.maxFinite,
            child: Row(
              children: [
                _buildRecommendedButton(),
                SizedBox(width: 14.h),
                _buildPopularButton(),
                SizedBox(width: 14.h),
                _buildTrendingButton()
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildFortyEight() {
    return CustomElevatedButton(
      height: 32.h,
      width: 70.h,
      text: "lbl_4_8".tr,
      margin: EdgeInsets.only(right: 34.h),
      leftIcon: Container(
        margin: EdgeInsets.only(right: 8.h),
        child: CustomImageView(
          imagePath: ImageConstant.imgStarFilledWhite,
          height: 12.h,
          width: 12.h,
          fit: BoxFit.contain,
        ),
      ),
      buttonStyle: CustomButtonStyle.fillPrimaryTL18,
      buttonTextStyle: theme.textTheme.titleSmall!,
    );
  }

  Widget _buildHotelRow() {
    return Container(
        width: 500,
        alignment: Alignment.centerLeft,
        margin: EdgeInsets.only(left: 24.h),
        child: SizedBox(
            width: double.maxFinite, height: 400.h, child: Text("helllll"),),);
  }

  /// Section Widget
  Widget _buildRecentlyBookedRow() {
    return SizedBox(
      width: double.maxFinite,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "lbl_recently_booked".tr,
            style: theme.textTheme.titleMedium,
          ),
          GestureDetector(
            onTap: () {
              onTapTxtSeeallone();
            },
            child: Text(
              "lbl_see_all".tr,
              style: CustomTextStyles.titleMediumPrimary16,
            ),
          ),
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildHomeScreenList() {
    return Obx(
      () => ListView.separated(
        padding: EdgeInsets.zero,
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        separatorBuilder: (context, index) {
          return SizedBox(
            height: 24.h,
          );
        },
        itemCount: controller.homeScreenInitialModelObj.value
            .homescreenlistItemList.value.length,
        itemBuilder: (context, index) {
          HomescreenlistItemModel model = controller.homeScreenInitialModelObj
              .value.homescreenlistItemList.value[index];
          return HomescreenlistItemWidget(
            model,
          );
        },
      ),
    );
  }

  /// TODO:Navigates to the notificationsScreen when the action is triggered.
  onTapImgIconsone() {
    // Get.toNamed(
    //   AppRoutes.notificationsScreen,
    // );
  }

  /// TODO:Navigates to the recentlyBooked Screen when the action is triggered.
  onTapTxtSeeallone() {
    // Get.toNamed(
    //   AppRoutes.recentlyBookedScreen,
    // );
  }
}
