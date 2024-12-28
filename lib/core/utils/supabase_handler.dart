import 'dart:io';
import 'package:supabase/supabase.dart';
import 'package:volco/core/utils/project_constants.dart';

class SupabaseService {
  final SupabaseClient _client = SupabaseClient(PROJECT_URL, PROJECT_ANON_KEY);

  // Upload image to Supabase Storage
  Future<String?> uploadImage(File imageFile) async {
    try {
      final fileName = imageFile.path.split('/').last;
      final response = await _client.storage
          .from('avatars')
          .upload(fileName, imageFile, fileOptions: const FileOptions(cacheControl: '3600', upsert: false));

      if (response != null) {
        return _client.storage.from('avatars').getPublicUrl(fileName);
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
    final response = await _client.from(tableName).insert(data);
    return response.error == null;
  }

  // Update a record in any table
  Future<bool> updateRecord(String tableName, Map<String, dynamic> data, String key, dynamic value) async {
    final response = await _client.from(tableName).update(data).eq(key, value);
    return response.error == null;
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
