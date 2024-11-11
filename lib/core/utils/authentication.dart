import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:volco/core/utils/project_constants.dart';
class AuthenticationGetXController extends GetxController{
  var session = Supabase.instance.client.obs;

}


class AuthService extends GetxController {
  final SupabaseClient _supabaseClient = Supabase.instance.client;

  /// Sign in or sign up with Google
  Future<AuthResponse> signInWithGoogle() async {
    const webClientId = WEB_CLIENT_ID;

    /// TODO: update the iOS client ID with your own.
    ///
    /// iOS Client ID that you registered with Google Cloud.
    const iosClientId = IOS_CLIENT_ID;

    // Google sign in on Android will work without providing the Android
    // Client ID registered on Google Cloud.

    final GoogleSignIn googleSignIn = GoogleSignIn(
      clientId: iosClientId,
      serverClientId: webClientId,
    );
    final googleUser = await googleSignIn.signIn();
    final googleAuth = await googleUser!.authentication;
    final accessToken = googleAuth.accessToken;
    final idToken = googleAuth.idToken;

    if (accessToken == null) {
      throw 'No Access Token found.';
    }
    if (idToken == null) {
      throw 'No ID Token found.';
    }

    return _supabaseClient.auth.signInWithIdToken(
      provider: OAuthProvider.google,
      idToken: idToken,
      accessToken: accessToken,
    );
  }

  // /// Sign in or sign up with Facebook
  Future<void> signInWithFacebook() async {
    try {
      final response = await _supabaseClient.auth.signInWithOAuth(
        OAuthProvider.facebook
      );

      if (response != null) {

        // User is logged in
        Get.snackbar("Login Successful", "You are logged in with Facebook.");
      } else {
        // User account creation failed
        Get.snackbar("Login Failed", "Unable to login with Facebook.");
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
    }
  }
  //
  // /// Sign in or sign up with Apple
  Future<void> signInWithApple() async {
    try {
      final response = await _supabaseClient.auth.signInWithOAuth(
        OAuthProvider.apple,
      );

      if (response != null) {
        // User is logged in
        Get.snackbar("Login Successful", "You are logged in with Apple.");
      } else {
        // User account creation failed
        Get.snackbar("Login Failed", "Unable to login with Apple.");
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
    }
  }
  //
  // /// Sign in with email and password
  // Future<void> signInWithEmail(String email, String password) async {
  //   try {
  //     final response = await _supabaseClient.auth.signInWithPassword(
  //       email: email,
  //       password: password,
  //     );
  //
  //     if (response.session != null) {
  //       Get.snackbar("Login Successful", "You are logged in.");
  //     } else {
  //       Get.snackbar("Login Failed", "Invalid email or password.");
  //     }
  //   } catch (e) {
  //     Get.snackbar("Error", e.toString());
  //   }
  // }
  //
  // /// Sign up with email and password
  // Future<void> signUpWithEmail(String email, String password) async {
  //   try {
  //     final response = await _supabaseClient.auth.signUp(
  //       email: email,
  //       password: password,
  //     );
  //
  //     if (response.user != null) {
  //       Get.snackbar("Account Created", "Please check your email for confirmation.");
  //     } else {
  //       Get.snackbar("Sign Up Failed", "Unable to create an account.");
  //     }
  //   } catch (e) {
  //     Get.snackbar("Error", e.toString());
  //   }
  // }
}


