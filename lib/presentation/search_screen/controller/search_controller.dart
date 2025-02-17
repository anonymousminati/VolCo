import 'dart:ffi';
import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:volco/core/utils/image_constant.dart';
import 'package:volco/core/utils/supabase_handler.dart';
import 'package:volco/presentation/create_event_catogory_screen/models/create_event_catogory_model.dart';
import 'package:volco/presentation/user_details_screen/models/user_details_model.dart';
import 'package:volco/routes/app_routes.dart';
import 'package:volco/widgets/event_card_widget.dart';
import 'package:volco/widgets/label_widget.dart';

class SearchEventController extends GetxController {
  // Text controllers

  final SupabaseClient supabaseClient = SupabaseHandler().supabaseClient;
  final SupabaseService supabaseService = SupabaseService();

  // Search bar controller
  final searchBarController = TextEditingController();

  // Reactive variables
  RxList<LabelWidget> eventCategoriesLabelList = <LabelWidget>[].obs;
  RxList<EventCardWidget> eventList = <EventCardWidget>[].obs;
  RxString selectedCategory = "All".obs; // Default category
  RxString avatarUrl = ''.obs;

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
  @override
  void onReady() {
    super.onReady();
    _fetchAvatarUrl();
    shuffleAndPrintColors();
    fetchOngoingUpcomingEvents(); // Fetch events on load
    subscribeToEventChanges(); // Listen for real-time updates
    subscribeToCategoryChanges();
    initializeEventCategories();
    searchBarController.addListener(() {
      fetchOngoingUpcomingEvents();  // Fetch events on search text change
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

  /// **Fetches ongoing and upcoming events**
  /// Fetches ongoing and upcoming events based on search query and selected category
  Future<void> fetchOngoingUpcomingEvents() async {
    try {
      String searchQuery = searchBarController.text.trim();

      // Call Supabase stored function
      final response = await supabaseClient.rpc(
        'get_events_by_search',
        params: {
          'category': selectedCategory.value,
          'search_query': searchQuery,
        },
      );

      // Ensure response is a list of maps
      List<Map<String, dynamic>> events = List<Map<String, dynamic>>.from(response ?? []);
      // Clear and update the event list
      eventList.assignAll(events.map((event) => EventCardWidget(
        eventName: event['event_name'],
        imageUrl: event['image_url'] ?? '',
        eventDate: event['event_date'].toString(),
        eventTime: event['event_time'].toString(),
        volunteerCount: int.parse(event['volunteer_requirements']) ?? 0,
        location: event['location'],
        joinText: "Wants Join",
        onTap: () {
          print("${event['event_name']} clicked!");
        },
        onJoinTap: () {
          print("User wants to sign up for ${event['event_name']}!");

          Get.offAllNamed(AppRoutes.eventDescriptionScreen,arguments: {
            "eventCreatedId":event["event_id"],
            "eventCategory":event["activity_type"],
            "isForRegister":true,

          });
        },
      )));

    } catch (e) {
      print("Error fetching events: $e");
    }
  }

  void subscribeToEventChanges() {
    supabaseClient
        .from('events')
        .stream(primaryKey: ['event_id'])
        .listen((_) {
      fetchOngoingUpcomingEvents();
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

    // Add fetched categories
    eventCategoriesLabelList.addAll(response.map((category) => LabelWidget(
      labelText: category['catogory_name'],
      color: Color(0xFFF2E0A6),
      onTap: () => updateSelectedCategory(category['catogory_name']),
    )));
  }

  void updateSelectedCategory(String category) {
    print("Selected Category: $category");
    selectedCategory.value = category; // Update the selected category

    // Update the UI to reflect the selected category
    eventCategoriesLabelList.refresh();
print("eventCategoriesLabelList refreshed");
    // Fetch events for the selected category
    fetchOngoingUpcomingEvents();
  }


  void subscribeToCategoryChanges() {
    supabaseClient
        .from('event_catogories')
        .stream(primaryKey: ['id'])
        .listen((updatedData) {
      print("Categories Updated: $updatedData");

      // Refresh category list
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
    searchBarController.dispose();
    super.onClose();
  }
}
