import 'dart:ffi';
import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:volco/core/app_export.dart';
import 'package:volco/core/utils/image_constant.dart';
import 'package:volco/core/utils/supabase_handler.dart';
import 'package:volco/presentation/create_event_catogory_screen/models/create_event_catogory_model.dart';
import 'package:volco/presentation/create_event_screen/models/create_event_model.dart';
import 'package:volco/presentation/user_details_screen/models/user_details_model.dart';
import 'package:volco/routes/app_routes.dart';
import 'package:volco/widgets/event_card_widget.dart';
import 'package:volco/widgets/label_widget.dart';

class PostMediaController extends GetxController {
  // Text controllers
  RxBool isLoading = true.obs;
  final SupabaseClient supabaseClient = SupabaseHandler().supabaseClient;
  final SupabaseService supabaseService = SupabaseService();

  // Search bar controller
  final searchBarController = TextEditingController();
  Rxn<XFile> pickedImage = Rxn<XFile>();
  final postDescriptionController = TextEditingController();
  final postImageCaptionController = TextEditingController();
  final postHashTagController =
      TextEditingController(); //this will combine hashtags with comma separated
  final postEventReferenceController =
      TextEditingController(); //this will combine event reference with comma separated
  final postDateController = TextEditingController();
  final postLikeCountController = TextEditingController();
  final postCommentCountController = TextEditingController();
  final postUserNameController = TextEditingController();
  final postUserEmailController = TextEditingController();
  RxList<CommentModel> comments = <CommentModel>[].obs;
  final TextEditingController commentController = TextEditingController();
  RxList<Map<String, dynamic>> postsFeed = <Map<String, dynamic>>[].obs;
  RxString avatarUrl = ''.obs;
  RxSet<int> likedPosts = <int>{}.obs;

  @override
  void onInit() {
    super.onInit();
    isLoading.value = true;
    _fetchAvatarUrl();
    fetchPosts();

    shuffleAndPrintColors();
    subscribeToPostsFeed();
    isLoading.value = false;
    searchBarController.addListener(() {});
  }

  void _fetchAvatarUrl() async {
    try {
      User? user = await SupabaseService().getUserData();
      if (user != null) {
        avatarUrl.value =
            user.userMetadata?['avatar_url']; // Update reactive value
      }
    } catch (error) {
      print('Error fetching avatar URL: $error');
    }
  }

  List<Color> myColors = [
    Color(0xFFB6F36B),
    Color(0xFFFDDE67),
    Color(0xFFFF9B61),
    Color(0xFFC8A0FF),
    Color(0xFF95DBFA),
    Color(0xFF7462E1),
    Color(0xFFFBF3DA),
    Color(0xFFF2E0A6),
  ].obs;

  Future<void> pickImage() async {
    final picker = ImagePicker();
    final XFile? selectedImage =
        await picker.pickImage(source: ImageSource.gallery);
    if (selectedImage != null) {
      pickedImage.value = selectedImage;
    }
  }

  Future<void> fetchPosts() async {
    try {
      // Call the RPC function to get posts with like and comment counts.
      final response = await supabaseClient
          .rpc('get_posts_with_counts', params: {}).select();
      print("Response fetch posts: $response");
      final List<Map<String, dynamic>> posts =
          List<Map<String, dynamic>>.from(response);
      postsFeed.assignAll(posts);
      postsFeed.refresh();
      // Also update the liked posts for the current user.
      await fetchUserLikes();
    } catch (e) {
      print("Error fetching posts: $e");
    }
  }

  // Fetch all posts that the current user has liked
  Future<void> fetchUserLikes() async {
    try {
      final userId = await supabaseService.getUserId();
      if (userId == null) return;
      final likesResponse = await supabaseClient
          .from('likes')
          .select('post_id')
          .eq('user_id', userId);
      final likedPostIds =
          likesResponse.map<int>((like) => like['post_id'] as int).toSet();
      likedPosts.assignAll(likedPostIds);
      likedPosts.refresh();
    } catch (e) {
      print("Error fetching user likes: $e");
    }
  }

  // Toggle like status for a given post

  // Toggle like status for a given post
  Future<void> toggleLike(int postId) async {
    try {
      final userId = await supabaseService.getUserId();
      if (userId == null) return;
      if (likedPosts.contains(postId)) {
        // If already liked, remove the like record.
        await supabaseClient
            .from('likes')
            .delete()
            .eq('post_id', postId)
            .eq('user_id', userId);
        likedPosts.remove(postId);
      } else {
        // If not liked, insert a new like record.
        await supabaseClient.from('likes').insert({
          'post_id': postId,
          'user_id': userId,
        });
        likedPosts.add(postId);
      }
      // Refresh the reactive set to update the UI.
      likedPosts.refresh();
      // Re-fetch posts to update like counts.
      await fetchPosts();
    } catch (e) {
      print("Error toggling like: $e");
    }
  }

  Future<bool> createPost() async {
    try {
      // Get current user id
      var userDetails = await supabaseService.getUserData();
      String? userId = userDetails?.id;
      if (userId == null) return false;

      // Optionally upload image if one is selected.
      String? imageUrl;
      String? imageGlobalUrl;
      if (pickedImage.value != null) {
        final imageFile = File(pickedImage.value!.path);

        final imageName =
            "post_images/${DateTime.now().millisecondsSinceEpoch}_${pickedImage.value!.path.split('/').last}";
        // Implement your image upload function in supabaseService.
        imageUrl = await supabaseClient.storage
            .from("post_images")
            .upload(imageName, imageFile);

        if (imageUrl != null) {
          print("Image uploaded successfully: $imageUrl");
          imageGlobalUrl = supabaseClient.storage
              .from('post_images')
              .getPublicUrl('1740893421117_scaled_1000132231.jpg');
          print("public Url: $imageGlobalUrl");
        } else {
          print("Error uploading image");
          return false;
        }
      }

      Map<String, dynamic> postRecord = {
        'user_id': userId,
        'user_name': userDetails?.userMetadata?['full_name'] ?? "Unknown",
        'user_email': userDetails?.userMetadata?['email'] ?? "Unknown",
        'user_image': avatarUrl.value,
        'event_reference':
            null, // Set to an integer if you want to reference an event.
        'event_reference_name':
            null, // Set to event name if event_reference is set.
        'hashtags': postHashTagController.text.trim().isNotEmpty
            ? postHashTagController.text.trim()
            : null,
        'description': postDescriptionController.text.trim(),
        'image_url':
            imageGlobalUrl, // This will be null if no image was selected.
        'image_caption': postImageCaptionController.text.trim().isNotEmpty
            ? postImageCaptionController.text.trim()
            : null,
      };

      final response =
          await supabaseClient.from('posts').insert(postRecord).select();
      print("response: $response");
      return true;
    } catch (e) {
      print("Error in createPost: $e");
      return false;
    }
  }

  // Subscribe to realtime changes on posts, likes, and comments tables
  void subscribeToPostsFeed() {
    // Subscribe to changes on posts table.
    supabaseClient.from('posts').stream(primaryKey: ['post_id']).listen((data) {
      print("Realtime update on posts: $data");
      fetchPosts();
    });

    // Subscribe to changes on likes table.
    supabaseClient.from('likes').stream(primaryKey: ['like_id']).listen((data) {
      print("Realtime update on likes: $data");
      fetchPosts();
    });

    // Subscribe to changes on comments table.
    supabaseClient
        .from('comments')
        .stream(primaryKey: ['comment_id']).listen((data) {
      print("Realtime update on comments: $data");
      fetchPosts();
    });
  }

  void shuffleAndPrintColors() {
    // Create a random number generator.
    final random = Random();

    // Shuffle the list in place using the Fisher-Yates algorithm.
    for (var i = myColors.length - 1; i > 0; i--) {
      // Pick a random number from 0 to i.
      var n = random.nextInt(i + 1);

      // Swap colors[i] with the element at random index.
      var temp = myColors[i];
      myColors[i] = myColors[n];
      myColors[n] = temp;
    }

    // Print the shuffled list of colors.
    print('Shuffled Colors:');
    myColors.forEach((color) => print(color));
  }

  /// --------------------------
  /// Comments Related Functions
  /// --------------------------

  // Fetch comments for a given post (ordered descending: newest first)
  Future<void> fetchComments(int postId) async {
    try {
      // You might want to set a separate loading flag for comments if needed.
      final response = await supabaseClient
          .from('comments')
          .select()
          .eq('post_id', postId)
          .order('created_at', ascending: false);
      print("Response fetch comments for postid $postId: $response");
      if (response != null) {
        final List<CommentModel> loadedComments =
            List<Map<String, dynamic>>.from(response)
                .map((json) => CommentModel.fromJson(json))
                .toList();
        comments.assignAll(loadedComments);
      }
    } catch (e) {
      print("Error fetching comments: $e");
    }
  }

  // Add a new comment for a given post
  Future<void> addComment(int postId) async {
    final String text = commentController.text.trim();
    if (text.isEmpty) return;
    try {
      final user = await supabaseService.getUserData();
      if (user == null) return;
      final userId = user.id;
      final insertion = await supabaseClient.from('comments').insert({
        'post_id': postId,
        'user_id': userId,
        'comment': text,
      }).select();
      if (insertion != null && insertion is List && insertion.isNotEmpty) {
        final newComment = CommentModel.fromJson(insertion[0]);
        // Prepend new comment so that newest appears on top.
        comments.insert(0, newComment);
        commentController.clear();
      }
    } catch (e) {
      print("Error adding comment: $e");
    }
  }

  // Function to show a bottom sheet for comments for a given post.
  void showCommentsBottomSheet(int postId) {
    // First, fetch the comments for the post.
    fetchComments(postId);
    Get.bottomSheet(
      Obx(() {
        return Container(
          height: Get.height * 0.75,
          decoration: BoxDecoration(
            color: appTheme.gray900,
            borderRadius: BorderRadius.vertical(top: Radius.circular(16.h)),
          ),
          child: Column(
            children: [
              Container(
                height: 4.h,
                width: 40.h,
                decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(8.h)),
              ),
              Padding(
                padding: EdgeInsets.all(8.h),
                child: Text(
                  "Comments",
                  style: TextStyle(
                    fontSize: 16.h,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Expanded(
                child: comments.isEmpty
                    ? Center(child: Text("No comments yet."))
                    : ListView.separated(
                        separatorBuilder: (context, index) => Divider(),
                        reverse: false,
                        itemCount: comments.length,
                        itemBuilder: (context, index) {
                          final comment = comments[index];
                          return ListTile(
                            title: Text(
                              comment.comment,
                              style: CustomTextStyles.titleLarge20,
                            ),
                            subtitle: Text(
                              "${comment.createdAt.hour}:${comment.createdAt.minute.toString().padLeft(2, '0')}",
                              style: CustomTextStyles.bodyMediumGray500,
                            ),
                          );
                        },
                      ),
              ),
              Padding(
                padding: EdgeInsets.all(8.h),
                child: Row(
                  children: [
                    Expanded(
                        child: CustomTextFormField(
                      controller: commentController,
                      hintText: "Add a comment...",
                    )),
                    SizedBox(width: 8.h),
                    CustomImageView(
                      imagePath: ImageConstant.sendIconimg,
                      onTap: () => addComment(postId),
                      width: 40.h,
                    )
                  ],
                ),
              ),
            ],
          ),
        );
      }),
      backgroundColor: Colors.white,
      isScrollControlled: true,
    );
  }

  @override
  void onClose() {
    searchBarController.dispose();
    super.onClose();
  }
}
