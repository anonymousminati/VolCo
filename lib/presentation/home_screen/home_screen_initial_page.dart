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

  final HomeController controller = Get.find<HomeController>();

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
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildFloatingIconColumn(),
            SizedBox(height: 32.h),
            ElevatedButton(
              onPressed: () {
                Get.offAllNamed(AppRoutes.eventDescriptionScreen, arguments: {
                  "eventCreatedId":68,
                  "eventCategory": "Health & Wellness",
                });
              },
              child: Text("Go to Event Description"),
            ),
            SizedBox(height: 32.h),
            _buildRecommendationEventListView(context),

            SizedBox(height: 32.h),

            _buildEventListView(context),


          ],
        ),
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
                  onTap: () {},
                ),
                Obx(
                      () => CustomImageView(
                    imagePath: controller.avatarUrl.value.isEmpty
                        ? ImageConstant.imgProfileSkyBlue
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
            tileColor: appTheme.gray800,
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
        ],
      ),
    );
  }

  Widget _buildEventListView(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 20.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 20.h,
        children: [
          Text("Events Near You", style: CustomTextStyles.titleLarge20,textAlign: TextAlign.start,),
          Obx(
                () => controller.eventList.isEmpty
                ? Center(
              child: Text(
                "No events found!",
                style: TextStyle(color: Colors.white),
              ),
            )
                : SizedBox(
              height: 310.h, // Define a specific height to bound the ListView
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                // padding: EdgeInsets.symmetric(horizontal: 16.h),
                itemCount: controller.eventList.length,
                separatorBuilder: (context, index) => SizedBox(width: 12.h),
                itemBuilder: (context, index) => controller.eventList[index],
              ),
            ),
          ),
        ],
      ),
    );
  }
  Widget _buildRecommendationEventListView(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 20.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 20.h,
        children: [
          Text("Event Suggestions", style: CustomTextStyles.titleLarge20,textAlign: TextAlign.start,),
          Obx(
                () => controller.recommendedEventList.isEmpty
                ? Center(
              child: Text(
                "No events found!",
                style: TextStyle(color: Colors.white),
              ),
            )
                : SizedBox(
              height: 310.h, // Define a specific height to bound the ListView
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                // padding: EdgeInsets.symmetric(horizontal: 16.h),
                itemCount: controller.recommendedEventList.length,
                separatorBuilder: (context, index) => SizedBox(width: 12.h),
                itemBuilder: (context, index) => controller.recommendedEventList[index],
              ),
            ),
          ),
        ],
      ),
    );
  }
}