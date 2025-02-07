import 'dart:io';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:volco/core/app_export.dart';
import 'package:volco/core/utils/image_constant.dart';
import 'package:volco/core/utils/supabase_handler.dart';
import 'package:volco/core/utils/validation_functions.dart';
import 'package:volco/presentation/create_event_catogory_screen/controller/create_event_catogory_controller.dart';
import 'package:volco/presentation/user_details_screen/controller/user_details_controller.dart';

class CreateEventCatogoryScreen extends StatelessWidget {
  final CreateEventCatogoryController controller = Get.put(CreateEventCatogoryController());
  GlobalKey<FormState> _createEventCatogoryformKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: SizedBox(
          width: double.maxFinite,
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
          return      EventCatogoryCard(
                text: category.categoryName,
                imageUrl: category.imageIcon,
                // subtitle: category.categoryName,
                onPressed: () {
                  print("category.categoryName: ${category.categoryName}");


                  // Get.toNamed(category.redirectString);
                  // controller.update();
                },
              );
        }, gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(

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



  onTapImgIconsone(){

  }
}

class EventCatogoryCard extends StatelessWidget {
  final String text;
  final String imageUrl;
  final String subtitle;
  final Function() onPressed;

  const EventCatogoryCard({required this.text, required this.imageUrl, this.subtitle ="", required this.onPressed, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap: onPressed,
      child: Container(
        // width: 150,
        // height: 150,
        padding: const EdgeInsets.all(15.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.5),
          boxShadow: [
            BoxShadow(
                offset: const Offset(10, 20),
                blurRadius: 10,
                spreadRadius: 0,
                color: Colors.grey.withAlpha(50)),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,

          children: [
           CustomImageView(
             imagePath: imageUrl,
             height: 50,
             width: 50,
           ),
           SizedBox(height: 20,),
            AutoSizeText(text,
                minFontSize: 18,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 22
                )),

            Text(
              subtitle ,
              textAlign: TextAlign.center,
              style: const TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.normal,
                  fontSize: 12),
            ),

          ],
        ),
      ),
    );
  }
}
