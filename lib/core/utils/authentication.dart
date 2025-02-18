import 'dart:convert';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:volco/core/utils/pref_utils.dart';
import 'package:volco/core/utils/project_constants.dart';
import 'package:volco/core/utils/supabase_handler.dart';
import 'package:volco/routes/app_routes.dart';
import 'package:google_sign_in/google_sign_in.dart';

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

  Future<void> _initializeAuthState() async {
    // Ensure PrefUtils is initialized
    await PrefUtils.instance.init();

    // Retrieve stored session JSON string
    String? savedSessionJson = PrefUtils.instance.getSupabaseAuthSession();
    if (savedSessionJson != null && savedSessionJson.isNotEmpty) {
      try {
        // Decode the JSON and set the session
        final sessionMap = jsonDecode(savedSessionJson);
        final response = await supabaseClient.auth.setSession(sessionMap);
        currentUser.value = response.user;
        isLoggedIn.value = currentUser.value != null;
      } catch (e) {
        print("Error recovering session: $e");
      }
    } else {
      final user = supabaseClient.auth.currentUser;
      isLoggedIn.value = user != null;
      currentUser.value = user;
    }

    print('Current user on initialization: ${currentUser.value}');

    // Listen to authentication state changes
    supabaseClient.auth.onAuthStateChange.listen((event) async {
      currentUser.value = event.session?.user;
      isLoggedIn.value = currentUser.value != null;
      if (currentUser.value != null && event.session != null) {
        // Store the entire session as JSON
        await PrefUtils.instance.setSupabaseAuthSession(jsonEncode(event.session!.toJson()));
      } else {
        await PrefUtils.instance.clearPreferencesData();
      }
    });
  }

  Future<bool> sendOTPonEmail(String email) async {
    try {
      await supabaseClient.auth.signInWithOtp(
        email: email,
        emailRedirectTo: 'io.supabase.flutterquickstart://login-callback/',
      );
      Get.snackbar("Success", "OTP sent to your email!");
      return true;
    } catch (e) {
      print("Error sending OTP: $e");
      Get.snackbar("Error", "Failed to send OTP: $e");
      return false;
    }
  }

  Future<bool> verifyOTP(String email, String otp) async {
    try {
      final response = await supabaseClient.auth.verifyOTP(
        email: email,
        token: otp,
        type: OtpType.email,
      );
      if (response.session != null) {
        currentUser.value = response.session!.user;
        isLoggedIn.value = currentUser.value != null;
        Get.snackbar("Success", "Logged in successfully!");
        return true;
      }
      return false;
    } catch (e) {
      print("Error verifying OTP: $e");
      Get.snackbar("Error", "Failed to verify OTP: $e");
      return false;
    }
  }

  Future<UserResponse> resetPassword(String newPassword) async {
    final response = await supabaseClient.auth.updateUser(
      UserAttributes(password: newPassword),
    );
    return response;
  }

  Future<void> signInWithGoogle() async {
    try {
      final GoogleSignIn googleSignIn = GoogleSignIn(
        clientId: IOS_CLIENT_ID,
        serverClientId: WEB_CLIENT_ID,
      );
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
          await PrefUtils.instance.setSupabaseAuthSession(jsonEncode(response.session!.toJson()));
          await postLoginCheck(user.id);
        }
      } else {
        throw Exception("Failed to sign in with Google.");
      }
    } catch (e) {
      Get.snackbar("Error", "Google Sign-In failed: $e");
    }
  }

  Future<void> postLoginCheck(String userId) async {
    final userExists = await _isUserInDatabase(userId);
    final allFieldsFilled = userExists ? await checkAllFieldsFilled(userId) : false;
    if (userExists && allFieldsFilled) {
      Get.offAllNamed(AppRoutes.homeScreen);
    } else {
      Get.offAllNamed(AppRoutes.userDetailsScreen);
    }
  }

  Future<bool> _isUserInDatabase(String userId) async {
    try {
      final response = await supabaseClient.from('profiles').select().eq('id', userId);
      return response.isNotEmpty;
    } catch (e) {
      print("Error checking user existence: $e");
      return false;
    }
  }

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

  Future<void> logout() async {
    try {
      await clearOAuthSessions();
      await supabaseClient.auth.signOut();
      await PrefUtils.instance.clearPreferencesData();
      Get.offAllNamed(AppRoutes.letsYouInScreen);
    } catch (e) {
      Get.snackbar("Error", "Logout failed: $e");
    }
  }

  Future<void> clearOAuthSessions() async {
    await GoogleSignIn().signOut();
  }
}
