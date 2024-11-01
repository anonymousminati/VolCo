import 'package:flutter/material.dart';
import 'package:volco/core/app_export.dart';
import 'package:volco/core/utils/image_constant.dart';
import 'package:volco/presentation/home_screen/controller/home_controller.dart';
import 'package:volco/presentation/home_screen/models/homescreenlist_item_model.dart';
import 'package:volco/presentation/home_screen/widget/homescreenlist_item_widget.dart';
import 'package:volco/widgets/custom_outlined_button.dart';

class HomeScreenInitialPage extends StatelessWidget {
  HomeScreenInitialPage({super.key});

  HomeController controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        width: double.maxFinite,
        padding: EdgeInsets.symmetric(vertical: 8.h),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildFloatingIconColumn(),
            SizedBox(height: 32.h),
            _buildHotelRow(),
            SizedBox(height: 32.h),
            Container(
              width: double.maxFinite,
              margin: EdgeInsets.symmetric(horizontal: 24.h),
              child: Column(
                children: [
                  SizedBox(
                    width: double.maxFinite,
                    child: Column(
                      children: [
                        _buildRecentlyBookedRow(),
                        SizedBox(height: 16.h),
                        _buildHomeScreenList(),
                      ],
                    ),
                  ),
                ],
              ),
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
      hintText: "lbl_search".tr,
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
                    "lbl_comfort".tr,
                    style: theme.textTheme.headlineSmall,
                  ),
                ),
                Spacer(),
                CustomImageView(
                  imagePath: ImageConstant.imgBellBlue,
                  height: 28.h,
                  width: 30.h,
                  onTap: () {
                    onTapImgIconsone();
                  },
                ),
                CustomImageView(
                  imagePath: ImageConstant.imgSettingSkyBlue,
                  height: 28.h,
                  width: 30.h,
                  margin: EdgeInsets.only(left: 20.h),
                ),
              ],
            ),
          ),
          SizedBox(height: 34.h),
          Text(
            "msg_hello_daniel".tr,
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
      width: double.maxFinite,
      margin: EdgeInsets.only(left: 24.h),
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: 400.h,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  CustomImageView(
                    imagePath: ImageConstant.imgVolunteeringCleaning,
                    height: 400.h,
                    width: double.maxFinite,
                    radius: BorderRadius.circular(36.h),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      width: double.maxFinite,
                      margin: EdgeInsets.only(top: 32.h),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          _buildFortyEight(),
                          Spacer(),
                          Container(
                            width: double.maxFinite,
                            margin: EdgeInsets.only(right: 12.h),
                            padding: EdgeInsets.symmetric(
                                horizontal: 32.h, vertical: 20.h),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadiusStyle.customBorderBL36,
                              gradient: LinearGradient(
                                  begin: Alignment(0.5, 0),
                                  end: Alignment(0.5, 1),
                                  colors: [
                                    appTheme.gray80000,
                                    appTheme.blueGray90059,
                                    appTheme.gray900.withOpacity(0.59)
                                  ]),
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 16.h),
                                Text(
                                  "msg_emeralda_de_hotel".tr,
                                  style: theme.textTheme.headlineSmall,
                                ),
                                SizedBox(height: 12.h),
                                Text(
                                  "lbl_paris_france".tr,
                                  style: CustomTextStyles.bodyLarge16,
                                ),
                                SizedBox(height: 12.h),
                                SizedBox(
                                  width: double.maxFinite,
                                  child: Row(
                                    children: [
                                      Text(
                                        "lbl_29".tr,
                                        style: theme.textTheme.headlineSmall,
                                      ),
                                      Align(
                                        alignment: Alignment.bottomCenter,
                                        child: Padding(
                                          padding: EdgeInsets.only(
                                            left: 4.h,
                                            bottom: 4.h,
                                          ),
                                          child: Text(
                                            "lbl_per_night".tr,
                                            style: CustomTextStyles
                                                .bodyMediumWhiteA700,
                                          ),
                                        ),
                                      ),
                                      Spacer(),
                                      CustomImageView(
                                        imagePath: ImageConstant.imgBookmarkSkyblue,
                                        height: 28.h,
                                        width: 30.h,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: IntrinsicWidth(
              child: SizedBox(
                height: 400.h,
                width: 312.h,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    CustomImageView(
                      imagePath: ImageConstant.imgVolunteeringCleaning,
                      height: 400.h,
                      width: double.maxFinite,
                      radius: BorderRadius.circular(36.h),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        width: double.maxFinite,
                        margin: EdgeInsets.only(left: 12.h),
                        padding: EdgeInsets.symmetric(
                            horizontal: 32.h, vertical: 20.h),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadiusStyle.customBorderBL36,
                          gradient: LinearGradient(
                            begin: Alignment(0.5, 0),
                            end: Alignment(0.5, 1),
                            colors: [
                              appTheme.gray80000,
                              appTheme.blueGray90059,
                              appTheme.gray900.withOpacity(0.59)
                            ],
                          ),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 16.h),
                            Text(
                              "msg_emeralda_de_hotel".tr,
                              style: theme.textTheme.headlineSmall,
                            ),
                            SizedBox(height: 12.h),
                            Text(
                              "lbl_paris_france".tr,
                              style: CustomTextStyles.bodyLarge16,
                            ),
                            SizedBox(height: 12.h),
                            SizedBox(
                              width: double.maxFinite,
                              child: Row(
                                children: [
                                  Text(
                                    "lbl_29".tr,
                                    style: theme.textTheme.headlineSmall,
                                  ),
                                  Align(
                                    alignment: Alignment.bottomCenter,
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                        left: 4.h,
                                        bottom: 4.h,
                                      ),
                                      child: Text(
                                        "lbl_per_night".tr,
                                        style: CustomTextStyles
                                            .bodyMediumWhiteA700,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
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
