import 'dart:ffi';
import 'dart:io';
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

  @override
  void onReady() {
    super.onReady();
    _fetchAvatarUrl(); // Fetch avatar URL when the controller is ready
    _initializeEventCategories(); // Initialize event categories

    _subscribeToCategoryChanges(); // Subscribe to category changes
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

  Future<void> _initializeEventCategories() async {
    List<Map<String, dynamic>> response = await supabaseService.fetchCatogories();
    supabaseService.fetchCatogories();
    for (var category in response) {
      eventCategories.add(CreateEventCategoryModel(
        categoryName: category['catogory_name'],
        imageIcon: category['catogory_image'],
        redirectString: category['catogory_redirect'],
      ));
    }

  }

  void _subscribeToCategoryChanges() {
    supabaseClient
        .from('event_catogories')// Replace 'categories' with your actual table name
        .stream(primaryKey: ['id']) // Track changes based on 'id'
        .listen((List<Map<String, dynamic>> updatedData) {
      print("Categories Updated: $updatedData");

      // Update eventCategories list
      eventCategories.assignAll(updatedData.map((category) => CreateEventCategoryModel(
        categoryName: category['catogory_name'],
        imageIcon: category['catogory_image'],
        redirectString: category['catogory_redirect'],
      )).toList());
    });
  }


  @override
  void onClose() {
    // Dispose of text controllers

    super.onClose();
  }
}
