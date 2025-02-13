import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:volco/core/app_export.dart';
import 'package:volco/core/utils/image_constant.dart';
import 'package:volco/presentation/event_description_screen/controller/event_description_controller.dart';
import 'package:volco/presentation/event_description_screen/widgets/eventDescriptionField.dart';
import 'package:volco/widgets/custom_image_view.dart';

class EventDescriptionScreen extends GetView<EventDescriptionController> {
  final String? selectedActivityCategory;
  final int? eventCreatedId;

  EventDescriptionScreen({
    Key? key,
    required this.selectedActivityCategory,
    required this.eventCreatedId,
  }) : super(key: key);

  /// This function builds extra fields based on the category.
  Widget _buildActivitySpecificDetails(String category, RxMap activity, RxMap event) {
    switch (category.toLowerCase()) {
      case "education":
        return Column(
          spacing: 20.h,

          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,

              spacing: 20.h,
              children: [
                Expanded(
                  child: InfoContainer(
                    title: "Volunteer Required",
                    value: event["required_volunteers"]?.toString() ?? "N/A",
                  ),
                ),
                Expanded(
                  child: InfoContainer(
                    title: "Subject Focused",
                    value: activity["subject_focus"] ?? "N/A",
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              spacing: 20.h,
              children: [
                Expanded(
                  child: InfoContainer(
                    title: "Age Group",
                    value: activity["age_group"] ?? "N/A",
                  ),
                ),
                Expanded(
                  child: InfoContainer(
                    title: "Language Requirement",
                    value: activity["language_requirements"] ?? "N/A",
                  ),
                ),
              ],
            ),
            InfoContainer(
              title: "Materials Needed",
              value: activity["materials_needed"] ?? "N/A",
            ),
          ],
        );

      case "health & wellness":
        return Column(
          spacing: 20.h,

          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              spacing: 20.h,
              children: [
                Expanded(
                  child: InfoContainer(
                    title: "Service Type",
                    value: (activity["type_of_service"] as List<dynamic>?)?.join(", ") ?? "N/A",
                  ),
                ),
                Expanded(
                  child: InfoContainer(
                    title: "Medical Professional",
                    value: (activity["medical_professional_required"] as List<dynamic>?)?.join(", ") ?? "N/A",
                  ),
                ),
              ],
            ),
            InfoContainer(
              title: "Equipment Needed",
              value: (activity["equipment_needed"] as List<dynamic>?)?.join(", ") ?? "N/A",
            ),
            InfoContainer(
              title: "Medication Handling",
              value: activity["medication_handling_guidelines"] ?? "N/A",
            ),
          ],
        );

      case "counseling":
        return Column(
          spacing: 20.h,

          children: [
            InfoContainer(
              title: "Counseling Type",
              value: activity["counseling_type"] ?? "N/A",
            ),
            InfoContainer(
              title: "Session Format",
              value: activity["session_format"] ?? "N/A",
            ),
          ],
        );

      case "conservation":
        return Column(
          spacing: 20.h,

          children: [
            InfoContainer(
              title: "Activity Type",
              value: activity["activity_type"] ?? "N/A",
            ),
            InfoContainer(
              title: "Tools Provided/Needed",
              value: (activity["tools_provided_needed"] as List<dynamic>?)?.join(", ") ?? "N/A",
            ),
            InfoContainer(
              title: "Environmental Impact",
              value: activity["environmental_impact"] ?? "N/A",
            ),
            InfoContainer(
              title: "Waste Disposal Plan",
              value: activity["waste_disposal_plan"] ?? "N/A",
            ),
          ],
        );

      case "work with elders":
        return Column(
          spacing: 20.h,

          children: [
            InfoContainer(
              title: "Activity Type",
              value: activity["activity_type"] ?? "N/A",
            ),
            InfoContainer(
              title: "Mobility Requirements",
              value: activity["mobility_requirements"] ?? "N/A",
            ),
            InfoContainer(
              title: "Items to Bring",
              value: (activity["items_to_bring"] as List<dynamic>?)?.join(", ") ?? "N/A",
            ),
          ],
        );

      case "work with orphans":
        return Column(
          spacing: 20.h,

          children: [
            InfoContainer(
              title: "Child Age Range",
              value: activity["child_age_range"] ?? "N/A",
            ),
            InfoContainer(
              title: "Activity Type",
              value: activity["activity_type"] ?? "N/A",
            ),
            InfoContainer(
              title: "Donation Needs",
              value: (activity["donation_needs"] as List<dynamic>?)?.join(", ") ?? "N/A",
            ),
          ],
        );

      case "animal rescue":
        return Column(
          spacing: 20.h,

          children: [
            InfoContainer(
              title: "Animal Type",
              value: activity["animal_type"] ?? "N/A",
            ),
            InfoContainer(
              title: "Tasks Involved",
              value: (activity["tasks_involved"] as List<dynamic>?)?.join(", ") ?? "N/A",
            ),
            InfoContainer(
              title: "Vaccination Status",
              value: activity["vaccination_status"] ?? "N/A",
            ),
            InfoContainer(
              title: "Handling Equipment",
              value: (activity["handling_equipment"] as List<dynamic>?)?.join(", ") ?? "N/A",
            ),
          ],
        );

      case "clean":
        return Column(
          spacing: 20.h,

          children: [
            InfoContainer(
              title: "Area Type",
              value: activity["area_type"] ?? "N/A",
            ),
            InfoContainer(
              title: "Waste Category",
              value: (activity["waste_category"] as List<dynamic>?)?.join(", ") ?? "N/A",
            ),
            InfoContainer(
              title: "Recycling Plan",
              value: activity["recycling_plan"] ?? "N/A",
            ),
          ],
        );

      default:
        return SizedBox.shrink();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Obx(() {
          if (controller.isLoading.value) {
            return Center(child: CircularProgressIndicator());
          }
          if (controller.eventDetails.isEmpty) {
            return Center(child: Text("No event details available"));
          }
          var event = controller.eventDetails;
          var activity = controller.activityDetails;

          return SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.h, vertical: 10.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 20.h,
                children: [
                  // Back Arrow
                  CustomImageView(
                    imagePath: ImageConstant.imgArrowLeft,
                    height: 28.h,
                    width: 30.h,
                    onTap: () => Get.back(),
                  ),
                   
                  // Event Image
                  Container(
                    padding: EdgeInsets.all(8.h),
                    decoration: BoxDecoration(
                      color: appTheme.gray800,
                      borderRadius: BorderRadius.circular(12.h),
                    ),
                    child: CustomImageView(
                      imagePath: event['image_url'] ?? ImageConstant.imgTextSvg,
                      height: 200.h,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      radius: BorderRadius.circular(4.h),
                    ),
                  ),
                   
                  // Event Name
                  AutoSizeText(
                    event['event_name'] ?? "Event Name",
                    style: CustomTextStyles.titleLarge20.copyWith(fontSize: 40.h),
                    maxLines: 2,
                    minFontSize: 20,
                    overflow: TextOverflow.ellipsis,
                  ),
                  // Event Category
                  AutoSizeText(
                    selectedActivityCategory ?? "Category",
                    style: CustomTextStyles.headlineLargePrimary.copyWith(
                      fontWeight: FontWeight.w500,
                      height: 0.2,
                      fontSize: 28.h,
                    ),
                  ),
                   
                  // Row with Time, Date, Duration
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    spacing: 20.h,
                    children: [
                      Expanded(
                        child: AspectRatio(
                          aspectRatio: 1,
                          child: Container(
                            padding: EdgeInsets.all(8.h),
                            decoration: BoxDecoration(
                              color: appTheme.blueGray900,
                              borderRadius: BorderRadius.circular(12.h),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                AutoSizeText(
                                  event['event_time'] ?? "N/A",
                                  style: theme.textTheme.bodyLarge!.copyWith(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 24.h,
                                  ),
                                ),
                                SizedBox(height: 4.h),
                                AutoSizeText(
                                  "Time",
                                  style: theme.textTheme.bodyMedium?.copyWith(fontSize: 18.h),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: AspectRatio(
                          aspectRatio: 1,
                          child: Container(
                            padding: EdgeInsets.all(8.h),
                            decoration: BoxDecoration(
                              color: appTheme.blueGray900,
                              borderRadius: BorderRadius.circular(12.h),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                AutoSizeText(
                                  event['event_date'] ?? "N/A",
                                  style: theme.textTheme.bodyLarge!.copyWith(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 24.h,
                                  ),
                                ),
                                SizedBox(height: 4.h),
                                AutoSizeText(
                                  "Date",
                                  style: theme.textTheme.bodyMedium?.copyWith(fontSize: 18.h),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: AspectRatio(
                          aspectRatio: 1,
                          child: Container(
                            padding: EdgeInsets.all(8.h),
                            decoration: BoxDecoration(
                              color: appTheme.blueGray900,
                              borderRadius: BorderRadius.circular(12.h),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                AutoSizeText(
                                  "${event['duration_hours']} hrs" ?? "N/A",
                                  style: theme.textTheme.bodyLarge!.copyWith(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 24.h,
                                  ),
                                ),
                                SizedBox(height: 4.h),
                                AutoSizeText(
                                  "Duration",
                                  style: theme.textTheme.bodyMedium?.copyWith(fontSize: 18.h),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                   
                  // Event Description
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(12.h),
                    decoration: BoxDecoration(
                      color: appTheme.blueGray900,
                      borderRadius: BorderRadius.circular(12.h),
                    ),
                    child: Text(
                      event['event_description'] ?? "No description available.",
                      style: theme.textTheme.bodyMedium?.copyWith(fontSize: 18.h),
                      textAlign: TextAlign.justify,
                    ),
                  ),
                   
                  // Event Location
                  GestureDetector(
                    onTap: () {
                      print("Open Map");
                    },
                    child: Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(12.h),
                      decoration: BoxDecoration(
                        color: appTheme.blueGray900,
                        borderRadius: BorderRadius.circular(12.h),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,

                            children: [
                              Text(
                                "Location",
                                style: theme.textTheme.bodyLarge!
                                    .copyWith(fontWeight: FontWeight.bold),
                              ),
                              Text(
                                "📌 Click to open Map",
                                style: theme.textTheme.bodyMedium,
                              ),
                            ],
                          ),
                          SizedBox(height: 8.h),
                          Text(
                            event['location'] ?? "N/A",
                            style: theme.textTheme.bodyLarge,
                          ),
                        ],
                      ),
                    ),
                  ),
                   
                  // Contact Number Tile
                  Container(
                    decoration: BoxDecoration(
                      color: appTheme.blueGray900,
                      borderRadius: BorderRadius.circular(12.h),
                    ),
                    child: ListTile(
                      contentPadding: EdgeInsets.symmetric(horizontal: 12.h),
                      leading: Icon(
                        Icons.phone_in_talk_outlined,
                        color: theme.colorScheme.primary,
                        size: 28.h,
                      ),
                      title: Text(
                        "Contact Number",
                        style: theme.textTheme.bodyLarge!
                            .copyWith(fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                      subtitle: Text(
                        event['contact_number'] ?? "N/A",
                        style: theme.textTheme.bodyMedium!.copyWith(color: Colors.white70),
                      ),
                    ),
                  ),
                   
                  // Social Media Link Tile
                  Container(
                    decoration: BoxDecoration(
                      color: appTheme.blueGray900,
                      borderRadius: BorderRadius.circular(12.h),
                    ),
                    child: ListTile(
                      contentPadding: EdgeInsets.symmetric(horizontal: 12.h),
                      leading: CustomImageView(
                        imagePath: ImageConstant.imgUrlSkyBlue,
                        width: 24.h,
                        height: 24.h,
                      ),
                      title: Text(
                        "Social Media Link",
                        style: theme.textTheme.bodyLarge!
                            .copyWith(fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                      subtitle: Text(
                        event['social_media_link'] ?? "N/A",
                        style: theme.textTheme.bodyMedium!.copyWith(color: Colors.white70),
                      ),
                    ),
                  ),
                   
                  // Emergency Contact Number Tile
                  Container(
                    decoration: BoxDecoration(
                      color: appTheme.blueGray900,
                      borderRadius: BorderRadius.circular(12.h),
                    ),
                    child: ListTile(
                      contentPadding: EdgeInsets.symmetric(horizontal: 12.h),
                      leading: CustomImageView(
                        imagePath: ImageConstant.imgUrlEmergencyContact,
                        width: 24.h,
                        height: 24.h,
                      ),
                      title: Text(
                        "Emergency Contact Number",
                        style: theme.textTheme.bodyLarge!
                            .copyWith(fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                      subtitle: Text(
                        event['emergency_contact_info'] ?? "N/A",
                        style: theme.textTheme.bodyMedium!.copyWith(color: Colors.white70),
                      ),
                    ),
                  ),
                   
                  // Activity-specific details (if available)
                  if (activity.isNotEmpty)
                    _buildActivitySpecificDetails(
                      selectedActivityCategory?.toLowerCase() ?? "",
                      activity,
                      event,
                    ),
                   
                  CustomElevatedButton(
                    text: "Submit".tr,
                    onPressed: () {
                      controller.fetchEventDetails(eventCreatedId!, selectedActivityCategory!);
                    },
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
