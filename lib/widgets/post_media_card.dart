import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:volco/core/app_export.dart';
import 'package:volco/core/utils/image_constant.dart';
import 'package:volco/widgets/custom_image_view.dart';

class PostCardWidget extends StatelessWidget {
  final int post_id;
  final String userImage;
  final String userName;
  final String? userEmail;
  final VoidCallback? onMenuTap;
  final int? eventReference; // optional event reference
  final String? eventReferenceName;
  final List<String>? hashtags; // optional hashtags
  final String? postDescription; // optional text body
  final String? postImage; // optional image url
  final String? postImageCaption; // optional image description
  final String? postDate; // date of post as String
  final int? likeCount;
  final int? commentCount;
  final bool isLiked; // New: whether the current user liked this post
  final VoidCallback? onLikeTap;
  final VoidCallback? onCommentTap;

  const PostCardWidget({
    Key? key,
    required this.post_id,
    required this.userImage,
    required this.userName,
    this.userEmail,
    this.onMenuTap,
    this.eventReference,
    this.eventReferenceName,
    this.hashtags,
    this.postDescription,
    this.postImage,
    this.postImageCaption,
    this.postDate,
    this.likeCount,
    this.commentCount,
    required this.isLiked,
    this.onLikeTap,
    this.onCommentTap,
  }) : super(key: key);

  Widget _buildHashtagChip(String tag) {
    return Padding(
      padding: EdgeInsets.only(right: 8.0),
      child: Text(
        tag,
        style: TextStyle(
          color: appTheme.lightBlue600,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      color: appTheme.blueGray900,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.h),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.h, vertical: 12.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // User info row (profile image, name, menu)
            ListTile(
              leading: CustomImageView(
                imagePath: userImage.isNotEmpty
                    ? userImage
                    : ImageConstant.imgProfileSkyBlue,
                height: 40.h,
                width: 40.h,
                radius: BorderRadius.circular(20.h),
              ),
              title: Text(
                userName,
                style: CustomTextStyles.titleLarge20.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              subtitle: userEmail != null
                  ? Text(
                      userEmail!,
                      style: CustomTextStyles.bodyMediumGray500,
                    )
                  : null,
              trailing: onMenuTap != null
                  ? GestureDetector(
                      onTap: onMenuTap,
                      child: CustomImageView(
                        imagePath: ImageConstant.menuImg,
                        height: 24.h,
                        width: 24.h,
                      ),
                    )
                  : null,
            ),
            Divider(color: Colors.white24),
            // Optional Event Reference Row
            if (eventReferenceName != null && eventReferenceName!.isNotEmpty)
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.h, vertical: 4.h),
                child: Text(
                  eventReferenceName!,
                  style:
                      CustomTextStyles.titleMediumGray50.copyWith(height: 1.4),
                ),
              ),
            // Optional Hashtags
            if (hashtags != null && hashtags!.isNotEmpty)
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.h, vertical: 4.h),
                child: Wrap(
                  spacing: 8.0,
                  children:
                      hashtags!.map((tag) => _buildHashtagChip(tag)).toList(),
                ),
              ),
            // Optional Post Description
            if (postDescription != null && postDescription!.isNotEmpty)
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.h, vertical: 8.h),
                child: Text(
                  postDescription!,
                  style:
                      CustomTextStyles.titleMediumGray50.copyWith(height: 1.4),
                ),
              ),
            // Optional Post Image and Caption
            if (postImage != null && postImage!.isNotEmpty)
              ClipRRect(
                borderRadius: BorderRadius.circular(12.h),
                child: CustomImageView(
                  imagePath: postImage!,
                  height: 200.h,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            if (postImage != null &&
                postImage!.isNotEmpty &&
                postImageCaption != null &&
                postImageCaption!.isNotEmpty)
              Padding(
                padding: EdgeInsets.only(top: 8.h, left: 8.h, right: 8.h),
                child: Text(
                  postImageCaption!,
                  style: CustomTextStyles.bodyMediumGray500,
                ),
              ),
            // Optional Post Date
            if (postDate != null && postDate!.isNotEmpty)
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.h, vertical: 4.h),
                child: Text(
                  postDate!,
                  style: TextStyle(
                    color: Colors.grey[400],
                    fontSize: 12.h,
                  ),
                ),
              ),
            Divider(color: Colors.white24, thickness: 1),
            // Action Buttons (Likes and Comments)
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.h, vertical: 12.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: onLikeTap,
                    child: Row(
                      children: [
                        CustomImageView(
                          imagePath: isLiked
                              ? ImageConstant.heartfilledSvg
                              : ImageConstant.heartSvg,
                          height: 24.h,
                          width: 24.h,
                        ),
                        SizedBox(width: 8.h),
                        Text(
                          likeCount != null ? likeCount.toString() : "0",
                          style: CustomTextStyles.bodyMediumGray500,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 16.h),
                  GestureDetector(
                    onTap: onCommentTap,
                    child: Row(
                      children: [
                        CustomImageView(
                          imagePath: ImageConstant.commentSvg,
                          height: 24.h,
                          width: 24.h,
                        ),
                        SizedBox(width: 8.h),
                        Text(
                          commentCount != null ? commentCount.toString() : "0",
                          style: CustomTextStyles.bodyMediumGray500,
                        ),
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
  }
}
