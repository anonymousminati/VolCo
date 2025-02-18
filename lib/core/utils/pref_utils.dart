import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class PrefUtils {
  // Singleton instance
  static final PrefUtils instance = PrefUtils._internal();

  // Private constructor
  PrefUtils._internal();

  SharedPreferences? _prefs;

  /// Initializes the SharedPreferences instance.
  Future<void> init() async {
    _prefs ??= await SharedPreferences.getInstance();
    print('SharedPreferences initialized');
  }

  /// Clears all stored preference data.
  Future<void> clearPreferencesData() async {
    await _prefs?.clear();
  }

  /// Stores the Supabase auth session as a JSON string.
  Future<void> setSupabaseAuthSession(String value) async {
    await _prefs!.setString('supabase_auth_session', value);
  }

  /// Retrieves the stored Supabase auth session JSON string.
  String? getSupabaseAuthSession() {
    return _prefs?.getString('supabase_auth_session');
  }

  /// Stores theme data.
  Future<void> setThemeData(String value) async {
    await _prefs!.setString('themeData', value);
  }

  /// Retrieves the stored theme data.
  String getThemeData() {
    return _prefs?.getString('themeData') ?? 'primary';
  }
}
