import 'dart:ffi';

import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:volco/core/app_export.dart';
import 'package:volco/presentation/splash_screen/models/splash_model.dart';
import 'package:volco/routes/app_routes.dart';
import 'package:volco/core/utils/authentication.dart';


class SplashController extends GetxController {
  Rx<SplashModel> splashModelObj = SplashModel().obs;
  final authenticationController = Get.put(AuthenticationGetXController());

  @override
  void onInit() {
    super.onInit();
    _listenForAuthChanges();
  }

  @override
  void onReady() {
    Future.delayed(const Duration(milliseconds: 3000), () async {
      bool isFirstTimeUser = await isFirstTimeUserCheck();
      if (isFirstTimeUser) {
        Get.offNamed(AppRoutes.welcomeScreen);
      } else {
        await _checkAuthenticationStatus();
      }
    });
  }
  Future<void> _checkAuthenticationStatus() async {
    // Check if a user session exists and redirect accordingly
    if (authenticationController.session.value.auth.currentUser != null) {
      // User is authenticated, redirect to home screen
      Get.offNamed(AppRoutes.homeScreen);
    } else {
      // No user session, redirect to the "Let's You In" screen
      Get.offNamed(AppRoutes.letsYouInScreen);
    }
  }

  void _listenForAuthChanges() {
    // Listen for auth state changes to handle logouts
    authenticationController.session.value.auth.onAuthStateChange.listen((data) {
      if (data.event == AuthChangeEvent.signedOut) {
        // Redirect to login screen on logout
        Get.offAllNamed(AppRoutes.letsYouInScreen);
      } else if (data.event == AuthChangeEvent.signedIn) {
        // Redirect to home screen on login
        Get.offAllNamed(AppRoutes.homeScreen);
      }
    });
  }

  Future<bool> isFirstTimeUserCheck() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isFirstTime = prefs.getBool('isFirstTime') ?? true;

    if (isFirstTime) {
      prefs.setBool('isFirstTime', false);
    }

    return isFirstTime;
  }


}
