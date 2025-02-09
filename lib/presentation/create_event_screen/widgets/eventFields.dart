import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:volco/core/app_export.dart';
import 'package:volco/widgets/CustomDropdownField.dart';
import 'package:volco/widgets/customMultiSelectDropdown.dart';
import 'package:volco/widgets/custom_text_form_field.dart';

class EducationFields extends StatelessWidget {
  // You can pass controllers or callbacks if needed.
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Age Group Dropdown
        CustomSelectDropdown(
          hintText: "Age Group*".tr,
          options: ["Children", "Teens", "Adults", "Seniors"],
          // initialValue: "Children",
          onChanged: (value) {
            // Save the selected value in your controller.
          },
        ),
        SizedBox(height: 16.h),
        // Subject Focus Dropdown
        CustomSelectDropdown(
          hintText: "Subject Focus*".tr,
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

class HealthWellnessFields extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Type of Service Checkboxes
        CustomMultiSelectDropdown(
          hintText: "Type of Service*".tr,
          items: ["Medical Checkups", "Vaccination Drive", "Health Education"],
          onSelectionChanged: (selectedValues) {
            // Handle selected values
          },
        ),
        SizedBox(height: 16.h),
        // Medical Professional Required Dropdown
        CustomSelectDropdown(
          hintText: "Medical Professional Required*".tr,
          options: ["Doctors", "Nurses", "Paramedics"],
          onChanged: (value) {
            // Save the selected value
          },
        ),
        SizedBox(height: 16.h),
        // Equipment Needed
        CustomTextFormField(
          hintText: "Equipment Needed".tr,
          textInputType: TextInputType.text,
        ),
        SizedBox(height: 16.h),
        // Medication Handling Guidelines
        CustomTextFormField(
          hintText: "Medication Handling Guidelines".tr,
          textInputType: TextInputType.multiline,
        ),
      ],
    );
  }
}


class CounselingFields extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Counseling Type Dropdown
        CustomSelectDropdown(
          hintText: "Counseling Type*".tr,
          options: ["Mental Health", "Career", "Family", "Addiction"],
          onChanged: (value) {},
        ),
        SizedBox(height: 16.h),
        // Session Format Dropdown
        CustomSelectDropdown(
          hintText: "Session Format*".tr,
          options: ["Individual", "Group"],
          onChanged: (value) {},
        ),
      ],
    );
  }
}

class ConservationFields extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Activity Type Dropdown
        CustomSelectDropdown(
          hintText: "Activity Type*".tr,
          options: ["Beach Cleanup", "Tree Planting", "Wildlife Monitoring"],
          onChanged: (value) {},
        ),
        SizedBox(height: 16.h),
        // Tools Provided/Needed
        CustomTextFormField(
          hintText: "Tools Provided/Needed".tr,
          textInputType: TextInputType.text,
        ),
        SizedBox(height: 16.h),
        // Environmental Impact Description
        CustomTextFormField(
          hintText: "Environmental Impact Description".tr,
          textInputType: TextInputType.multiline,
        ),
        SizedBox(height: 16.h),
        // Waste Disposal Plan
        CustomTextFormField(
          hintText: "Waste Disposal Plan".tr,
          textInputType: TextInputType.multiline,
        ),
      ],
    );
  }
}

class WorkWithEldersFields extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Activity Type Dropdown
        CustomSelectDropdown(
          hintText: "Activity Type*".tr,
          options: ["Companionship", "Medical Support", "Recreation"],
          onChanged: (value) {},
        ),
        SizedBox(height: 16.h),
        // Items to Bring
        CustomTextFormField(
          hintText: "Items to Bring".tr,
          textInputType: TextInputType.text,
        ),
      ],
    );
  }
}

class WorkWithOrphansFields extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Child Age Range Text Field
        CustomTextFormField(
          hintText: "Child Age Range*".tr,
          textInputType: TextInputType.text,
        ),
        SizedBox(height: 16.h),
        // Activity Type Dropdown
        CustomSelectDropdown(
          hintText: "Activity Type*".tr,
          options: ["Education", "Play Therapy", "Skill Development"],
          onChanged: (value) {},
        ),
        SizedBox(height: 16.h),
        // Donation Needs
        CustomTextFormField(
          hintText: "Donation Needs".tr,
          textInputType: TextInputType.text,
        ),
      ],
    );
  }
}

class AnimalRescueFields extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Animal Type Dropdown
        CustomSelectDropdown(
          hintText: "Animal Type*".tr,
          options: ["Dogs", "Cats", "Wildlife", "Livestock"],
          onChanged: (value) {},
        ),
        SizedBox(height: 16.h),
        // Tasks Involved Dropdown
        CustomSelectDropdown(
          hintText: "Tasks Involved*".tr,
          options: ["Rescue", "Feeding", "Medical Care", "Adoption"],
          onChanged: (value) {},
        ),
        SizedBox(height: 16.h),
        // Vaccination Status Disclosure
        CustomTextFormField(
          hintText: "Vaccination Status Disclosure".tr,
          textInputType: TextInputType.multiline,
        ),
        SizedBox(height: 16.h),
        // Handling Equipment
        CustomTextFormField(
          hintText: "Handling Equipment".tr,
          textInputType: TextInputType.text,
        ),
      ],
    );
  }
}

class CleanFields extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Area Type Dropdown
        CustomSelectDropdown(
          hintText: "Area Type*".tr,
          options: ["Public Space", "Residential", "Water Body"],
          onChanged: (value) {},
        ),
        SizedBox(height: 16.h),
        // Waste Category Dropdown
        CustomSelectDropdown(
          hintText: "Waste Category*".tr,
          options: ["Plastic", "Organic", "Construction Debris"],
          onChanged: (value) {},
        ),
        SizedBox(height: 16.h),
        // Recycling Plan Description
        CustomTextFormField(
          hintText: "Recycling Plan Description".tr,
          textInputType: TextInputType.multiline,
        ),
      ],
    );
  }
}
