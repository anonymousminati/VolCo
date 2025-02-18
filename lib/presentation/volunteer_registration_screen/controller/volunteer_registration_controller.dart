import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:volco/core/utils/supabase_handler.dart';

class VolunteerRegistrationController extends GetxController {
  // Loading State
  final isLoading = false.obs;

  // Form Fields
  final emergencyContactController = TextEditingController();
  final additionalNotesController = TextEditingController();
  final preferredCommunication = "".obs; // Stores selected communication method
  final hasMedicalConditions = "No".obs; // Now stores "Yes" or "No"
  final needsAssistance = "No".obs; // Now stores "Yes" or "No"
  final termsAndConditionsAccept = false.obs;

  // Supabase Services
  final SupabaseClient supabaseClient = SupabaseHandler().supabaseClient;

  int eventId = 0;

  @override
  void onInit() {
    super.onInit();
  }

  void updateEventId(int event_Id) {
    print("from update Event ID: $event_Id");
    eventId = event_Id;
  }

  Future<bool> registerVolunteer() async {
    if (!termsAndConditionsAccept.value) {
      Get.snackbar("Error", "You must accept the Terms and Conditions.");
      return false;
    }

    isLoading.value = true;

    try {
      final userId =await supabaseClient.auth.currentUser?.id;
      if (userId == null) {
        throw Exception("User not logged in.");
      }

      final response = await supabaseClient.from('registrations').insert({
        'volunteer_id': userId,
        'event_id': eventId,
        'additional_notes': additionalNotesController.text,
        'volunteer_emergency_contact': emergencyContactController.text,
        'preferred_communication': preferredCommunication.value,
        'has_medical_conditions': hasMedicalConditions.value == "Yes", // Convert to boolean
        'needs_assistance': needsAssistance.value == "Yes", // Convert to boolean
        'termsAndConditionAcception': termsAndConditionsAccept.value,
      }).select("registration_id");

      print(response);
      isLoading.value = false;
      return true;
    } catch (e) {
      isLoading.value = false;
      print("registration volutnteer error: $e");
      Get.snackbar("Error", "Registration failed:  ${e.toString()}");
      return false;
    }
  }

  @override
  void onClose() {
    emergencyContactController.dispose();
    additionalNotesController.dispose();
    super.onClose();
  }
}
