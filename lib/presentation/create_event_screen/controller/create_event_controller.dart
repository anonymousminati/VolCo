import 'dart:ffi';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:volco/core/app_export.dart';
import 'package:volco/core/utils/supabase_handler.dart';
import 'package:volco/presentation/user_details_screen/models/user_details_model.dart';

class CreateEventController extends GetxController {
  // Text controllers
  final eventNameController = TextEditingController();
  final eventDescriptionController = TextEditingController();
  final durationController = TextEditingController();
  final mobileNumberController = TextEditingController();
  final locationController = TextEditingController();
  final skillsController = TextEditingController();
  final ageController = TextEditingController();

  // Image picker state
  Rxn<XFile> pickedImage = Rxn<XFile>();
  Rxn<DateTime> selectedDate = Rxn<DateTime>();
  Rxn<TimeOfDay> selectedTime = Rxn<TimeOfDay>();
  RxString selectedCategory = ''.obs;
  RxList<String> selectedTags = <String>[].obs;

  final SupabaseClient supabaseClient = SupabaseHandler().supabaseClient;
  final SupabaseService supabaseService = SupabaseService();

  void updateSelectedCategory(String category) {
    print("Received categoryType: $category");
    selectedCategory.value = category;
  }

  /// **📌 Show Syncfusion Date Picker**
  void showDatePicker(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Container(
            width:
                MediaQuery.of(context).size.width * 0.8, // 80% of screen width
            height: 400.0, // Fixed height
            child: SfDateRangePicker(
              minDate: DateTime.now(),
              onSelectionChanged: (DateRangePickerSelectionChangedArgs args) {
                selectedDate.value = args.value;
                update(); // Notify GetX about the change
                Navigator.pop(context);
              },
              selectionMode: DateRangePickerSelectionMode.single,
            ),
          ),
        );
      },
    );
  }

  /// **📌 Show Time Picker**
  Future<void> showTimePickerDialog(BuildContext context) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: selectedTime.value ?? TimeOfDay.now(),
    );

    if (pickedTime != null) {
      selectedTime.value = pickedTime;
      update(); // Notify GetX about the change
    }
  }

  // Method to pick an image
  Future<void> pickImage() async {
    final picker = ImagePicker();
    final XFile? selectedImage =
        await picker.pickImage(source: ImageSource.gallery);
    if (selectedImage != null) {
      pickedImage.value = selectedImage;
    }
  }

  /// Create a new event record.
  Future<bool> createEvent() async {
    try {
      // Validate required fields
      if (eventNameController.text.isEmpty ||
          eventDescriptionController.text.isEmpty ||
          durationController.text.isEmpty ||
          mobileNumberController.text.isEmpty ||
          locationController.text.isEmpty ||
          selectedDate.value == null ||
          selectedTime.value == null) {
        Get.snackbar("Error", "Please fill in all required fields.");
        return false;
      }

      // Upload the event image
      String? imageUrl;
      if (pickedImage.value != null) {
        imageUrl =
            await supabaseService.uploadImage(File(pickedImage.value!.path));
      } else {
        Get.snackbar("Error", "Please select an event image.");
        return false;
      }

      // Combine selected date and time into a DateTime
      final DateTime date = selectedDate.value!;
      final TimeOfDay time = selectedTime.value!;
      final DateTime eventDateTime =
          DateTime(date.year, date.month, date.day, time.hour, time.minute);

      // Build the event data map.
      // (Adjust field names if needed to match your database schema.)
      final Map<String, dynamic> eventData = {
        'organizer_id': supabaseClient.auth.currentUser?.id,
        'event_name': eventNameController.text.trim(),
        'event_description': eventDescriptionController.text.trim(),
        'image_url': imageUrl,
        'event_date': eventDateTime.toIso8601String(),
        'duration_hours': int.parse(durationController.text.trim()),
        'location': locationController.text.trim(),
        'contact_number': mobileNumberController.text.trim(),
        // For the extra fields, you can either store them in separate tables or include them in a JSONB column.
        // Here, we assume the common table only stores common fields.
        'activity_type': selectedCategory.value,
        'tags': selectedTags, // This could be stored as an array or JSON.
        'created_at': DateTime.now().toIso8601String(),
        'updated_at': DateTime.now().toIso8601String(),
      };

      // Insert the event record into the "events" table.
      final bool insertResult =
          await supabaseService.insertRecord('events', eventData);
      if (insertResult) {
        Get.snackbar("Success", "Event created successfully!");
        return true;
      } else {
        Get.snackbar("Error", "Failed to create event.");
        return false;
      }
    } catch (e) {
      print("Error creating event: $e");
      Get.snackbar("Error", "Error creating event: $e");
      return false;
    }
  }

  void onClose() {
    // Dispose of text controllers
    eventNameController.dispose();
    eventDescriptionController.dispose();
    durationController.dispose();
    mobileNumberController.dispose();
    locationController.dispose();
    skillsController.dispose();
    ageController.dispose();
    super.onClose();
  }
}
