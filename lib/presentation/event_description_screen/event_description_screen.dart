import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:volco/core/app_export.dart';
import 'package:volco/core/utils/image_constant.dart';
import 'package:volco/presentation/event_description_screen/controller/event_description_controller.dart';
import 'package:volco/presentation/event_description_screen/widgets/eventDescriptionField.dart';
import 'package:volco/widgets/custom_image_view.dart';

class EventDescriptionScreen extends GetView<EventDescriptionController> {
  final String? selectedActivityCategory;
  final int? eventCreatedId;
  final bool isForRegistration;

  EventDescriptionScreen({
    Key? key,
    required this.selectedActivityCategory,
    required this.eventCreatedId,
    required this.isForRegistration,
  }) : super(key: key);

  /// This function builds extra fields based on the category.
  Widget _buildActivitySpecificDetails(
      String category, RxMap activity, RxMap event) {
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              spacing: 20.h,
              children: [
                Expanded(
                  child: InfoContainer(
                    title: "Volunteer Required",
                    value: event["volunteer_requirements"]?.toString() ?? "N/A",
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
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(12.h),
              decoration: BoxDecoration(
                color: appTheme.blueGray900,
                borderRadius: BorderRadius.circular(12.h),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Materials Needed",
                    style: theme.textTheme.bodyLarge!.copyWith(
                      color: Colors.white70,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    activity["materials_needed"] ?? "N/A",
                    style: theme.textTheme.bodyMedium!.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
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
                    value: (activity["type_of_service"].split(',').map((e) {
                          return e.trim();
                        }).toList())
                            ?.join(", ") ??
                        "N/A",
                  ),
                ),
                Expanded(
                  child: InfoContainer(
                    title: "Medical Professional",
                    value: activity["medical_professional_required"] ?? "N/A",
                  ),
                ),
              ],
            ),
            Row(
              spacing: 20.h,
              children: [
                Expanded(
                  child: InfoContainer(
                    title: "Equipment Needed",
                    value: activity["equipment_needed"] ?? "N/A",
                  ),
                ),
                Expanded(
                  child: InfoContainer(
                    title: "Volunteer Required",
                    value: event["volunteer_requirements"]?.toString() ?? "N/A",
                  ),
                ),
              ],
            ),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(12.h),
              decoration: BoxDecoration(
                color: appTheme.blueGray900,
                borderRadius: BorderRadius.circular(12.h),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Medication Handling",
                    style: theme.textTheme.bodyLarge!.copyWith(
                      color: Colors.white70,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    activity["medication_handling_guidelines"] ?? "N/A",
                    style: theme.textTheme.bodyMedium!.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        );

      case "counseling":
        return Column(
          spacing: 20.h,
          children: [
            Row(
              spacing: 20.h,
              children: [
                Expanded(
                  child: InfoContainer(
                    title: "Volunteer Required",
                    value: event["volunteer_requirements"]?.toString() ?? "N/A",
                  ),
                ),
                Expanded(
                  child: InfoContainer(
                    title: "Counseling Type",
                    value: activity["counseling_type"] ?? "N/A",
                  ),
                ),
              ],
            ),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(12.h),
              decoration: BoxDecoration(
                color: appTheme.blueGray900,
                borderRadius: BorderRadius.circular(12.h),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Session Format",
                    style: theme.textTheme.bodyLarge!.copyWith(
                      color: Colors.white70,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    activity["session_format"] ?? "N/A",
                    style: theme.textTheme.bodyMedium!.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        );

      case "conservation":
        return Column(
          spacing: 20.h,
          children: [
            Row(
              spacing: 20.h,
              children: [
                Expanded(
                  child: InfoContainer(
                    title: "Activity Type",
                    value: activity["activity_type"] ?? "N/A",
                  ),
                ),
                Expanded(
                  child: InfoContainer(
                    title: "Tools Provided/Needed",
                    value: activity["tools_provided_needed"] ?? "N/A",
                  ),
                ),
              ],
            ),
            Row(
              spacing: 20.h,
              children: [
                Expanded(
                  child: InfoContainer(
                    title: "Volunteer Required",
                    value: event["volunteer_requirements"]?.toString() ?? "N/A",
                  ),
                ),
                Expanded(
                  child: InfoContainer(
                    title: "Environmental Impact",
                    value:
                        activity["environmental_impact_description"] ?? "N/A",
                  ),
                ),
              ],
            ),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(12.h),
              decoration: BoxDecoration(
                color: appTheme.blueGray900,
                borderRadius: BorderRadius.circular(12.h),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Waste Disposal Plan",
                    style: theme.textTheme.bodyLarge!.copyWith(
                      color: Colors.white70,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    activity["waste_disposal_plan"] ?? "N/A",
                    style: theme.textTheme.bodyMedium!.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        );

      case "work with elders":
        return Column(
          spacing: 20.h,
          children: [
            Row(
              spacing: 20.h,
              children: [
                Expanded(
                  child: InfoContainer(
                    title: "Volunteer Required",
                    value: event["volunteer_requirements"]?.toString() ?? "N/A",
                  ),
                ),
                Expanded(
                  child: InfoContainer(
                    title: "Activity Type",
                    value: activity["activity_type"] ?? "N/A",
                  ),
                ),
              ],
            ),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(12.h),
              decoration: BoxDecoration(
                color: appTheme.blueGray900,
                borderRadius: BorderRadius.circular(12.h),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Wheelchair Accessible",
                    style: theme.textTheme.bodyLarge!.copyWith(
                      color: Colors.white70,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    activity["wheelchair_accessible"] ?? "N/A",
                    style: theme.textTheme.bodyMedium!.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(12.h),
              decoration: BoxDecoration(
                color: appTheme.blueGray900,
                borderRadius: BorderRadius.circular(12.h),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Items to Bring",
                    style: theme.textTheme.bodyLarge!.copyWith(
                      color: Colors.white70,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    activity["items_to_bring"] ?? "N/A",
                    style: theme.textTheme.bodyMedium!.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        );

      case "work with orphans":
        return Column(
          spacing: 20.h,
          children: [
            Row(
              spacing: 20.h,
              children: [
                Expanded(
                  child: InfoContainer(
                    title: "Volunteer Required",
                    value: event["volunteer_requirements"]?.toString() ?? "N/A",
                  ),
                ),
                Expanded(
                  child: InfoContainer(
                    title: "Child Age Range",
                    value: activity["child_age_range"] ?? "N/A",
                  ),
                ),
              ],
            ),
            Row(
              spacing: 20.h,
              children: [
                Expanded(
                  child: InfoContainer(
                    title: "Activity Type",
                    value: activity["activity_type"] ?? "N/A",
                  ),
                ),
                Expanded(
                  child: InfoContainer(
                    title: "Donation Needs",
                    value: activity["donation_needs"] ?? "N/A",
                  ),
                )
              ],
            ),
          ],
        );

      case "animal rescue":
        return Column(
          spacing: 20.h,
          children: [
            Row(
              spacing: 20.h,
              children: [
                Expanded(
                  child: InfoContainer(
                    title: "Animal Type",
                    value: activity["animal_type"] ?? "N/A",
                  ),
                ),
                Expanded(
                  child: InfoContainer(
                    title: "Tasks Involved",
                    value: activity["tasks_involved"] ?? "N/A",
                  ),
                ),
              ],
            ),
            Row(
              spacing: 20.h,
              children: [
                Expanded(
                  child: InfoContainer(
                    title: "Vaccination Status",
                    value: activity["vaccination_status_disclosure"] ?? "N/A",
                  ),
                ),
                Expanded(
                  child: InfoContainer(
                    title: "Handling Equipment",
                    value: activity["handling_equipment"] ?? "N/A",
                  ),
                ),
              ],
            ),
          ],
        );

      case "cleaning":
        return Column(
          spacing: 20.h,
          children: [
            Row(
              spacing: 20.h,
              children: [
                Expanded(
                  child: InfoContainer(
                    title: "Volunteer Required",
                    value: event["volunteer_requirements"]?.toString() ?? "N/A",
                  ),
                ),
                Expanded(
                  child: InfoContainer(
                    title: "Area Type",
                    value: activity["area_type"] ?? "N/A",
                  ),
                ),
              ],
            ),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(12.h),
              decoration: BoxDecoration(
                color: appTheme.blueGray900,
                borderRadius: BorderRadius.circular(12.h),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Waste Category",
                    style: theme.textTheme.bodyLarge!.copyWith(
                      color: Colors.white70,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    activity["waste_category"] ?? "N/A",
                    style: theme.textTheme.bodyMedium!.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(12.h),
              decoration: BoxDecoration(
                color: appTheme.blueGray900,
                borderRadius: BorderRadius.circular(12.h),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Recycling Plan",
                    style: theme.textTheme.bodyLarge!.copyWith(
                      color: Colors.white70,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    activity["recycling_plan_description"] ?? "N/A",
                    style: theme.textTheme.bodyMedium!.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        );

      default:
        return SizedBox.shrink();
    }
  }

  Widget _buildTagBadge(String tag) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: appTheme.amber500,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        tag,
        style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: RefreshIndicator(
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
                  padding:
                      EdgeInsets.symmetric(horizontal: 24.h, vertical: 10.h),
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

                      _buildDescriptionDetails(event),

                      // Activity-specific details (if available)
                      if (activity.isNotEmpty)
                        _buildActivitySpecificDetails(
                          selectedActivityCategory?.toLowerCase() ?? "",
                          activity,
                          event,
                        ),
                      (controller.eventTags.isEmpty)
                          ? Center(child: Text("No tags available"))
                          : Wrap(
                              spacing: 8.0, // Space between tags
                              runSpacing: 4.0, // Space between rows
                              children: controller.eventTags
                                  .map((tag) => _buildTagBadge(tag))
                                  .toList(),
                            ),
                      Row(
                        spacing: 20.h,
                        children: [
                          Expanded(
                            child: CustomElevatedButton(
                              text: "Go to Home".tr,
                              onPressed: () {
                                // controller.fetchEventDetails(
                                //     eventCreatedId!, selectedActivityCategory!);
                                Get.toNamed(AppRoutes.homeScreen);
                              },
                            ),
                          ),
                          Obx(() {
                            // Only show registration buttons if the current user is not the organizer
                            if (isForRegistration &&
                                controller.userId.value !=
                                    controller
                                        .eventDetails.value["organizer_id"]) {
                              if (controller.isUserisRegistered.value) {
                                // Show Cancel Registration button
                                return Expanded(
                                  child: CustomElevatedButton(
                                    text: "Cancel Registration".tr,
                                    buttonStyle: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.redAccent),
                                    buttonTextStyle: CustomTextStyles
                                        .titleMedium16_1
                                        .copyWith(color: Colors.white),
                                    onPressed: () async {
                                      bool success =
                                          await controller.cancelRegistration();
                                      if (success) {
                                        Get.snackbar("Success",
                                            "Registration cancelled successfully.");
                                      } else {
                                        Get.snackbar("Error",
                                            "Failed to cancel registration. Please try again.");
                                      }
                                    },
                                  ),
                                );
                              } else {
                                // Show Join event button
                                return Expanded(
                                  child: CustomElevatedButton(
                                    text: "Join event".tr,
                                    buttonStyle: ElevatedButton.styleFrom(
                                        backgroundColor: appTheme.green600),
                                    buttonTextStyle: CustomTextStyles
                                        .titleMedium16_1
                                        .copyWith(color: appTheme.black900),
                                    onPressed: () {
                                      print("join event clicked");
                                      Get.offAllNamed(
                                          AppRoutes.volunteerRegistrationScreen,
                                          arguments: {
                                            "eventId": controller
                                                .eventDetails.value["event_id"],
                                          });
                                    },
                                  ),
                                );
                              }
                            } else {
                              return SizedBox.shrink();
                            }
                          }),
                        ],
                      )
                    ],
                  ),
                ),
              );
            }),
          ),
          onRefresh: () {
            return controller.fetchEventDetails(
                eventCreatedId!, selectedActivityCategory!);
          }),
    );
  }

  Widget _buildDescriptionDetails(RxMap event) {
    return Column(
      spacing: 20.h,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
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
                        style: theme.textTheme.bodyMedium
                            ?.copyWith(fontSize: 18.h),
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
                        maxLines: 1,
                      ),
                      SizedBox(height: 4.h),
                      AutoSizeText(
                        "Date",
                        style: theme.textTheme.bodyMedium
                            ?.copyWith(fontSize: 18.h),
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
                        style: theme.textTheme.bodyMedium
                            ?.copyWith(fontSize: 18.h),
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
            print(
                "destinationCordinates: ${event['location_cords']['latitude']} to ${event['location_cords']['longitude']} ");
            Get.toNamed(AppRoutes.googleMapScreen, arguments: {
              "destinationCordinates": LatLng(
                  event['location_cords']['latitude'],
                  event['location_cords']['longitude'])
            });
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
              style:
                  theme.textTheme.bodyMedium!.copyWith(color: Colors.white70),
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
              style:
                  theme.textTheme.bodyMedium!.copyWith(color: Colors.white70),
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
              style:
                  theme.textTheme.bodyMedium!.copyWith(color: Colors.white70),
            ),
          ),
        ),
      ],
    );
  }
}
