import 'package:flutter/material.dart';
import 'package:volco/core/app_export.dart';
import 'package:volco/core/utils/image_constant.dart';
import 'package:volco/presentation/home_screen/controller/home_controller.dart';
import 'package:volco/presentation/home_screen/models/homescreenlist_item_model.dart';

class HomescreenlistItemWidget extends StatelessWidget {
  HomescreenlistItemWidget(this.homescreenlistItemModelObj, {super.key});

  HomescreenlistItemModel homescreenlistItemModelObj;

  var controller = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 20.h,
        vertical: 18.h,
      ),
      decoration: BoxDecoration(
        color: appTheme.blueGray900,
        borderRadius: BorderRadiusStyle.roundedBorder16,
        boxShadow: [
          BoxShadow(
            color: appTheme.black9000c,
            spreadRadius: 2.h,
            blurRadius: 2.h,
            offset: Offset(
              0,
              4,
            ),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Obx(
            () => CustomImageView(
              imagePath: homescreenlistItemModelObj.martinezCannes!.value,
              height: 100.h,
              width: 100.h,
              radius: BorderRadius.circular(16.h),
            ),
          ),
          SizedBox(
            width: 16.h,
          ),
          Expanded(
            child: Align(
              alignment: Alignment.topLeft,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Obx(
                    () => Text(
                      homescreenlistItemModelObj.presidenthotel!.value,
                      style: theme.textTheme.titleLarge,
                    ),
                  ),
                  SizedBox(
                    height: 14.h,
                  ),
                  Obx(
                    () => Text(
                      homescreenlistItemModelObj.parisfrance!.value,
                      style: theme.textTheme.bodyMedium,
                    ),
                  ),
                  SizedBox(
                    height: 14.h,
                  ),
                  SizedBox(
                    width: double.maxFinite,
                    child: Row(
                      children: [
                        CustomImageView(
                          imagePath: ImageConstant.imgStarFilledYellow,
                          height: 12.h,
                          width: 12.h,
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 4.h),
                          child: Obx(
                            () => Text(
                              homescreenlistItemModelObj.fortyEight!.value,
                              style: CustomTextStyles.titleSmallPrimary,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 8.h),
                          child: Obx(
                            () => Text(
                              homescreenlistItemModelObj.reviews!.value,
                              style: theme.textTheme.bodySmall,
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
          SizedBox(
            width: 16.h,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Obx(
                () => Text(
                  homescreenlistItemModelObj.price!.value,
                  style: CustomTextStyles.headlineSmallPrimary,
                ),
              ),
              SizedBox(height: 2.h),
              Obx(
                () => Text(
                  homescreenlistItemModelObj.night!.value,
                  style: theme.textTheme.labelMedium,
                ),
              ),
              SizedBox(height: 16.h),
              CustomImageView(
                imagePath: ImageConstant.imgBookmarkSkyblue,
                height: 24.h,
                width: 26.h,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
