import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:volco/core/app_export.dart';
import 'package:volco/presentation/create_event_screen/controller/create_event_controller.dart';
import 'package:volco/widgets/CustomDropdownField.dart';
import 'package:volco/widgets/customMultiSelectDropdown.dart';
import 'package:volco/widgets/custom_text_form_field.dart';

class EducationFields extends StatelessWidget {
  // You can pass controllers or callbacks if needed.
  final CreateEventController controller = Get.find<CreateEventController>();
  final SupabaseService supabaseService = SupabaseService();
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 24.h,
      children: [
        // Age Group Dropdown
        Obx(() => CustomSelectDropdown(
              hintText: "Age Group*".tr,
              options: controller.ageGroups.toList(),
              // initialValue: "Children",
              onChanged: (value) {
                // Save the selected value in your controller.
                controller.selectedAgeGroup.value = value!;
              },
            )),
        // Subject Focus Dropdown
        Obx(
          () => CustomSelectDropdown(
            hintText: "Subject Focus*".tr,
            options: controller.subjectFocus.toList(),
            onChanged: (value) {
              // Save the selected value in your controller.
              controller.selectedSubjectFocus.value = value!;
            },
          ),
        ),
        // Language Requirements
        CustomTextFormField(
          controller: controller.languageRequirementsController,
          hintText: "Language Requirements".tr,
          textInputType: TextInputType.text,
          // Pass controller if needed.
        ),
        // Materials Needed
        CustomTextFormField(
          controller: controller.materialsNeededController,
          hintText: "Materials Needed".tr,
          textInputType: TextInputType.text,
          // Pass controller if needed.
        ),
      ],
    );
  }
}

class HealthWellnessFields extends StatelessWidget {
  final CreateEventController controller = Get.find<CreateEventController>();
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 24.h,
      children: [
        // Type of Service Checkboxes
        Obx(
          () => CustomMultiSelectDropdown(
            hintText: "Type of Service".tr,
            items: controller.typeOfServices.toList(),
            onSelectionChanged: (selectedValues) {
              // Handle selected values
              controller.selectedServices = RxList(selectedValues);
            },
          ),
        ),
        // Medical Professional Required Dropdown
        Obx(
          () => CustomSelectDropdown(
            hintText: "Medical Professional Required*".tr,
            options: controller.medicalProfessionalList.toList(),
            onChanged: (value) {
              // Save the selected value
              controller.selectedMedicalProfessional.value = value!;
            },
          ),
        ),
        // Equipment Needed
        CustomTextFormField(
          hintText: "Equipment Needed".tr,
          textInputType: TextInputType.text,
          controller: controller.equipmentNeeded,
        ),
        // Medication Handling Guidelines
        CustomTextFormField(
          controller: controller.medicationGuidelines,
          hintText: "Medication Handling Guidelines".tr,
          textInputType: TextInputType.multiline,
          maxLines: 20,
        ),
      ],
    );
  }
}

class CounselingFields extends StatelessWidget {
  final CreateEventController controller = Get.find<CreateEventController>();
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 24.h,
      children: [
        // Counseling Type Dropdown
        Obx(
          () => CustomSelectDropdown(
            hintText: "Counseling Type*".tr,
            options: controller.counselingTypes.toList(),
            onChanged: (value) {
              // Save the selected value
              controller.selectedCounselingType.value = value!;
            },
          ),
        ),
        // Session Format Dropdown
        Obx(
          () => CustomSelectDropdown(
            hintText: "Session Format*".tr,
            options: controller.sessionFormats.toList(),
            onChanged: (value) {
              // Save the selected value
              controller.selectedSessionFormat.value = value!;
            },
          ),
        )
      ],
    );
  }
}

class ConservationFields extends StatelessWidget {
  final CreateEventController controller = Get.find<CreateEventController>();
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 24.h,
      children: [
        // Activity Type Dropdown
        Obx(
          () => CustomSelectDropdown(
            hintText: "Activity Type*".tr,
            options: controller.conservationActivityTypes.toList(),
            onChanged: (value) {
              // Save the selected value
              controller.selectedActivityType.value = value!;
            },
          ),
        ),
        // Tools Provided/Needed
        CustomTextFormField(
          hintText: "Tools Provided/Needed".tr,
          textInputType: TextInputType.text,
          controller: controller.toolsProvided,
        ),
        // Environmental Impact Description
        CustomTextFormField(
          hintText: "Environmental Impact Description".tr,
          textInputType: TextInputType.multiline,
          maxLines: 20,
          controller: controller.environmentalImpact,
        ),
        // Waste Disposal Plan
        CustomTextFormField(
          hintText: "Waste Disposal Plan".tr,
          textInputType: TextInputType.multiline,
          controller: controller.wasteDisposalPlan,
        ),
      ],
    );
  }
}

class WorkWithEldersFields extends StatelessWidget {
  final CreateEventController controller = Get.find<CreateEventController>();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 24.h,
      children: [
        // Activity Type Dropdown
        Obx(
          () => CustomSelectDropdown(
            hintText: "Activity Type*".tr,
            options: controller.elderActivityTypes.toList(),
            onChanged: (value) {
              // Save the selected value
              controller.selectedElderActivityType.value = value!;
            },
          ),
        ),
        // Items to Bring
        CustomTextFormField(
          hintText: "Items to Bring".tr,
          textInputType: TextInputType.text,
          controller: controller.itemsToBring,
        ),
      ],
    );
  }
}

class WorkWithOrphansFields extends StatelessWidget {
  final CreateEventController controller = Get.find<CreateEventController>();
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 24.h,
      children: [
        // Child Age Range Text Field
        CustomTextFormField(
          hintText: "Child Age Range*".tr,
          textInputType: TextInputType.text,
          controller: controller.childAgeRange,
        ),
        // Activity Type Dropdown
        Obx(
          () => CustomSelectDropdown(
            hintText: "Activity Type*".tr,
            options: controller.orphanActivityTypes.toList(),
            onChanged: (value) {
              // Save the selected value
              controller.selectedOrphanActivityType.value = value!;
            },
          ),
        ),
        // Donation Needs
        CustomTextFormField(
          hintText: "Donation Needs".tr,
          textInputType: TextInputType.text,
          controller: controller.donationNeeds,
        ),
      ],
    );
  }
}

class AnimalRescueFields extends StatelessWidget {
  final CreateEventController controller = Get.find<CreateEventController>();
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 24.h,
      children: [
        // Animal Type Dropdown
        Obx(
          () => CustomSelectDropdown(
            hintText: "Animal Type*".tr,
            options: controller.animalTypes.toList(),
            onChanged: (value) {
              // Save the selected value
              controller.selectedAnimalType.value = value!;
            },
          ),
        ),
        // Tasks Involved Dropdown
        Obx(
          () => CustomSelectDropdown(
            hintText: "Tasks Involved*".tr,
            options: controller.taskInvolved.toList(),
            onChanged: (value) {
              // Save the selected value
              controller.selectedTaskInvolved.value = value!;
            },
          ),
        ),
        // Vaccination Status Disclosure
        CustomTextFormField(
          hintText: "Vaccination Status Disclosure".tr,
          textInputType: TextInputType.multiline,
          controller: controller.vaccinationStatus,
        ),
        // Handling Equipment
        CustomTextFormField(
          hintText: "Handling Equipment".tr,
          textInputType: TextInputType.text,
          controller: controller.handlingEquipment,
        ),
      ],
    );
  }
}

class CleanFields extends StatelessWidget {
  final CreateEventController controller = Get.find<CreateEventController>();
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 24.h,
      children: [
        // Area Type Dropdown
        Obx(
          () => CustomSelectDropdown(
            hintText: "Area Type*".tr,
            options: controller.areaTypes.toList(),
            onChanged: (value) {
              // Save the selected value
              controller.selectedAreaType.value = value!;
            },
          ),
        ),
        // Waste Category Dropdown
        Obx(
          () => CustomSelectDropdown(
            hintText: "Waste Category*".tr,
            options: controller.wasteCategories.toList(),
            onChanged: (value) {
              // Save the selected value
              controller.selectedWasteCategory.value = value!;
            },
          ),
        ),
        // Recycling Plan Description
        CustomTextFormField(
          hintText: "Recycling Plan Description".tr,
          textInputType: TextInputType.multiline,
          controller: controller.recyclingPlan,
        ),
      ],
    );
  }
}
