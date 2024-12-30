import 'dart:io';
import 'package:get/get.dart';
import 'package:supabase/supabase.dart';
import 'package:volco/core/app_export.dart';
import 'package:volco/core/utils/project_constants.dart';

import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseHandler {
  // Singleton instance
  static final SupabaseHandler _instance = SupabaseHandler._internal();

  // Private constructor
  SupabaseHandler._internal();

  // Public factory
  factory SupabaseHandler() => _instance;

  // Supabase client
  SupabaseClient? _client;

  // Getter for Supabase client
  SupabaseClient get supabaseClient {
    if (_client == null) {
      throw Exception("SupabaseHandler is not initialized. Call initialize() first.");
    }
    return _client!;
  }

  // Initialization method
  void initialize(String projectUrl, String anonKey) {
    if (_client == null) {
      _client = SupabaseClient( projectUrl, anonKey ,
          authOptions: FlutterAuthClientOptions(authFlowType: AuthFlowType.pkce),
          realtimeClientOptions: const RealtimeClientOptions(
            eventsPerSecond: 2,
          ));
      _setAuthStateListener();
    }
  }

  // Auth state listener
  void _setAuthStateListener() {
    _client!.auth.onAuthStateChange.listen((data) {
      if (data.event == AuthChangeEvent.signedOut) {
        // Redirect to LetsYouIn when user logs out
        Get.offAllNamed(AppRoutes.letsYouInScreen);
      } else if (data.event == AuthChangeEvent.signedIn) {
        // You can handle post-login routing here
      }
    });
  }

  // Get current session
  Session? get currentSession => _client?.auth.currentSession;

  // Helper to check if user is logged in
  bool get isLoggedIn => currentSession != null;

  // Logout method
  Future<void> signOut() async {
    if (_client == null) {
      throw Exception("SupabaseHandler is not initialized. Call initialize() first.");
    }
    await _client!.auth.signOut();
  }
}

class SupabaseService {
  final SupabaseClient _supabaseClient = SupabaseHandler().supabaseClient;

  // create a function which Returns the user data, if there is a logged in user.
  Future<User?> getUserData() async {
    try {
      final User? user = _supabaseClient.auth.currentUser;
      return user;
    } catch (e) {
      print("Error fetching user data: $e");
      rethrow;
    }
  }

  // create a function which will use getUserData function to get id of the user
  Future<String?> getUserId() async {
    try {
      final User? user = await getUserData();
      print("Userid  : ${user?.id}");
      return user?.id;
    } catch (e) {
      print("Error fetching user ID: $e");
      return null;
    }
  }

  // Upload image to Supabase Storage
  Future<String?> uploadImage(File imageFile) async {
    try {
      final fileName = imageFile.path.split('/').last;
      final response = await _supabaseClient.storage
          .from('avatars')
          .upload(fileName, imageFile, fileOptions: const FileOptions(cacheControl: '3600', upsert: false));

      if (response != null) {
        return _supabaseClient.storage.from('avatars').getPublicUrl(fileName);
      } else {
        _handleUploadError(response);
      }
    } catch (e) {
      print("Image upload failed: $e");
      rethrow;
    }
  }

  // Insert a record into any table
  Future<bool> insertRecord(String tableName, Map<String, dynamic> data) async {
    final response = await _supabaseClient.from(tableName).insert(data);
    return response.error == null;
  }



  // Update a record in any table
  Future<bool> updateRecord(String tableName, Map<String, dynamic> data, String keyColumn, String keyValue) async {
    try {
      print(data);
      final response = await _supabaseClient.from(tableName)
          .update(data)
          .eq(keyColumn, keyValue).select();
      print("Supabase Response: ${response.toString()}");



      return response    != null; // Success if data is not null
    } catch (e) {
      print("Exception in updateRecord: $e");
      return false;
    }
  }


  // Handle image upload errors
  void _handleUploadError(error) {
    if (error.message.contains('row-level security policy')) {
      throw Exception("Image upload failed: RLS violation");
    } else {
      throw Exception("Image upload failed: ${error.message}");
    }
  }
}
