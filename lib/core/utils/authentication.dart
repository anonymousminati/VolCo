import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:volco/core/utils/project_constants.dart';
import 'package:volco/routes/app_routes.dart';

class AuthenticationGetXController extends GetxController {
  var session = Supabase.instance.client.obs;
}

class AuthService extends GetxController {
  final SupabaseClient _supabaseClient = Supabase.instance.client;

  /// Method to check if the user exists in the database
  Future<bool> _isUserInDatabase(String userId) async {
    try {
      final response =
          await _supabaseClient.from('profiles').select().eq('id', userId);

      return response.isNotEmpty;
    } catch (e) {
      print('Error checking user in database: ${e}');
      return false;
    }
  }

  /// Method to add a new user to the database
  Future<void> addUserToDatabase(
      String userId, Map<String, dynamic> userDetails) async {
    try {
      final response = await _supabaseClient.from('profiles').insert({
        'id': userId,
        ...userDetails, // include additional user details like name, email, etc.
      });

      if (response.error != null) {
        throw Exception(
            "Error adding user to database: ${response.error?.message}");
      }
    } catch (e) {
      print('Error adding user to database: ${e}');
      throw Exception(e);
    }
  }

  /// Post-login check
  Future<void> _postLoginCheck(String userId) async {
    bool userExists = await _isUserInDatabase(userId);

    if (userExists) {
      // User exists, redirect to the home screen
      Get.offAllNamed(AppRoutes.homeScreen);
    } else {
      // User does not exist, redirect to user details screen
      Get.offNamed(AppRoutes.userDetailsScreen);
    }
  }

  /// Sign in or sign up with Google
  Future<void> signInWithGoogle() async {
    try {
      final GoogleSignIn googleSignIn =
          GoogleSignIn(clientId: IOS_CLIENT_ID, serverClientId: WEB_CLIENT_ID);
      final googleUser = await googleSignIn.signIn();
      final googleAuth = await googleUser!.authentication;
      final accessToken = googleAuth.accessToken;
      final idToken = googleAuth.idToken;
      print(1);
      final response = await _supabaseClient.auth.signInWithIdToken(
        provider: OAuthProvider.google,
        accessToken: accessToken,
        idToken: idToken.toString(),
      );
      print(2);
      if (response != null) {
        print(3);
        final user = _supabaseClient.auth.currentUser;
        if (user != null) {
          await _postLoginCheck(user.id);
        }
      } else {
        print("res: Failed to sign in with Google: ${response}");
        Get.snackbar("Error", "Failed to sign in with Google: ${response}");
      }
    } catch (e) {
      print('catch Error signing in with Google: $e');
      Get.snackbar("Error", "Failed to sign in with Google: $e");
    }
  }

  /// Sign in or sign up with Facebook
  Future<void> signInWithFacebook() async {
    try {
      final result = await _supabaseClient.auth.signInWithOAuth(
        OAuthProvider.facebook,
        // redirectTo: "your-redirect-url", // Replace with your redirect URL
      );

      if (result) {
        final user = _supabaseClient.auth.currentUser;
        if (user != null) {
          await _postLoginCheck(user.id);
        }
      }
    } catch (e) {
      Get.snackbar("Error", "Failed to sign in with Facebook: $e");
    }
  }

  // /// Sign in or sign up with Apple
  // Future<void> signInWithApple() async {
  //   try {
  //     final response = await _supabaseClient.auth.signInWithOAuth(
  //       OAuthProvider.apple,
  //     );
  //
  //     final user = response.user;
  //     if (user != null) {
  //       bool userExists = await _isUserInDatabase(user.id);
  //
  //       if (userExists) {
  //         // User exists, redirect to the home screen
  //         Get.offAllNamed(AppRoutes.homeScreen);
  //       } else {
  //         // User does not exist, redirect to user details screen
  //         Get.offNamed(AppRoutes.userDetailsScreen);
  //       }
  //     }
  //   } catch (e) {
  //     Get.snackbar("Error", e.toString());
  //   }
  // }
  /// Method to log out the user
  Future<void> logout() async {
    try {
      // Sign out from Supabase
      await Supabase.instance.client.auth.signOut();

      // Optionally, clear the user's GoogleSignIn session
      GoogleSignIn().signOut();

      // Redirect to the login screen or initial screen
      Get.offAllNamed(AppRoutes
          .letsYouInScreen); // Replace with your login or splash screen route
    } catch (e) {
      Get.snackbar("Error", "Failed to logout: $e");
    }
  }

  /// Call this method after the user fills in the details on the user details screen
  Future<void> saveUserDetails(
      String userId, Map<String, dynamic> userDetails) async {
    try {
      await addUserToDatabase(userId, userDetails);
      Get.offAllNamed(AppRoutes.homeScreen);
    } catch (e) {
      Get.snackbar("Error", "Failed to save user details: $e");
    }
  }
}
