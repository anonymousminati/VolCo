import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:volco/core/app_export.dart';
import 'package:volco/presentation/home_screen/models/home_model.dart';
import 'package:volco/presentation/home_screen/models/home_screen_initial_model.dart';

class HomeController extends GetxController {
  TextEditingController searchBarController = TextEditingController();
  Rx<HomeModel> homeModelObj = HomeModel().obs;
  Rx<HomeScreenInitialModel> homeScreenInitialModelObj =
      HomeScreenInitialModel().obs;
  @override
  void onClose() {
    super.onClose();
    searchBarController.dispose();
  }
}
