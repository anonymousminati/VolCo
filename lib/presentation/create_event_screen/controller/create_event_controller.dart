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
  final durationlController = TextEditingController();
  final mobileNumberController = TextEditingController();
  final locationController = TextEditingController();
  final skillsController = TextEditingController();
  final ageController = TextEditingController();
  final SupabaseClient supabaseClient = SupabaseHandler().supabaseClient;
  final SupabaseService supabaseService = SupabaseService();
  // Image picker state
  Rxn<XFile> pickedImage = Rxn<XFile>();
  Rxn<DateTime> selectedDate = Rxn<DateTime>();
  Rxn<TimeOfDay> selectedTime = Rxn<TimeOfDay>();

  /// **📌 Show Syncfusion Date Picker**
  void showDatePicker(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Container(
            width: MediaQuery.of(context).size.width * 0.8, // 80% of screen width
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
    final selectedImage = await picker.pickImage(source: ImageSource.gallery);
    if (selectedImage != null) {
      pickedImage.value = selectedImage;
    }
  }

  void onClose() {
    // Dispose of text controllers
    eventNameController.dispose();
    eventDescriptionController.dispose();
    durationlController.dispose();
    mobileNumberController.dispose();
    locationController.dispose();
    skillsController.dispose();
    ageController.dispose();
    super.onClose();
  }
}
