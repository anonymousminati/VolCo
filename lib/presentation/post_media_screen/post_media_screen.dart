import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:volco/core/app_export.dart';
import 'package:volco/core/utils/image_constant.dart';
import 'package:volco/presentation/post_media_screen/controller/post_media_controller.dart';
import 'package:volco/presentation/post_media_screen/widgets/create_post_media_bottom_sheet.dart';
import 'package:volco/widgets/custom_image_view.dart';
import 'package:volco/widgets/post_media_card.dart';

class PostMediaScreen extends StatelessWidget {
  final PostMediaController controller = Get.put(PostMediaController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: RefreshIndicator(
        onRefresh: () async {
          await controller.fetchPosts();
          // Optionally add refresh logic here
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    buildHeader(),
                    SizedBox(height: 34.h),
                    // PostCardWidget(
                    //   post_id: 1,
                    //   userImage: controller.avatarUrl.value.isEmpty
                    //       ? ImageConstant.imgProfileSkyBlue
                    //       : controller.avatarUrl.value,
                    //   userName: "Prathamesh Malode",
                    //   userEmail: "prathameshmalode.2@gmail.com",
                    //   onMenuTap: () {
                    //     // Show menu options
                    //   },
                    //   eventReference: 15,
                    //   eventReferenceName: "Event Name",
                    //   hashtags: ["#volunteer", "#NGO", "#community"],
                    //   postDescription:
                    //       "Inspirational, झण्डै 25 वर्ष देखि निशुल्क पढाउदै शिक्षक: Niraj Shah from Rautahat has been teaching around 100+ students especially from a low economic background & orphan for 25 Yrs at Gaur rice mill. He searches for students himself, convinces their parents that education is important and teaches them. People like him should get more support and attention. ❤️",
                    //   postImage:
                    //       "https://pbs.twimg.com/media/Gh3rvJvaIAAwrHY?format=jpg&name=small",
                    //   postImageCaption: "Group photo from the event",
                    //   postDate: "Feb 20, 2025",
                    //   likeCount: 123,
                    //   commentCount: 45,
                    //   onLikeTap: () {
                    //     // Handle like tap
                    //   },
                    //   onCommentTap: () {
                    //     // Handle comment tap (open comments popup)
                    //   },
                    // ),
                    Obx(() {
                      if (controller.postsFeed.isEmpty) {
                        return Center(child: Text("No posts available"));
                      }
                      return ListView.separated(
                        separatorBuilder: (context, index) =>
                            SizedBox(height: 20.h),
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: controller.postsFeed.length,
                        itemBuilder: (context, index) {
                          final post = controller.postsFeed[index];
                          bool isLiked =
                              controller.likedPosts.contains(post['p_id']);
                          return PostCardWidget(
                            post_id: post['p_id'],
                            userImage: post["user_image"],
                            userName: post["user_name"],
                            userEmail: post["user_email"],
                            eventReference: post['event_reference'],
                            eventReferenceName: post['event_reference_name'],
                            hashtags: post['hashtags'] != null
                                ? post['hashtags'].split(',')
                                : [],
                            postDescription: post['description'],
                            postImage: post['image_url'] ?? "",
                            postImageCaption: post['image_caption'],
                            postDate: post['created_at'].toString(),
                            likeCount: post['like_count'],
                            commentCount: post['comment_count'],
                            isLiked: isLiked,
                            onLikeTap: () {
                              controller.toggleLike(post['p_id']);
                            },
                            onCommentTap: () {
                              // Handle comment tap (e.g., open comments popup)
                              controller.showCommentsBottomSheet(post['p_id']);
                            },
                          );
                        },
                      );
                    }),
                  ],
                ),
              ),
            );
          }),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Get.bottomSheet(
                CreatePostBottomSheet(
                  onPostSuccess: () {
                    // Optionally refresh the feed here
                    controller.fetchPosts();
                    Get.back();
                  },
                  controller: controller,
                ),
                backgroundColor: appTheme.blueGray900,
                isScrollControlled: true,
              );
            },
            child: Icon(Icons.add),
          ),
        ),
      ),
    );
  }

  Widget buildHeader() {
    return SizedBox(
      width: double.maxFinite,
      child: Row(
        children: [
          CustomImageView(
            imagePath: ImageConstant.imgLogoStandard,
            height: 32.h,
            width: 34.h,
          ),
          Padding(
            padding: EdgeInsets.only(left: 16.h),
            child: Text(
              "VolCo".tr,
              style:
                  theme.textTheme.headlineSmall?.copyWith(color: Colors.white),
            ),
          ),
          Spacer(),
          CustomImageView(
            imagePath: ImageConstant.imgLocation,
            height: 28.h,
            width: 30.h,
            onTap: () {
              AuthController().logout();
            },
          ),
          CustomImageView(
            imagePath: ImageConstant.imgBellBlue,
            height: 30.h,
            width: 30.h,
            onTap: () {},
          ),
          Obx(
            () => CustomImageView(
              imagePath: controller.avatarUrl.value.isEmpty
                  ? ImageConstant.imgProfileSkyBlue
                  : controller.avatarUrl.value,
              height: 30.h,
              width: 30.h,
              margin: EdgeInsets.only(left: 20.h),
              radius: BorderRadius.circular(14.h),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHashtagChip(String tag) {
    return Text(
      tag,
      style:
          TextStyle(color: appTheme.lightBlue600, fontWeight: FontWeight.bold),
    );
  }
}
