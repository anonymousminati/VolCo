import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:volco/core/app_export.dart';
import 'package:volco/core/utils/image_constant.dart';
import 'package:volco/core/utils/supabase_handler.dart';
import 'package:volco/core/utils/validation_functions.dart';
import 'package:volco/presentation/create_event_catogory_screen/controller/create_event_catogory_controller.dart';
import 'package:volco/presentation/create_event_screen/controller/create_event_controller.dart';
import 'package:volco/presentation/user_details_screen/controller/user_details_controller.dart';
import 'package:volco/widgets/customMultiSelectDropdown.dart';
import 'package:volco/widgets/custom_image_picker.dart';

class CreateEventScreen extends StatelessWidget {
  final CreateEventController controller = Get.put(CreateEventController());
  GlobalKey<FormState> _createEventformKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Form(
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
                    SizedBox(height: 70.h),
                    Text(
                      "Serve for Good".tr,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.displayMedium!.copyWith(
                        height: 1.50,
                      ),
                    ),
                    SizedBox(height: 24.h),
                    // Profile Image Picker
                    // Center(
                    //   child: Obx(() {
                    //     return GestureDetector(
                    //       onTap: () => controller.pickImage(),
                    //       child: CircleAvatar(
                    //         radius: 50,
                    //         backgroundImage: controller.pickedImage.value != null
                    //             ? FileImage(File(controller.pickedImage.value!.path))
                    //             : null,
                    //         child: controller.pickedImage.value == null
                    //             ? const Icon(Icons.camera_alt, size: 50)
                    //             : null,
                    //       ),
                    //     );
                    //   }),
                    // ),
                    // SizedBox(height: 24.h),
                    _buildCreateEventFormSection(context),
                    // Save Button
                    SizedBox(height: 24.h),
                    CustomElevatedButton(
                      text: "Submit".tr,
                      onPressed: () async {
                        if (_createEventformKey.currentState!.validate()){

                        }
                      },
                    ),

                    // CustomElevatedButton(
                    //   text: "Submit 2".tr,
                    //   onPressed: () async {
                    //     try{
                    //       final User? user = await SupabaseService().getUserData();
                    //       String userId = user?.id ?? '';
                    //
                    //       final testResponse = await Supabase.instance.client
                    //           .from('profiles')
                    //           .select()
                    //           .eq('id', userId.toString());
                    //
                    //       print("Test Query Response: ${testResponse}");
                    //     }catch (e){
                    //       print("Error in Test Query: $e");
                    //     }
                    //
                    //   },
                    // ),

                  ],
                ),
              ),
            ),
          ),
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
          child: Obx(
            () => CustomTextFormField(
                 
              controller: TextEditingController(
                text: controller.selectedDate.value != null
                    ? "${controller.selectedDate.value!.day}-${controller.selectedDate.value!.month}-${controller.selectedDate.value!.year}"
                    : "",
              ),
              readOnly: true,
              hintText:"Select Event Date" ,
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
              hintText:"Select Event Time" ,
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




  Widget _buildCreateEventFormSection( BuildContext context) {
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
                imagePath: ImageConstant.imgNoteWhite, // Use an appropriate icon
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

          CustomImagePickerWidget(),

          _buildDateTimePickers(context),

          // Duration
          CustomTextFormField(
            controller: controller.durationlController,
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
              if (toInt(value)! % 1 != 0)
                return 'Enter a only hours number'.tr;
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
            },
          ),

          CustomTextFormField(
            controller: controller.durationlController,
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
             if(num.tryParse(value) != null){
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
            controller: controller.locationController,
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

          //skills
          CustomTextFormField(
            controller: controller.skillsController,
            hintText: "Skills".tr,
            textInputType: TextInputType.text,
            textInputAction: TextInputAction.done,
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
                return 'Address is required'.tr;
              }
              return null;
            },
          ),
          //Age
          CustomTextFormField(
            controller: controller.ageController,
            hintText: "Age".tr,
            textInputType: TextInputType.number,
            textInputAction: TextInputAction.done,
            prefix: Container(
              margin: EdgeInsets.fromLTRB(20.h, 18.h, 12.h, 18.h),
              child: CustomImageView(
                imagePath: ImageConstant.imgProfileWhite,
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
                return 'age is required'.tr;
              }
              return null;
            },
          ),
        ],
      ),
    );
  }

}
