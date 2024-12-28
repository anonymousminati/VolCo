import 'package:permission_handler/permission_handler.dart';

class AppPermissions {
  /// Request camera permission
  static Future<bool> requestCameraPermission() async {
    final status = await Permission.camera.request();
    return _handlePermissionStatus(status);
  }

  /// Request storage permission for images
  static Future<bool> requestImageStoragePermission() async {
    final status = await Permission.photos.request();
    return _handlePermissionStatus(status);
  }

  /// Request storage permission for videos
  static Future<bool> requestVideoStoragePermission() async {
    final status = await Permission.videos.request();
    return _handlePermissionStatus(status);
  }

  /// Request storage permission for audio files
  static Future<bool> requestAudioStoragePermission() async {
    final status = await Permission.audio.request();
    return _handlePermissionStatus(status);
  }

  /// Request external storage permission
  static Future<bool> requestExternalStoragePermission() async {
    final status = await Permission.manageExternalStorage.request();
    return _handlePermissionStatus(status);
  }

  /// Request audio recording permission
  static Future<bool> requestRecordAudioPermission() async {
    final status = await Permission.microphone.request();
    return _handlePermissionStatus(status);
  }

  /// General handler for permission statuses
  static bool _handlePermissionStatus(PermissionStatus status) {
    if (status.isGranted) {
      return true;
    } else if (status.isPermanentlyDenied) {
      _showPermissionSettingsDialog();
      return false;
    } else {
      return false;
    }
  }

  /// Show dialog to redirect user to app settings
  static void _showPermissionSettingsDialog() {
    // Use your preferred method to show a dialog (e.g., GetX, Flutter's AlertDialog, etc.)
    print('Permission is permanently denied. Please enable it in the app settings.');
    openAppSettings();
  }

  /// Request all permissions separately based on the requirement
  static Future<void> requestPermissionsForImageHandling() async {
    bool cameraGranted = await requestCameraPermission();
    bool storageGranted = await requestImageStoragePermission();

    if (cameraGranted && storageGranted) {
      print('All permissions required for image handling are granted.');
    } else {
      print('Image handling permissions are not fully granted.');
    }
  }

  static Future<void> requestPermissionsForVideoHandling() async {
    bool videoStorageGranted = await requestVideoStoragePermission();

    if (videoStorageGranted) {
      print('All permissions required for video handling are granted.');
    } else {
      print('Video handling permissions are not fully granted.');
    }
  }

  static Future<void> requestPermissionsForAudioHandling() async {
    bool recordAudioGranted = await requestRecordAudioPermission();
    bool audioStorageGranted = await requestAudioStoragePermission();

    if (recordAudioGranted && audioStorageGranted) {
      print('All permissions required for audio handling are granted.');
    } else {
      print('Audio handling permissions are not fully granted.');
    }
  }

  static Future<void> requestPermissionsForExternalStorage() async {
    bool storageGranted = await requestExternalStoragePermission();

    if (storageGranted) {
      print('All permissions required for external storage access are granted.');
    } else {
      print('External storage access permissions are not fully granted.');
    }
  }
}