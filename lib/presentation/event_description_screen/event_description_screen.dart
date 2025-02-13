import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:volco/core/app_export.dart';
import 'package:volco/core/utils/image_constant.dart';
import 'package:volco/presentation/event_description_screen/controller/event_description_controller.dart';
import 'package:volco/presentation/event_description_screen/widgets/eventDescriptionField.dart';

class EventDescriptionScreen extends GetView<EventDescriptionController> {
  final String? selectedActivityCategory;
  final int? eventCreatedId;

  EventDescriptionScreen(
      {Key? key,
      required this.selectedActivityCategory,
      required this.eventCreatedId})
      : super(key: key);

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
                  CustomImageView(
                    imagePath: ImageConstant.imgArrowLeft,
                    height: 28.h,
                    width: 30.h,
                    onTap: () {
                      Get.back();
                    },
                  ),
                  Container(
                    padding: EdgeInsets.all(8.h),
                    // color: appTheme.gray800,
                    decoration: BoxDecoration(
                      color: appTheme.gray800,
                      borderRadius: BorderRadius.circular(12),
                    ),

                    child: CustomImageView(
                      imagePath: event['image_url'] ?? ImageConstant.imgTextSvg,
                      height: 200.h,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      radius: BorderRadius.circular(4.h),
                    ),
                  ),
                  AutoSizeText(event['event_name'] ?? "Event Name",
                      style: CustomTextStyles.titleLarge20
                          .copyWith(fontSize: 40.h),
                      maxLines: 2,
                      minFontSize: 20,
                      overflow: TextOverflow.ellipsis),

                  AutoSizeText(
                    selectedActivityCategory ?? "Category",
                    style: CustomTextStyles.headlineLargePrimary.copyWith(
                      fontWeight: FontWeight.w500,
                      height: 0.2,
                      fontSize: 28.h,
                    ),
                  ),
                  // time, date and duration
                  Row(
                    spacing: 20.h,
                    children: [
                      Expanded(
                        child: AspectRatio(
                          aspectRatio: 1, // Square aspect ratio
                          child: Container(
                            padding: EdgeInsets.all(8.h),
                            decoration: BoxDecoration(
                              color:
                                  appTheme.blueGray900, // Light grey background
                              borderRadius: BorderRadius.circular(12.h),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                AutoSizeText(
                                  event['event_time'] ?? "N/A",
                                  style: theme.textTheme.bodyLarge!.copyWith(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 24.h),
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
                      // Spacing between containers
                      Expanded(
                        child: AspectRatio(
                          aspectRatio: 1, // Square aspect ratio
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
                                      fontSize: 24.h),
                                ),
                                SizedBox(height: 4.h),
                                Text(
                                  "Date",
                                  style: theme.textTheme.bodyMedium
                                      ?.copyWith(fontSize: 18.h),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      // Spacing between containers
                      Expanded(
                        child: AspectRatio(
                          aspectRatio: 1, // Square aspect ratio
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
                                      fontSize: 24.h),
                                ),
                                SizedBox(height: 4.h),
                                Text(
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

                  //event Description
                  Container(
                    width: double.infinity,
                    padding:
                        EdgeInsets.all(12.h), // Padding inside the container
                    decoration: BoxDecoration(
                      color: appTheme.blueGray900, // Light grey background
                      borderRadius:
                          BorderRadius.circular(12.h), // Rounded corners
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          event['event_description'] ??
                              "No description available.",
                          style: theme.textTheme.bodyMedium
                              ?.copyWith(fontSize: 18.h),
                          textAlign: TextAlign.justify,
                        ),
                      ],
                    ),
                  ),

                  //event Location
                  GestureDetector(
                    onTap: () {
                      print("Open Map");
                    },
                    child: Container(
                      width: double.infinity,
                      padding:
                          EdgeInsets.all(12.h), // Padding inside the container
                      decoration: BoxDecoration(
                        color: appTheme.blueGray900, // Light grey background
                        borderRadius:
                            BorderRadius.circular(12.h), // Rounded corners
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
                          SizedBox(height: 8.h), // Spacing before location text
                          Text(
                            event['location'] ?? "N/A",
                            style: theme.textTheme.bodyLarge,
                          ),
                        ],
                      ),
                    ),
                  ),

                  // Contact Number
                  Container(
                    decoration: BoxDecoration(
                      color: appTheme.blueGray900, // Background color
                      borderRadius:
                          BorderRadius.circular(12.h), // Rounded corners
                    ),
                    child: ListTile(
                      contentPadding: EdgeInsets.symmetric(
                          horizontal: 12.h), // Remove default padding
                      leading: Icon(Icons.phone_in_talk_outlined,
                          color: ColorSchemes.lightCodeColorScheme.primary,
                          size: 28.h),
                      // Phone Icon
                      title: Text(
                        "Contact Number",
                        style: theme.textTheme.bodyLarge!.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Colors.white, // Text color
                        ),
                      ),
                      subtitle: Text(
                        event['contact_number'], // Replace with dynamic number
                        style: theme.textTheme.bodyMedium!
                            .copyWith(color: Colors.white70),
                      ),
                      onTap: () {
                        // Handle tap (e.g., open dialer)
                      },
                    ),
                  ),

                  // Social Media Link
                  Container(
                    decoration: BoxDecoration(
                      color: appTheme.blueGray900, // Background color
                      borderRadius:
                          BorderRadius.circular(12.h), // Rounded corners
                    ),
                    child: ListTile(
                      contentPadding: EdgeInsets.symmetric(
                          horizontal: 12.h), // Remove default padding
                      // leading: Icon(Icons.network_cell, color: ColorSchemes.lightCodeColorScheme.primary, size: 28.h),
                      leading: CustomImageView(
                        imagePath: ImageConstant.imgUrlSkyBlue,
                        width: 24.h,
                        height: 24.h,
                        // alignment: Alignment.center,
                      ),
                      // Phone Icon
                      title: Text(
                        "Social Media Link",
                        style: theme.textTheme.bodyLarge!.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Colors.white, // Text color
                        ),
                      ),
                      subtitle: Text(
                        event[
                            'social_media_link'], // Replace with dynamic number
                        style: theme.textTheme.bodyMedium!
                            .copyWith(color: Colors.white70),
                      ),
                      onTap: () {
                        // Handle tap (e.g., open dialer)
                      },
                    ),
                  ),

                  // Emergency Contact Number
                  Container(
                    decoration: BoxDecoration(
                      color: appTheme.blueGray900, // Background color
                      borderRadius:
                          BorderRadius.circular(12.h), // Rounded corners
                    ),
                    child: ListTile(
                      contentPadding: EdgeInsets.symmetric(
                          horizontal: 12.h), // Remove default padding
                      // leading: Icon(Icons.network_cell, color: ColorSchemes.lightCodeColorScheme.primary, size: 28.h),
                      leading: CustomImageView(
                        imagePath: ImageConstant.imgUrlEmergencyContact,
                        width: 24.h,
                        height: 24.h,
                        // alignment: Alignment.center,
                      ),
                      // Phone Icon
                      title: Text(
                        "Emergency Contact Number",
                        style: theme.textTheme.bodyLarge!.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Colors.white, // Text color
                        ),
                      ),
                      subtitle: Text(
                        event[
                            'emergency_contact_info'], // Replace with dynamic number
                        style: theme.textTheme.bodyMedium!
                            .copyWith(color: Colors.white70),
                      ),
                      onTap: () {
                        // Handle tap (e.g., open dialer)
                      },
                    ),
                  ),

                  if (activity.isNotEmpty) ...[
                    // volunteer req, subject focused , age group, language requrements

                    Column(
                      spacing: 20.h,
                      children: [
                        Row(
                          spacing: 20.h,
                          children: [
                            Expanded(
                              child: InfoContainer(
                                  title: "Volunteer Required",
                                  value:
                                      event["volunteer_requirements"] ?? "Any"),
                            ),
                            Expanded(
                              child: InfoContainer(
                                  title: "Subject Focused",
                                  value: activity["subject_focus"]),
                            ),
                          ],
                        ),
                        Row(
                          spacing: 20.h,
                          children: [
                            Expanded(
                              child: InfoContainer(
                                  title: "Age Group",
                                  value: activity["age_group"] ?? "Any"),
                            ),
                            Expanded(
                              child: InfoContainer(
                                  title: "Language Requirement",
                                  value: activity["language_requirements"] ??
                                      "Any"),
                            ),
                          ],
                        ),
                      ],
                    ),

                    // Materials Needed
                    Container(
                      width: double.infinity, // Full width
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
                          SizedBox(
                              height: 8.h), // Space between title and values
                          Text(
                            activity['materials_needed'] ??
                                "N/A", // Example values
                            style: theme.textTheme.bodyMedium!.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                  CustomElevatedButton(
                    text: "Submit".tr,
                    onPressed: () {
                      controller.fetchEventDetails(
                          eventCreatedId!, selectedActivityCategory!);
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
