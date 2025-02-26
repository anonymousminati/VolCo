import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:volco/core/app_export.dart';
import 'package:volco/core/utils/authentication.dart';
import 'package:volco/core/utils/image_constant.dart';
import 'package:volco/presentation/home_screen/controller/home_controller.dart';
import 'package:volco/presentation/home_screen/themeStyleCheck.dart';
import 'package:volco/presentation/home_screen/widget/homeBanner.dart';
import 'package:volco/widgets/custom_google_map_location_picker.dart';
import 'package:volco/widgets/custom_outlined_button.dart';

class HomeScreenInitialPage extends StatelessWidget {
  HomeScreenInitialPage({super.key});

  HomeController controller = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    print(
        "user avatar print from updateuserdetailswithoutfiles ${controller.avatarUrl}");

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
                Get.offAllNamed(AppRoutes.eventDescriptionScreen, arguments: {
                  "eventCreatedId": 53,
                  "eventCategory": "Work With Elders"
                });
              },
            ),
            SizedBox(height: 4.h),

            CustomElevatedButton(
              text: "Google Map sheet open".tr,
              onPressed: () async {
                // Navigate to home screen if event creation is successful.
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  backgroundColor: Colors.transparent,
                  builder: (BuildContext context) {
                    return Container(
                      height: MediaQuery.of(context).size.height * 0.85,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: appTheme.gray800,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(16.0),
                          topRight: Radius.circular(16.0),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Text(
                              'Search for Place',
                              style: theme.textTheme.headlineSmall!.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 20),

                            // 🌍 Location Picker Widget
                            Expanded(
                              child: LocationPickerWidget(
                                onLocationSelected:
                                    (String placeName, LatLng coordinates) {
                                  controller.selectedPlaceName.value =
                                      placeName;
                                  controller.selectedCoordinates = coordinates;
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
            SizedBox(height: 32.h),
            CustomElevatedButton(
              text: "check theme".tr,
              onPressed: () async {
                // Navigate to home screen if event creation is successful.
             Get.to(() => Themestylecheck());
              },
            ),
// 📍 Display the selected location on Home Screen
            Obx(() {
              return Column(
                children: [
                  SizedBox(height: 20),
                  Text(
                    "Selected Place: ${controller.selectedPlaceName.value}",
                    style: theme.textTheme.bodyLarge!.copyWith(
                      color: appTheme.whiteA700,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Coordinates: ${controller.selectedCoordinates?.latitude}, ${controller.selectedCoordinates?.longitude}",
                    style: theme.textTheme.bodyMedium!.copyWith(
                      color: appTheme.whiteA700,
                    ),
                  ),
                ],
              );
            }),
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

                  },
                ),
                Obx(
                  () => CustomImageView(
                    imagePath: controller.avatarUrl.value.isEmpty
                        ? ImageConstant
                            .imgProfileSkyBlue // Fallback if URL is empty
                        : controller.avatarUrl.value,
                    height: 28.h,
                    width: 30.h,
                    margin: EdgeInsets.only(left: 20.h),
                    radius: BorderRadius.circular(14.h),
                    onTap: () {
                      Get.toNamed(AppRoutes.profileScreen);
                    },
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 34.h),
          RoundedImageWidget(imageUrl: ImageConstant.imgHomeBanner),
          SizedBox(height: 20.h),
          ListTile(
            contentPadding: EdgeInsets.symmetric(horizontal: 20.h),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.h),
              side: BorderSide(color: Colors.red, width: 2),
            ),
            tileColor: appTheme.gray800, // Background color
            leading: CustomImageView(
              imagePath: ImageConstant.imgSoS,
              height: 50.h,
              width: 50.h,
            ),
            title: Text(
              "Emergency Alert",
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
            ),
            subtitle: Text(
              "Mobilize volunteer quickly",
              style: TextStyle(color: Colors.white),
            ),
            trailing: AspectRatio(
              aspectRatio: 1,
              child: Container(
                height: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.h),
                ),
                child: Icon(
                  Icons.warning_rounded,
                  color: Colors.red,
                  size: 60.h,
                ),
              ),
            ),
          ),
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
