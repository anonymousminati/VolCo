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
import 'package:volco/presentation/user_details_screen/controller/user_details_controller.dart';
import 'package:volco/widgets/customMultiSelectDropdown.dart';
import 'package:volco/widgets/custom_image_picker.dart';

class CreateEventScreen extends GetView<CreateEventController> {
  /// The selected activity category passed from the previous screen.

  final String categoryType;

  CreateEventScreen({Key? key, required this.categoryType}) : super(key: key) {
    print("Received categoryType1: $categoryType");
    controller.updateSelectedCategory(categoryType);
  }
  GlobalKey<FormState> _createEventformKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body:Obx((){
          if (controller.isLoading.value) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }else{
            return Form(
              key: _createEventformKey,
              child: SizedBox(
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

                        _buildCreateEventFormSection(context),
                        // Save Button
                        SizedBox(height: 24.h),
                        CustomElevatedButton(
                          text: "Submit".tr,
                          onPressed: () async {
                            if (_createEventformKey.currentState!.validate()) {}
                          },
                        ),


                      ],
                    ),
                  ),
                ),
              ),
            );
          }
        })

      ),
    );
  }

  Widget _buildDateTimePickers(BuildContext context) {
    return Row(
      // crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 24.h,
      children: [
        // Date Picker Field
        Expanded(
          child: Obx(
            () => CustomTextFormField(
              controller: TextEditingController(
                text: controller.selectedDate.value != null
                    ? "${controller.selectedDate.value!.day}-${controller.selectedDate.value!.month}-${controller.selectedDate.value!.year}"
                    : "",
              ),
              readOnly: true,
              hintText: "Select Event Date",
              prefix: Container(
                margin: EdgeInsets.fromLTRB(20.h, 18.h, 12.h, 18.h),
                child: CustomImageView(
                  imagePath: ImageConstant.imgCalender,
                  height: 18.h,
                  width: 20.h,
                  fit: BoxFit.contain,
                ),
              ),
              onTap: () => controller.showDatePicker(context),
            ),
          ),
        ),

        // Time Picker
        Expanded(
          child: Obx(
            () => CustomTextFormField(
              controller: TextEditingController(
                text: controller.selectedTime != null
                    ? controller.selectedTime!.value?.format(context)
                    : "",
              ),
              readOnly: true,
              hintText: "Select Event Time",
              prefix: Container(
                margin: EdgeInsets.fromLTRB(20.h, 18.h, 12.h, 18.h),
                child: CustomImageView(
                  imagePath: ImageConstant.imgClock,
                  height: 18.h,
                  width: 20.h,
                  fit: BoxFit.contain,
                ),
              ),
              onTap: () => controller.showTimePickerDialog(context),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCreateEventFormSection(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      child: Column(
        spacing: 24.h,
        children: [
          // Event Name
          CustomTextFormField(
            controller: controller.eventNameController,
            hintText: "Event Name".tr,
            textInputType: TextInputType.text,
            textInputAction: TextInputAction.next,
            prefix: Container(
              margin: EdgeInsets.fromLTRB(20.h, 18.h, 12.h, 18.h),
              child: CustomImageView(
                imagePath: ImageConstant.imgTextSvg,
                height: 18.h,
                width: 20.h,
                fit: BoxFit.contain,
              ),
            ),
            prefixConstraints: BoxConstraints(
              maxHeight: 60.h,
            ),
            contentPadding: EdgeInsets.symmetric(
              horizontal: 20.h,
              vertical: 18.h,
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Event Name is required'.tr;
              }
              if (!isText(value, isRequired: true)) {
                return 'Event Name should contain only alphabets'.tr;
              }
              return null;
            },
          ),

          // Event Description
          CustomTextFormField(
            controller: controller.eventDescriptionController,
            hintText: "Event Description".tr,
            textInputType: TextInputType.multiline,
            // textInputAction: TextInputAction.newline,
            maxLines: 20, // Allows dynamic height adjustment
            minLines: 1,
            prefix: Container(
              margin: EdgeInsets.fromLTRB(20.h, 18.h, 12.h, 18.h),
              child: CustomImageView(
                imagePath:
                    ImageConstant.imgNoteWhite, // Use an appropriate icon
                height: 18.h,
                width: 20.h,
                fit: BoxFit.contain,
              ),
            ),
            prefixConstraints: BoxConstraints(
              maxHeight: 60.h,
            ),
            contentPadding: EdgeInsets.symmetric(
              horizontal: 20.h,
              vertical: 18.h,
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Event Description is required'.tr;
              }
              return null;
            },
          ),

          CustomImagePickerWidget(
            onImagePicked: (String imagePath) {
              controller.pickedImage.value = XFile(imagePath); // Use fromPath()
              print("Picked Image Path: ${controller.pickedImage.value?.path}");
            },
          ),

          _buildDateTimePickers(context),

          // Duration
          CustomTextFormField(
            controller: controller.durationController,
            hintText: "Duration (Hours)".tr,
            textInputType: TextInputType.number,
            textInputAction: TextInputAction.next,
            prefix: Container(
              margin: EdgeInsets.fromLTRB(20.h, 18.h, 12.h, 18.h),
              child: CustomImageView(
                imagePath: ImageConstant.imgClock,
                height: 18.h,
                width: 20.h,
                fit: BoxFit.contain,
              ),
            ),
            prefixConstraints: BoxConstraints(
              maxHeight: 60.h,
            ),
            contentPadding: EdgeInsets.symmetric(
              horizontal: 20.h,
              vertical: 18.h,
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Duration is required'.tr;
              }
              //check if the entered value is a double or not
              if (toInt(value)! % 1 != 0) return 'Enter a only hours number'.tr;
              return null;
            },
          ),

          //Location
          CustomTextFormField(
            controller: controller.locationController,
            hintText: "Location".tr,
            textInputType: TextInputType.text,
            textInputAction: TextInputAction.done,
            prefix: Container(
              margin: EdgeInsets.fromLTRB(20.h, 18.h, 12.h, 18.h),
              child: CustomImageView(
                imagePath: ImageConstant.imgLocation,
                height: 18.h,
                width: 20.h,
                fit: BoxFit.contain,
              ),
            ),
            prefixConstraints: BoxConstraints(
              maxHeight: 60.h,
            ),
            contentPadding: EdgeInsets.symmetric(
              horizontal: 20.h,
              vertical: 18.h,
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Location is required'.tr;
              }
              if (!isText(value, isRequired: true)) {
                return 'Location should contain only alphabets'.tr;
              }
              return null;
            },
          ),

          CustomMultiSelectDropdown(
            hintText: "Select Tags".tr,
            items: [
              "Childcare",
              "Mentorship",
              "Adoption Awareness",
              "Trauma Support",
              "Festival Events",
              "Play Therapy",
              "Skill Development",
              "Education Support",
              "Nutrition Program",
              "Art Therapy",
              "Sports Coaching",
              "Holiday Celebrations",
              "School Supplies Drive",
              "Orphanage Visits",
              "Child Safety"
            ],
            onSelectionChanged: (List<String> selectedItems) {
              print("Selected: $selectedItems");
              controller.selectedTags.value = selectedItems;
            },
          ),

          CustomTextFormField(
            controller: controller.volunteerController,
            hintText: "No of Volunteers required".tr,
            textInputType: TextInputType.number,
            textInputAction: TextInputAction.next,
            prefix: Container(
              margin: EdgeInsets.fromLTRB(20.h, 18.h, 12.h, 18.h),
              child: CustomImageView(
                imagePath: ImageConstant.imgNumberSvg,
                height: 22.h,
                width: 24.h,
                fit: BoxFit.contain,
              ),
            ),
            prefixConstraints: BoxConstraints(
              maxHeight: 60.h,
            ),
            contentPadding: EdgeInsets.symmetric(
              horizontal: 20.h,
              vertical: 18.h,
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'field is required'.tr;
              }
              if (num.tryParse(value) != null) {
                return 'Enter a only number'.tr;
              }
              return null;
            },
          ),

          // Contact Number
          CustomTextFormField(
            controller: controller.mobileNumberController,
            hintText: "Contact Number".tr,
            textInputType: TextInputType.phone,
            textInputAction: TextInputAction.next,
            prefix: Container(
              margin: EdgeInsets.fromLTRB(20.h, 18.h, 12.h, 18.h),
              child: CustomImageView(
                imagePath: ImageConstant.imgNoteSkyBlue,
                height: 18.h,
                width: 20.h,
                fit: BoxFit.contain,
              ),
            ),
            prefixConstraints: BoxConstraints(
              maxHeight: 60.h,
            ),
            contentPadding: EdgeInsets.symmetric(
              horizontal: 20.h,
              vertical: 18.h,
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Contact Number is required'.tr;
              }
              if (!isValidPhone(value, isRequired: true)) {
                return 'Enter a valid phone number'.tr;
              }
              return null;
            },
          ),

          // Social Media
          CustomTextFormField(
            controller: controller.socialMediaController,
            hintText: "Social Media Links".tr,
            textInputType: TextInputType.text,
            textInputAction: TextInputAction.done,
            prefix: Container(
              margin: EdgeInsets.fromLTRB(20.h, 18.h, 12.h, 18.h),
              child: CustomImageView(
                imagePath: ImageConstant.imgUrl,
                height: 18.h,
                width: 20.h,
                fit: BoxFit.contain,
              ),
            ),
            prefixConstraints: BoxConstraints(
              maxHeight: 60.h,
            ),
            contentPadding: EdgeInsets.symmetric(
              horizontal: 20.h,
              vertical: 18.h,
            ),
            validator: (value) {
              return null;
            },
          ),


          Obx(() {
            switch (controller.selectedCategory.value) {
              case 'Education':
                return EducationFields();
              case 'Health & Wellness':
                return HealthWellnessFields();
              case 'Counselling':
                return CounselingFields();
              case 'Conservation':
                return ConservationFields();
              case 'Work With Elders':
                return WorkWithEldersFields();
              case 'Work With Orphans':
                return WorkWithOrphansFields();
              case 'Animal Rescue':
                return AnimalRescueFields();
              case 'Cleaning':
                return CleanFields();
              default:
                return SizedBox
                    .shrink(); // If no activity selected, show nothing extra.
            }
          }),
        ],
      ),
    );
  }
}
