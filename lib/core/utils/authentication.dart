import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:volco/core/utils/pref_utils.dart';
import 'package:volco/core/utils/project_constants.dart';
import 'package:volco/core/utils/supabase_handler.dart';
import 'package:volco/routes/app_routes.dart';
//create a middleware which will check for authentication and redirect user to the appropriate screen
class AuthMiddleware extends GetMiddleware {
  final SupabaseClient supabaseClient = SupabaseHandler().supabaseClient;

  @override
  RouteSettings? redirect(String? route) {
    final isLoggedIn =supabaseClient.auth.currentUser != null;
    return isLoggedIn ? null : const RouteSettings(name: AppRoutes.letsYouInScreen);
  }
}


class AuthController extends GetxController {
  static AuthController get instance => Get.find<AuthController>();

  final SupabaseClient supabaseClient = SupabaseHandler().supabaseClient;
  final RxBool isLoggedIn = false.obs;
  final Rx<User?> currentUser = Rx<User?>(null);

  @override
  void onInit() {
    super.onInit();
    _initializeAuthState();
  }


  /// Initialize authentication state
  void _initializeAuthState() async {
    // Check for stored session in SharedPreferences
    String savedSession = PrefUtils().getSupabaseAuthSession();
    if (savedSession.isNotEmpty) {
      // If a session exists, restore the user from the session
      final response = await supabaseClient.auth.setSession(savedSession);
      currentUser.value = response.user;
      isLoggedIn.value = currentUser.value != null;
    } else {
      final user = supabaseClient.auth.currentUser;
      isLoggedIn.value = user != null;
      currentUser.value = user;
    }

    print('Current user on initialization: ${currentUser.value}'); // Check session

    // Listen to authentication state changes
    supabaseClient.auth.onAuthStateChange.listen((event) async {
      currentUser.value = event.session?.user;
      isLoggedIn.value = currentUser.value != null;
      String? refreshtoken = await event.session?.refreshToken;
      // Save the session to SharedPreferences
      if (currentUser.value != null) {
        PrefUtils().setSupabaseAuthSession(refreshtoken!);
      } else {
        PrefUtils().clearPreferencesData(); // Clear session if user logs out
      }
    });
  }

  /// Send OTP to the user's email
  Future<bool> sendOTPonEmail(String email) async {
    try {
      await supabaseClient.auth.signInWithOtp(
        email: email,
        emailRedirectTo: 'io.supabase.flutterquickstart://login-callback/', // Replace with your app's deep link or redirect URL
      );

      Get.snackbar("Success", "OTP sent to your email!");
      return  true;
    } catch (e) {
      print("Error sending OTP: $e");
      Get.snackbar("Error", "Failed to send OTP: $e");
      return false;
    }
  }

  /// Verify OTP and log the user in
  Future<bool> verifyOTP(String email, String otp) async {
    try {
      final response = await supabaseClient.auth.verifyOTP(
        email: email,
        token: otp,
        type: OtpType.email, // Or use `OtpType.signup` or `OtpType.recovery` as needed
      );

      if (response.session != null) {
        final user = response.session!.user;
        currentUser.value = user;
        isLoggedIn.value = user != null;
        Get.snackbar("Success", "Logged in successfully!");
        postLoginCheck(user.id);
        return true;
      }
      return false;
    } catch (e) {
      print("Error verifying OTP: $e");
      Get.snackbar("Error", "Failed to verify OTP: $e");
      return false;
    }
  }


  /// Method to log in via Google
  Future<void> signInWithGoogle() async {
    try {
      final GoogleSignIn googleSignIn = GoogleSignIn(clientId: IOS_CLIENT_ID, serverClientId: WEB_CLIENT_ID);
      final googleUser = await googleSignIn.signIn();
      final googleAuth = await googleUser?.authentication;
      final accessToken = googleAuth?.accessToken;
      final idToken = googleAuth?.idToken;

      final response = await supabaseClient.auth.signInWithIdToken(
        provider: OAuthProvider.google,
        accessToken: accessToken,
        idToken: idToken.toString(),
      );

      if (response.session != null) {
        final user = supabaseClient.auth.currentUser;
        if (user != null) {
          // Store session in SharedPreferences
          await PrefUtils().setSupabaseAuthSession(response.session!.refreshToken!);
          await postLoginCheck(user.id);
        }
      } else {
        throw Exception("Failed to sign in with Google.");
      }
    } catch (e) {
      Get.snackbar("Error", "Google Sign-In failed: $e");
    }
  }

  /// Post-login check to route users
  Future<void> postLoginCheck(String userId) async {
    final userExists = await _isUserInDatabase(userId);
    final allFieldsFilled = userExists ? await checkAllFieldsFilled(userId) : false;
    if (userExists && allFieldsFilled) {
      Get.offAllNamed(AppRoutes.homeScreen);
    } else {
      Get.offAllNamed(AppRoutes.userDetailsScreen);
    }
  }

  /// Check if user exists in the database
  Future<bool> _isUserInDatabase(String userId) async {
    try {
      final response = await supabaseClient.from('profiles').select().eq('id', userId);
      return response.isNotEmpty;
    } catch (e) {
      print("Error checking user existence: $e");
      return false;
    }
  }

  /// Check if all profile fields are filled
  Future<bool> checkAllFieldsFilled(String userId) async {
    try {
      final response = await supabaseClient
          .from('profiles')
          .select('all_fields_filled')
          .eq('id', userId)
          .single();
      return response['all_fields_filled'] ?? false;
    } catch (e) {
      print("Error checking fields: $e");
      return false;
    }
  }

  /// Log out the user
  Future<void> logout() async {
    try {
      await clearOAuthSessions();
      await supabaseClient.auth.signOut();
      PrefUtils().clearPreferencesData(); // Clear session after logout
      Get.offAllNamed(AppRoutes.letsYouInScreen);
    } catch (e) {
      Get.snackbar("Error", "Logout failed: $e");
    }
  }

  /// Clear OAuth sessions
  Future<void> clearOAuthSessions() async {
    await GoogleSignIn().signOut();
    // Add other OAuth sign-out logic if needed
  }
}
