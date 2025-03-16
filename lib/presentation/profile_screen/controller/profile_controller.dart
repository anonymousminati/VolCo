import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:volco/core/utils/supabase_handler.dart';
import 'package:volco/widgets/post_media_card.dart';

import '../../create_event_screen/models/create_event_model.dart';

class ProfileController extends GetxController with GetSingleTickerProviderStateMixin  {
  // Reactive variables
  RxBool isLoading = true.obs;
  RxBool isVolunteeredEventLoading = true.obs;
  RxBool isOrganizedEventLoading = true.obs;
  RxString avatarUrl = ''.obs;
  RxString fullName = ''.obs;
  RxString email = ''.obs;
  RxString mobileNumber = ''.obs;
  RxString bio = ''.obs;
  RxString location = ''.obs;
  RxString skills = ''.obs;
  RxInt age = 0.obs;

  late TabController tabController;
  // Volunteered Events
  RxList<Map<String, dynamic>> volunteeredEvents = <Map<String, dynamic>>[].obs;
  RxList<Map<String, dynamic>> organizedEvents = <Map<String, dynamic>>[].obs;
  var userPosts = <PostCardWidget>[].obs;
  RxSet<int> likedPosts = <int>{}.obs;
  RxList<CommentModel> comments = <CommentModel>[].obs;

  final SupabaseClient supabaseClient = SupabaseHandler().supabaseClient;
  final SupabaseService supabaseService = SupabaseService();

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(length: 3, initialIndex: 0, vsync: this);

    fetchUserDetails();
    fetchVolunteeredEvents();



    tabController.addListener(() {
      if (tabController.index == 0) {
        fetchVolunteeredEvents();
      } else if (tabController.index == 1) {
        fetchUserPosts();
      } else if (tabController.index == 2) {
        fetchOrganizedEvents();
      }
    });
  }

  Future<void> fetchUserDetails() async {
    isLoading.value = true;
    try {
      final userId = await supabaseService.getUserId();
      final response = await supabaseClient
          .from('profiles')
          .select()
          .eq('id', userId!)
          .single();

      if (response != null) {
        avatarUrl.value = response['avatar_url'] ?? "";
        fullName.value = response['full_name'] ?? "NA";
        email.value = response['username'] ?? "NA";
        mobileNumber.value = response['mobile_number'] ?? "NA";
        bio.value = response['bio'] ?? "NA";
        location.value = response['location'] ?? "NA";
        skills.value = response['skills'] ?? "NA";
        age.value = response['age'] ?? 0;
      }


    } catch (e) {
      print('Error fetching user details: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchVolunteeredEvents() async {
    isVolunteeredEventLoading.value = true;
    try {
      final userId = await supabaseService.getUserId();
      print('User ID: $userId');
      final response = await supabaseClient
          .rpc('get_volunteered_events', params: {'volunteer_uuid': userId.toString()});
      print('Volunteered events: $response')  ;
      if (response != null) {
        volunteeredEvents.assignAll(List<Map<String, dynamic>>.from(response));
        volunteeredEvents.refresh();
      }
    } catch (e) {
      print('Error fetching volunteered events: $e');
    } finally {
      isVolunteeredEventLoading.value = false;
    }
  }

  Future<void> fetchOrganizedEvents() async {
    isOrganizedEventLoading.value = true;
    try {
      final userId = await supabaseService.getUserId();
      print('User ID: $userId');
      final response = await supabaseClient
          .rpc('get_organized_events', params: {'organizer_uuid': userId});
      print('Organized events: $response')  ;
      if (response != null) {
        organizedEvents.assignAll(List<Map<String, dynamic>>.from(response));
        organizedEvents.refresh();
      }
    } catch (e) {
      print('Error fetching Organized events: $e');
    } finally {
      isOrganizedEventLoading.value = false;
    }
  }

  Future<void> fetchUserPosts() async {
    try {
      String? userId = await supabaseService.getUserId();
      if (userId == null) return;

      var response = await supabaseClient
          .rpc('get_user_posts_with_counts', params: {'user_uuid': userId}).select();
      print("posts response: $response");
      userPosts.assignAll(response.map<PostCardWidget>((post) => PostCardWidget(
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
        isLiked: true,
        onLikeTap: () {
          // toggleLike(post['p_id']);
        },
        onCommentTap: () {
          // Handle comment tap (e.g., open comments popup)
        // showCommentsBottomSheet(post['p_id']);
        },
      )).toList());

      userPosts.refresh();
    } catch (error) {
      print("Error fetching user posts: $error");
    }
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

  // Subscribe to realtime changes on posts, likes, and comments tables
  void subscribeToPostsFeed() {
    // Subscribe to changes on posts table.
    supabaseClient.from('posts').stream(primaryKey: ['post_id']).listen((data) {
      print("Realtime update on posts: $data");
      fetchUserPosts();
    });

    // Subscribe to changes on likes table.
    supabaseClient.from('likes').stream(primaryKey: ['like_id']).listen((data) {
      print("Realtime update on likes: $data");
      fetchUserPosts();
    });

    // Subscribe to changes on comments table.
    supabaseClient
        .from('comments')
        .stream(primaryKey: ['comment_id']).listen((data) {
      print("Realtime update on comments: $data");
      fetchUserPosts();
    });
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


}
