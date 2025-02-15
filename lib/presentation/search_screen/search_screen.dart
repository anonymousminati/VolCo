import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:volco/core/app_export.dart';
import 'package:volco/core/utils/image_constant.dart';
import 'package:volco/widgets/custom_event_catogory_card.dart';

import 'controller/search_controller.dart';

class SearchScreen extends StatelessWidget {
  final SearchEventController controller =
      Get.put(SearchEventController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: SizedBox(
          width: double.maxFinite,
          child: RefreshIndicator(
            onRefresh: () async {

              controller.fetchAvatarUrl();
              controller.initializeEventCategories();
              controller.shuffleAndPrintColors();
            },
            child: SingleChildScrollView(
              child: Container(
                width: double.maxFinite,
                padding: EdgeInsets.only(
                  left: 24.h,
                  right: 24.h,
                  top: 10.h,
                ),
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
                              imagePath: controller.avatarUrl.value.isEmpty
                                  ? ImageConstant
                                      .imgProfileSkyBlue // Fallback if URL is empty
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
                      "Select Type of Event".tr,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.displayMedium!.copyWith(
                        height: 1.50,
                      ),
                    ),
                    SizedBox(height: 24.h),

                    _buildCotogorySelectSection(),
                    // Save Button
                    SizedBox(height: 24.h),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCotogorySelectSection() {
    return SizedBox(
      width: double.maxFinite,
      child: Obx(() => GridView.builder(
            itemCount: controller.eventCategories.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              final category = controller.eventCategories[index];

              return EventCatogoryCard(
                text: category.categoryName,
                imageUrl: category.imageIcon,
                color: controller.myColors[index],
                // subtitle: category.categoryName,
                onPressed: () {
                  print("category.categoryName: ${category.categoryName}");

                  Get.toNamed(
                    AppRoutes.createEventScreen,
                    arguments: {'categoryType': category.categoryName},
                  );
                  controller.update();
                },
              );
            },
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, // number of items in each row
              mainAxisSpacing: 20.0, // spacing between rows
              crossAxisSpacing: 20.0, // spacing between columns
            ),
          )),
      //   children: [
      //
      //     // First Name
      //     EventCatogoryCard(
      //       text: "Wedding",
      //       imageUrl: category.imageIcon,
      //       subtitle: category.categoryName,
      //       onPressed: () {
      //        Get.toNamed(category.redirectString);
      //         // controller.update();
      //       },
      //     ),
      //
      //   ],
      // ),
    );
  }

  onTapImgIconsone() {}
}
