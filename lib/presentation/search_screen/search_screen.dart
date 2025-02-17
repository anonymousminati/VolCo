import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:volco/core/app_export.dart';
import 'package:volco/core/utils/image_constant.dart';
import 'package:volco/widgets/custom_event_catogory_card.dart';
import 'package:volco/widgets/event_card_widget.dart';
import 'package:volco/widgets/label_widget.dart';

import 'controller/search_controller.dart';

class SearchScreen extends StatelessWidget {
  final SearchEventController controller =
      Get.put(SearchEventController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: RefreshIndicator(
        onRefresh: () async {
          await controller.fetchOngoingUpcomingEvents();
        },
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: SizedBox(
            width: double.maxFinite,
            child: SingleChildScrollView(
              child: Container(
                width: double.maxFinite,
                padding: EdgeInsets.only(left: 24.h, right: 24.h, top: 10.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    buildHeader(),
                    SizedBox(height: 34.h),
                    _buildSearchBar(),
                    SizedBox(height: 24.h),
                    _buildCategoryList(),
                    SizedBox(height: 24.h),
                    _buildEventList(),
                  ],
                ),
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
    );
  }

  /// **Builds the search bar**
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
      prefixConstraints: BoxConstraints(maxHeight: 56.h),

      suffix: Container(
        margin: EdgeInsets.fromLTRB(16.h, 18.h, 20.h, 18.h),
        child: CustomImageView(
          imagePath: ImageConstant.imgSearchContrast,
          height: 18.h,
          width: 12.h,
          fit: BoxFit.contain,
        ),
      ),
      suffixConstraints: BoxConstraints(maxHeight: 56.h),
      contentPadding: EdgeInsets.symmetric(horizontal: 20.h, vertical: 18.h),
    );
  }

  /// **Builds the horizontal list of category labels**
  Widget _buildCategoryList() {
    return Obx(() {
      return controller.eventCategoriesLabelList.isEmpty
          ? Center(child: Text("No categories available"))
          : SizedBox(
        height: 50.h,
        child: ListView.separated(
          separatorBuilder: (context, index) => SizedBox(width: 10.h),
          scrollDirection: Axis.horizontal,
          itemCount: controller.eventCategoriesLabelList.length,
          itemBuilder: (context, index) {
            LabelWidget label = controller.eventCategoriesLabelList[index];
            String categoryName = label.labelText;

            return label;
          },
        ),
      );
    });
  }

  Widget _buildEventList() {
    return Obx(() => controller.eventList.isEmpty
        ? Center(child: Text("No events available"))
        : Column(
      spacing: 20.h,
      children: controller.eventList,
    ));
  }

  onTapImgIconsone() {}
}
