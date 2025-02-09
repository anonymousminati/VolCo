import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:volco/core/app_export.dart';
import 'package:volco/widgets/CustomDropdownField.dart';
import 'package:volco/widgets/custom_text_form_field.dart';

class EducationFields extends StatelessWidget {
  // You can pass controllers or callbacks if needed.
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Age Group Dropdown
        CustomDropdownField(
          label: "Age Group*".tr,
          options: ["Children", "Teens", "Adults", "Seniors"],
          onChanged: (value) {
            // Save the selected value in your controller.
          },
        ),
        SizedBox(height: 16.h),
        // Subject Focus Dropdown
        CustomDropdownField(
          label: "Subject Focus*".tr,
          options: ["STEM", "Literacy", "Vocational", "Financial Literacy"],
          onChanged: (value) {
            // Save the selected value in your controller.
          },
        ),
        SizedBox(height: 16.h),
        // Language Requirements
        CustomTextFormField(
          hintText: "Language Requirements".tr,
          textInputType: TextInputType.text,
          // Pass controller if needed.
        ),
        SizedBox(height: 16.h),
        // Materials Needed
        CustomTextFormField(
          hintText: "Materials Needed".tr,
          textInputType: TextInputType.text,
          // Pass controller if needed.
        ),
      ],
    );
  }
}
