import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:volco/core/app_export.dart';
import 'package:volco/core/utils/image_constant.dart';
import 'package:volco/widgets/event_card_widget.dart';

import 'controller/profile_controller.dart';

class ProfileScreen extends StatelessWidget {
  final ProfileController controller = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: RefreshIndicator(
        onRefresh: () async {
          await controller.fetchUserDetails();
        },
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: Obx(() {
            if (controller.isLoading.value) {
              return Center(child: CircularProgressIndicator());
            }
            return SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.h, vertical: 10.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Back Button
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomImageView(
                          imagePath: ImageConstant.imgArrowLeft,
                          height: 28.h,
                          width: 30.h,
                          onTap: () => Get.back(),
                        ),
                        CustomImageView(
                          imagePath: ImageConstant.logoutimg,
                          height: 28.h,
                          width: 30.h,
                          onTap: () =>  AuthController().logout(),
                          placeHolder: "logout",

                        ),
                      ],
                    ),
                    SizedBox(height: 20.h),

                    // Profile Section
                    Row(
                      spacing: 20.h,
                      children: [
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12.h),
                              color: appTheme.blueGray900,
                            ),
                            height: 250.h,
                            padding: EdgeInsets.all(20.h),
                            child: Column(
                              spacing: 20.h,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  width: 110.h,
                                  height: 110.h,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(60.h),
                                    border: Border.all(
                                        color: appTheme.whiteA700, width: 5.h),
                                  ),
                                  child: Obx(
                                    () => CustomImageView(
                                      imagePath: controller
                                              .avatarUrl.value.isNotEmpty
                                          ? controller.avatarUrl.value
                                          : ImageConstant
                                              .imgProfileWhite, // Default profile image
                                      height: 100.h,
                                      width: 100.h,
                                      fit: BoxFit.cover,
                                      alignment: Alignment.center,
                                      radius: BorderRadius.circular(50.h),
                                    ),
                                  ),
                                ),
                                Obx(
                                  () => AutoSizeText(
                                    controller.fullName.value.isNotEmpty
                                        ? controller.fullName.value
                                        : "NA",
                                    maxLines: 2,
                                    style: CustomTextStyles.headlineLargePrimary
                                        .copyWith(color: Colors.white),
                                    textAlign: TextAlign.center,
                                    // softWrap: true,
                                    wrapWords: false,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Email
                              Text(
                                "Email",
                                style: TextStyle(
                                    fontSize: 14.h,
                                    color: appTheme.blueGray100,
                                    fontWeight: FontWeight.w500),
                              ),
                              Obx(
                                () => Text(
                                  controller.email.value.isNotEmpty
                                      ? controller.email.value
                                      : "NA",
                                  style: TextStyle(
                                      fontSize: 16.h,
                                      color: appTheme.lightBlue600,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              SizedBox(height: 8.h),

                              // Mobile Number
                              Text(
                                "Mobile",
                                style: TextStyle(
                                    fontSize: 14.h,
                                    color: appTheme.lightBlue600,
                                    fontWeight: FontWeight.w500),
                              ),
                              Obx(
                                () => Text(
                                  controller.mobileNumber.value.isNotEmpty
                                      ? controller.mobileNumber.value
                                      : "NA",
                                  style: TextStyle(
                                      fontSize: 16.h,
                                      color: appTheme.lightBlue600,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              SizedBox(height: 8.h),

                              // Age
                              Text(
                                "Age",
                                style: TextStyle(
                                    fontSize: 14.h,
                                    color: appTheme.blueGray100,
                                    fontWeight: FontWeight.w500),
                              ),
                              Obx(
                                () => Text(
                                  controller.age.value > 0
                                      ? controller.age.value.toString()
                                      : "NA",
                                  style: TextStyle(
                                      fontSize: 16.h,
                                      color: appTheme.lightBlue600,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              SizedBox(height: 8.h),

                              // Location
                              Text(
                                "Location",
                                style: TextStyle(
                                    fontSize: 14.h,
                                    color: appTheme.blueGray100,
                                    fontWeight: FontWeight.w500),
                              ),
                              Obx(
                                () => Text(
                                  controller.location.value.isNotEmpty
                                      ? controller.location.value
                                      : "NA",
                                  style: TextStyle(
                                      fontSize: 16.h,
                                      color: appTheme.lightBlue600,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20.h),

                    // Bio Section
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Bio",
                        style: TextStyle(
                            fontSize: 18.h, fontWeight: FontWeight.w600),
                      ),
                    ),
                    SizedBox(height: 5.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Obx(
                          () => Text(
                            controller.bio.value.isNotEmpty
                                ? controller.bio.value
                                : "NA",
                            style: TextStyle(fontSize: 16.h),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20.h),

                    // Tab Section
                    DefaultTabController(
                      length: 3,
                      child: Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12.h),
                              color: appTheme.blueGray900,
                            ),
                            child: TabBar(
                              indicatorAnimation: TabIndicatorAnimation.linear,
                              onTap: (index) {
                                // Handle tab change
                              },
                              controller: controller.tabController,
                              tabs: [
                                Tab(text: 'Volunteered'),
                                Tab(text: 'Posts'),
                                Tab(text: 'Organized'),
                              ],
                              labelColor: Theme.of(context).primaryColor,
                              unselectedLabelColor: Colors.grey,
                              indicatorColor: Theme.of(context).primaryColor,
                            ),
                          ),
                          SizedBox(
                            height: 600.h,
                            child: TabBarView(
                              controller: controller.tabController,
                              children: [
                                Obx(() {
                                  return ListView.separated(
                                      padding: EdgeInsets.all(10),
                                      separatorBuilder: (context, index) =>
                                          SizedBox(height: 20.h),
                                      itemCount:
                                          controller.volunteeredEvents.length,
                                      itemBuilder: (context, index) {
                                        final event =
                                            controller.volunteeredEvents[index];

                                        return EventCardWidget(
                                            eventName: event['event_name'],
                                            imageUrl: event['image_url'],
                                            eventDate:
                                                event['event_date'].toString(),
                                            eventTime:
                                                event['event_time'].toString(),
                                            volunteerCount:
                                                10, // Replace with actual count if available
                                            location: event['location'],
                                            onTap: () {
                                              // Navigate to event details if needed
                                            });
                                      });
                                }),
                                Center(child: Text('User Posts')),
                                Obx(() {
                                  return ListView.separated(
                                      padding: EdgeInsets.all(10),
                                      separatorBuilder: (context, index) =>
                                          SizedBox(height: 20.h),
                                      itemCount:
                                      controller.organizedEvents.length,
                                      itemBuilder: (context, index) {
                                        final event =
                                        controller.organizedEvents[index];

                                        return EventCardWidget(
                                            eventName: event['event_name'],
                                            imageUrl: event['image_url'],
                                            eventDate:
                                            event['event_date'].toString(),
                                            eventTime:
                                            event['event_time'].toString(),
                                            volunteerCount:
                                            10, // Replace with actual count if available
                                            location: event['location'],
                                            onTap: () {
                                              // Navigate to event details if needed
                                            });
                                      });
                                }),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}
