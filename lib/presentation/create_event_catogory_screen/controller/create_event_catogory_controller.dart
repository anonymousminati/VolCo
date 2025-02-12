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

class CreateEventCatogoryController extends GetxController {
  // Text controllers

  final SupabaseClient supabaseClient = SupabaseHandler().supabaseClient;
  final SupabaseService supabaseService = SupabaseService();

  RxString avatarUrl = ''.obs; // RxString for reactive updates
  RxList<CreateEventCategoryModel> eventCategories =
      <CreateEventCategoryModel>[].obs;
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
    fetchAvatarUrl(); // Fetch avatar URL when the controller is ready
    initializeEventCategories(); // Initialize event categories
    shuffleAndPrintColors();
    subscribeToCategoryChanges(); // Subscribe to category changes
  }

  void fetchAvatarUrl() async {
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

  Future<void> initializeEventCategories() async {
    List<Map<String, dynamic>> response =
        await supabaseService.fetchCatogories();
    supabaseService.fetchCatogories();
    eventCategories.clear();
    for (var category in response) {
      eventCategories.add(CreateEventCategoryModel(
        categoryName: category['catogory_name'],
        imageIcon: category['catogory_image'],
        redirectString: category['catogory_redirect'],
      ));
    }
  }

  void subscribeToCategoryChanges() {
    supabaseClient
        .from(
            'event_catogories') // Replace 'categories' with your actual table name
        .stream(primaryKey: ['id']) // Track changes based on 'id'
        .listen((List<Map<String, dynamic>> updatedData) {
      print("Categories Updated: $updatedData");

      // Update eventCategories list
      eventCategories.clear();
      eventCategories.assignAll(updatedData
          .map((category) => CreateEventCategoryModel(
                categoryName: category['catogory_name'],
                imageIcon: category['catogory_image'],
                redirectString: category['catogory_redirect'],
              ))
          .toList());


    });
  }

  @override
  void onClose() {
    // Dispose of text controllers

    super.onClose();
  }
}
