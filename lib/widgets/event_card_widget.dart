import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:volco/core/app_export.dart';
import 'package:volco/core/utils/image_constant.dart';
import 'package:volco/widgets/custom_image_view.dart';

class EventCardWidget extends StatelessWidget {
  final String eventName;
  final String imageUrl;
  final String eventDate;
  final String eventTime;
  final int volunteerCount;
  final String location;
  final String joinText;
  final VoidCallback? onTap;
  final VoidCallback? onJoinTap;

  const EventCardWidget({
    Key? key,
    required this.eventName,
    required this.imageUrl,
    required this.eventDate,
    required this.eventTime,
    required this.volunteerCount,
    required this.location,
    this.joinText = "Wants Join",
    this.onTap,
    this.onJoinTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap, // Tap the entire card if needed
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: appTheme.gray800,
          borderRadius: BorderRadius.circular(12.h),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha(20),
              blurRadius: 4,
              offset: Offset(0, 2),
            ),
          ],
        ),
        padding: EdgeInsets.all(10.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Event image and overlay
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12.h),
                  child: CustomImageView(
                    imagePath: imageUrl,
                    width: double.infinity,
                    height: 200.h,
                    fit: BoxFit.cover,
                  ),
                ),
                // Top-left overlay: icon and event date
                Positioned(
                  top: 10.h,
                  left: 10.h,
                  child: Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(8.h),
                        decoration: BoxDecoration(
                          color: appTheme.amber500,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.menu_book,
                          color: Colors.black,
                          size: 20.h,
                        ),
                      ),
                      SizedBox(width: 8.h),
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 10.h, vertical: 8.h),
                        decoration: BoxDecoration(
                          color: appTheme.gray400,
                          borderRadius: BorderRadius.circular(20.h),
                        ),
                        child: Text(
                          eventDate,
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // Bottom-right overlay: volunteer count badge
                Positioned(
                  right: 10.h,
                  bottom: 10.h,
                  child: SizedBox( // Wrap AspectRatio inside SizedBox
                    width: 50.h,   // Provide width
                    height: 50.h,  // Provide height
                    child: AspectRatio(
                      aspectRatio: 1, // Maintain square aspect ratio
                      child: Container(
                        padding: EdgeInsets.all(8.h),
                        decoration: BoxDecoration(
                          color: appTheme.gray50,
                          borderRadius: BorderRadius.circular(50.h),
                        ),
                        child: Center(
                          child: Text(
                            volunteerCount.toString(),
                            style: TextStyle(
                              color: appTheme.gray800,
                              fontWeight: FontWeight.bold,
                              fontSize: 24.h,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10.h),
            Row(
              spacing: 10.h,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,

              children: [
                Expanded(
                  child: AutoSizeText(
                    eventName,
                    style: theme.textTheme.headlineSmall?.copyWith(
                        color: Colors.white, fontWeight: FontWeight.bold),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),

                // Optionally, you can add event time below the event name if needed:
                AutoSizeText(
                  eventTime,
                  style: theme.textTheme.bodyMedium?.copyWith(color: Colors.white70),
                  maxLines: 1,
                ),
              ],

            ),
            SizedBox(height: 10.h),
            // Row with location, star icon, and join button
            Row(
              children: [
                // Location icon
                Container(
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(12.h),
                  ),
                  padding: EdgeInsets.all(8.h),
                  child: CustomImageView(
                    width: 24.h,
                    height: 24.h,
                    imagePath: ImageConstant.imgLocation,
                  ),
                ),
                SizedBox(width: 8.h),
                // Location text
                Expanded(
                  child: AutoSizeText(
                    location,
                    style: TextStyle(
                      color: Colors.grey.shade400,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                SizedBox(width: 8.h),
                // Star icon
                Container(
                  padding: EdgeInsets.all(8.h),
                  decoration: BoxDecoration(
                    color: appTheme.amber500,
                    borderRadius: BorderRadius.circular(50.h),
                  ),
                  child: Icon(
                    Icons.star_border_outlined,
                    color: Colors.black,
                    size: 20.h,
                  ),
                ),
                SizedBox(width: 8.h),
                // Join button with its own gesture detector
                GestureDetector(
                  onTap: onJoinTap,
                  child: Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: 32.h, vertical: 10.h),
                    decoration: BoxDecoration(
                      color: appTheme.cyan500,
                      borderRadius: BorderRadius.circular(50.h),
                    ),
                    child: Text(
                      joinText,
                      style: TextStyle(
                        fontSize: 18.h,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),

            // Event name text

          ],
        ),
      ),
    );
  }
}

