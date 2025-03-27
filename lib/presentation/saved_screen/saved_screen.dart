import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:volco/core/app_export.dart';
import 'package:volco/core/utils/image_constant.dart';
import 'package:volco/widgets/custom_image_view.dart';
import 'package:volco/widgets/event_card_widget.dart';
import 'package:volco/widgets/label_widget.dart';
import 'controller/saved_controller.dart';

class SavedScreen extends StatelessWidget {
  final SavedController controller = Get.put(SavedController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: RefreshIndicator(
        onRefresh: () async {
          await controller.fetchFavoriteEventsList();
        },
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: SingleChildScrollView(
            child: Container(
              width: double.maxFinite,
              padding: EdgeInsets.symmetric(horizontal: 24.h, vertical: 10.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildHeader(),
                  SizedBox(height: 34.h),
                  // _buildCategoryList(),
                  // SizedBox(height: 20.h),
                  _buildFavoriteEventList(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildHeader() {
    return SizedBox(
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
              "Favorites".tr,
              style: theme.textTheme.headlineSmall?.copyWith(color: Colors.white),
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
              // Handle notifications tap if needed.
            },
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
            ),
          ),
        ],
      ),
    );
  }

  /// Builds a horizontal list of category labels (if any).
  // Widget _buildCategoryList() {
  //   return Obx(() {
  //     return controller.eventCategoriesLabelList.isEmpty
  //         ? SizedBox.shrink()
  //         : SizedBox(
  //       height: 50.h,
  //       child: ListView.separated(
  //         scrollDirection: Axis.horizontal,
  //         itemCount: controller.eventCategoriesLabelList.length,
  //         separatorBuilder: (context, index) => SizedBox(width: 10.h),
  //         itemBuilder: (context, index) {
  //           return controller.eventCategoriesLabelList[index];
  //         },
  //       ),
  //     );
  //   });
  // }

  /// Builds a horizontal ListView of favorite events.
  Widget _buildFavoriteEventList() {
    return Obx(() {
      if (controller.eventList.isEmpty) {
        return Center(
          child: Text("No favorite events found!", style: TextStyle(color: Colors.white)),
        );
      }
      return ListView.separated(
        shrinkWrap: true,
        itemCount: controller.eventList.length,
        separatorBuilder: (context, index) => SizedBox(width: 12.h),
        itemBuilder: (context, index) {
          return controller.eventList[index];
        },
      );
    });
  }
}
