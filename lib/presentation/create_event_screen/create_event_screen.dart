import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
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
import 'package:volco/presentation/home_screen/home_screen.dart';
import 'package:volco/presentation/user_details_screen/controller/user_details_controller.dart';
import 'package:volco/widgets/customMultiSelectDropdown.dart';
import 'package:volco/widgets/custom_google_map_location_picker.dart';
import 'package:volco/widgets/custom_image_picker.dart';

class CreateEventScreen extends GetView<CreateEventController> {
  /// The selected activity category passed from the previous screen.

  final String categoryType;

  CreateEventScreen({Key? key, required this.categoryType}) : super(key: key) {
    print("Received categoryType1: $categoryType");
    controller.updateSelectedCategory(categoryType);
  }
  GlobalKey<FormState> _createEventformKey = GlobalKey<FormState>(debugLabel: '_createEventformKey');


  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: RefreshIndicator(
        onRefresh: ()=>controller.loadActivitySpecificFields(controller.selectedCategory.value),
        child: Scaffold(
          resizeToAvoidBottomInset: true,
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
                              if (_createEventformKey.currentState!.validate()) {
                                print("step1");
                                // Call createNewEvent() from the controller
                                bool success = await controller.createNewEvent();
                                print("step2");
        
                                if (success) {
                                  print("step3");
                                  // Navigate to home screen if event creation is successful.
                                  Get.offAllNamed(AppRoutes.eventDescriptionScreen,arguments: {
                                    "eventCreatedId":controller.eventId,
                                    "eventCategory":controller.selectedCategory.value,
                                  });
                                } else {
                                  print("step4");
        
                                  Get.snackbar("Error", "Event creation failed. Please try again.");
                                }
                              }else{
                                print("step5");
        
                                Get.snackbar("Error", "Please fill all the fields");
                              }
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
          child:  CustomTextFormField(
            controller: controller.dateController,
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

        // Time Picker
        Expanded(
          child:CustomTextFormField(
            controller:controller.timeController,
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
            onTap: () async {
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
                                controller.locationController.text = placeName;
                                controller.selectedCoordinates = coordinates;
                                print("location cords: ${controller.selectedCoordinates}");
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
              if (!isAddress(value, isRequired: true)) {
                return 'Location should contain only alphabets'.tr;
              }
              return null;
            },
          ),

         Obx(()=> CustomMultiSelectDropdown(
           hintText: "Select Tags".tr,
           items:controller.TagsValueList.toList(),
           onSelectionChanged: (List<String> selectedItems) {
             print("Selected: $selectedItems");
             controller.selectedTags.value = selectedItems;
           },
         )),

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

          // Emergency Contact Number
          CustomTextFormField(
            controller: controller.emergencyContactController,
            hintText: "Emergency Contact Number".tr,
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
                return 'Emergency Contact Number is required'.tr;
              }
              if (!isValidPhone(value, isRequired: true)) {
                return 'Enter a valid phone number'.tr;
              }
              return null;
            },
          ),

          Obx(() {
            switch (controller.selectedCategory.value) {
              case 'Education':
                return EducationFields();
              case 'Health & Wellness':
                return HealthWellnessFields();
              case 'Counseling':
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
