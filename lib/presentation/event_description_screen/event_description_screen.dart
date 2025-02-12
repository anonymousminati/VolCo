import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:volco/core/app_export.dart';
import 'package:volco/core/utils/image_constant.dart';
import 'package:volco/core/utils/supabase_handler.dart';
import 'package:volco/core/utils/validation_functions.dart';
import 'package:volco/presentation/create_event_catogory_screen/controller/create_event_catogory_controller.dart';
import 'package:volco/presentation/create_event_screen/controller/create_event_controller.dart';
import 'package:volco/presentation/create_event_screen/widgets/eventFields.dart';
import 'package:volco/presentation/event_description_screen/controller/event_description_controller.dart';
import 'package:volco/presentation/home_screen/home_screen.dart';
import 'package:volco/presentation/user_details_screen/controller/user_details_controller.dart';
import 'package:volco/widgets/customMultiSelectDropdown.dart';
import 'package:volco/widgets/custom_image_picker.dart';

class EventDescriptionScreen extends GetView<EventDescriptionController> {
  /// The selected activity category passed from the previous screen.


  /// The selected activity category passed from the previous screen.
  final String? selectedActivityCategory;
  final int? eventCreatedId;

  EventDescriptionScreen({Key? key, required this.selectedActivityCategory,required this.eventCreatedId}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body:   SizedBox(
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

                  CustomImageView(
                    imagePath: ImageConstant.imgArrowLeft,
                    height: 28.h,
                    width: 30.h,
                    onTap: () {
                      Get.back();
                    },
                  ),
                  SizedBox(height: 24.h),
                  Text(
                    "Create New Revolution".tr,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.displayMedium!.copyWith(
                      height: 1.50,
                    ),
                  ),
                  SizedBox(height: 24.h),

                  Text(
                    "Event id: $eventCreatedId".tr,

                  ),
                  // Save Button
                  SizedBox(height: 24.h),
                  Text(
                    "Selected event Catogory: $eventCreatedId".tr,

                  ),
                  // Save Button
                  SizedBox(height: 24.h),
                  CustomElevatedButton(
                    text: "Submit".tr,
                    onPressed: () async {
                      Get.offAllNamed(AppRoutes.homeScreen);
                    },
                  ),


                ],
              ),
            ),
          ),
        ),

      ),
    );
  }




}
