import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:volco/core/app_export.dart';
import 'package:volco/presentation/splash_screen/models/splash_model.dart';
import 'package:volco/routes/app_routes.dart';
import 'package:volco/core/utils/authentication.dart';

class SplashController extends GetxController {
  Rx<SplashModel> splashModelObj = SplashModel().obs;
  final authenticationController = AuthController.instance;

  @override
  void onReady() {
    super.onReady();
    Future.delayed(const Duration(milliseconds: 3000), () async {
      bool isFirstTimeUser = await _isFirstTimeUserCheck();
      if (isFirstTimeUser) {
        // Redirect to Welcome Screen for first-time users
        Get.offNamed(AppRoutes.welcomeScreen);
      } else {
        // Check authentication status and handle redirection
        await _checkAuthenticationStatus();
      }
    });
  }

  Future<void> _checkAuthenticationStatus() async {
    final supabaseHandler = SupabaseHandler();
    final supabaseClient = supabaseHandler.supabaseClient;
    var currentUser = supabaseClient.auth.currentUser;
    print("currentUser: $currentUser");

    String savedSession = PrefUtils().getSupabaseAuthSession();
    if (savedSession.isNotEmpty) {
      // If the session exists, try to set the session and get the user details
      final response = await supabaseClient.auth.setSession(savedSession);
      currentUser = response.user;
    }


    print("currentUser: $currentUser");
    if (currentUser != null) {
      // Check if user has completed their profile
      final bool allFieldsFilled =  await authenticationController.checkAllFieldsFilled(currentUser.id);
      print("allFieldsFilled: $allFieldsFilled ");
      if (allFieldsFilled) {
        // User profile is complete, redirect to Home Screen
        Get.offAllNamed(AppRoutes.homeScreen);
      } else {
        // User profile is incomplete, redirect to User Details Screen
        Get.offAllNamed(AppRoutes.userDetailsScreen);
      }
    } else {
      // User is not logged in, redirect to Let's You In Screen
      Get.offAllNamed(AppRoutes.letsYouInScreen);
    }
  }

  Future<bool> _isFirstTimeUserCheck() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isFirstTime = prefs.getBool('isFirstTime') ?? true;

    if (isFirstTime) {
      // Mark the user as not a first-time user
      prefs.setBool('isFirstTime', false);
    }

    return isFirstTime;
  }
}
