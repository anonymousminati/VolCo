import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:volco/core/utils/supabase_handler.dart';
import 'package:volco/routes/app_routes.dart';
import 'package:volco/widgets/event_card_widget.dart';
import 'package:volco/widgets/label_widget.dart';

class SavedController extends GetxController {
  final SupabaseClient supabaseClient = SupabaseHandler().supabaseClient;
  final SupabaseService supabaseService = SupabaseService();

  // Search bar controller (if needed for filtering favorites)

  // Reactive variables
  RxList<LabelWidget> eventCategoriesLabelList = <LabelWidget>[].obs;
  RxList<EventCardWidget> eventList = <EventCardWidget>[].obs;
  RxString selectedCategory = "All".obs;
  RxString avatarUrl = ''.obs;
  RxSet<int> favoriteEventIds = <int>{}.obs; // Store favorite event IDs

  @override
  void onReady() {
    super.onReady();
    _fetchAvatarUrl();
    fetchFavoriteEventIds();
    fetchFavoriteEventsList();
    subscribeToEventChanges();
    subscribeToCategoryChanges();
    initializeEventCategories();

  }

  Future<void> _fetchAvatarUrl() async {
    try {
      User? user = await supabaseService.getUserData();
      if (user != null) {
        avatarUrl.value = user.userMetadata?['avatar_url'] ?? "";
      }
    } catch (error) {
      print('Error fetching avatar URL: $error');
    }
  }

  /// Fetch favorite event IDs using a separate RPC function if needed.
  Future<void> fetchFavoriteEventIds() async {
    try {
      final String? userId = await supabaseService.getUserId(); // Await the user ID
      if (userId == null) {
        print("User ID is null");
        return;
      }
      final response = await supabaseClient.rpc('get_favorite_events', params: {
        'user_uuid': userId,
      });
      print("fav id res :$response");
      List<int> favIds = (response as List<dynamic>).map((event) => event['event_id'] as int).toList();
      print("Favorite Event IDs: $favIds");
      favoriteEventIds.assignAll(favIds);
    } catch (e) {
      print("Error fetching favorite event IDs: $e");
    }
  }

  /// Fetch favorite events with details using the new SQL function.
  Future<void> fetchFavoriteEventsList() async {
    try {
      final String? userId = await supabaseService.getUserId(); // Await the user ID
      if (userId == null) {
        print("User ID is null");
        return;
      }
      // Optionally, pass search criteria and category if needed:
      final response = await supabaseClient.rpc('get_favorite_events', params: {
        'user_uuid': userId,

      }).select();

      // List<Map<String, dynamic>> events = List<Map<String, dynamic>>.from(response ?? []);

      // Build EventCardWidgets for each event and mark them as favorites.
      eventList.assignAll(response.map((event) => EventCardWidget(
        eventName: event['event_name'],
        imageUrl: event['image_url'] ?? '',
        eventDate: event['event_date'].toString(),
        eventTime: event['event_time'].toString(),
        volunteerCount: int.tryParse(event['volunteer_requirements'] ?? '0') ?? 0,
        location: event['location'],
        joinText: "Wants Join",
        onTap: () {
          print("${event['event_name']} clicked!");
        },
        onJoinTap: () {
          print("User wants to sign up for ${event['event_name']}!");
          Get.toNamed(AppRoutes.eventDescriptionScreen, arguments: {
            "eventCreatedId": event["event_id"],
            "eventCategory": event["activity_type"],
            "isForRegister": true,
          });
        },
        onFavTap: () {
          toggleFavorite(event['event_id']);
        },

        isFavorite: favoriteEventIds.contains(event['event_id']), // These events are favorites.
      )).toList());
    } catch (e) {
      print("Error fetching favorite events list: $e");
    }
  }

  /// Toggle favorite status for an event.
  Future<void> toggleFavorite(int eventId) async {
    try {
      print(1);
      final String? userId = await supabaseService.getUserId(); // Await the user ID
      if (userId == null) {
        print("User ID is null");
        return;
      }
      print(2);

      if (favoriteEventIds.contains(eventId)) {
        // Remove favorite
        print(3);

        print("Removing favorite for event ID: $eventId");
        await supabaseClient
            .from('favorites')
            .delete()
            .match({'user_id': userId, 'event_id': eventId});
        print(5);

        favoriteEventIds.remove(eventId);
      } else {
        // Add favorite
        print("Adding favorite for event ID: $eventId");
        print(6);

        await supabaseClient.from('favorites').insert({
          'user_id': userId,
          'event_id': eventId,
        });
        print(7);

        favoriteEventIds.add(eventId);
      }
      favoriteEventIds.refresh();
      // Re-fetch favorite events list after update.
      await fetchFavoriteEventsList();
    } catch (e) {
      print("Error toggling favorite: $e");
    }
  }

  void subscribeToEventChanges() {
    supabaseClient
        .from('events')
        .stream(primaryKey: ['event_id'])
        .listen((_) {
      fetchFavoriteEventsList();
    });
    supabaseClient
        .from('favorites')
        .stream(primaryKey: ['id'])
        .listen((_) {
      fetchFavoriteEventsList();
    });
  }

  Future<void> initializeEventCategories() async {
    eventCategoriesLabelList.clear();

    // Add "All" category manually
    eventCategoriesLabelList.add(LabelWidget(
      labelText: "All",
      color: Color(0xFFF2E0A6),
      onTap: () => updateSelectedCategory("All"),
    ));

    // Fetch categories from the database
    List<Map<String, dynamic>> response = await supabaseService.fetchCatogories();
    eventCategoriesLabelList.addAll(response.map((category) => LabelWidget(
      labelText: category['catogory_name'],
      color: Color(0xFFF2E0A6),
      onTap: () => updateSelectedCategory(category['catogory_name']),
    )));
  }

  void updateSelectedCategory(String category) {
    print("Selected Category: $category");
    selectedCategory.value = category;
    eventCategoriesLabelList.refresh();
    fetchFavoriteEventsList();
  }

  void subscribeToCategoryChanges() {
    supabaseClient
        .from('event_catogories')
        .stream(primaryKey: ['id'])
        .listen((updatedData) {
      print("Categories Updated: $updatedData");

      List<LabelWidget> updatedCategories = [
        LabelWidget(
          labelText: "All",
          color: Color(0xFFF2E0A6),
          onTap: () => updateSelectedCategory("All"),
        )
      ];

      updatedCategories.addAll(updatedData.map((category) => LabelWidget(
        labelText: category['catogory_name'],
        color: Color(0xFFF2E0A6),
        onTap: () => updateSelectedCategory(category['catogory_name']),
      )));

      eventCategoriesLabelList.assignAll(updatedCategories);
    });
  }

  @override
  void onClose() {
    super.onClose();
  }
}
