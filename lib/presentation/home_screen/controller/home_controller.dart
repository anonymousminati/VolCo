import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:volco/core/app_export.dart';
import 'package:volco/presentation/home_screen/models/home_model.dart';
import 'package:volco/presentation/home_screen/models/home_screen_initial_model.dart';

class HomeController extends GetxController {
  TextEditingController searchBarController = TextEditingController();
  Rx<HomeModel> homeModelObj = HomeModel().obs;
  Rx<HomeScreenInitialModel> homeScreenInitialModelObj =
      HomeScreenInitialModel().obs;

  RxString avatarUrl = ''.obs; // RxString for reactive updates

  @override
  void onReady() {
    super.onReady();
    _fetchAvatarUrl(); // Fetch avatar URL when the controller is ready
  }

  void _fetchAvatarUrl() async {
    try {
      User? user  =await SupabaseService().getUserData();
      if (user != null) {

        avatarUrl.value = user.userMetadata?['avatar_url'] ; // Update reactive value
      }
    } catch (error) {
      print('Error fetching avatar URL: $error');
    }
  }

  @override
  void onClose() {
    super.onClose();
    searchBarController.dispose();
  }
}
