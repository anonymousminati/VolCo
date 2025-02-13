import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:volco/core/utils/supabase_handler.dart';

class EventDescriptionController extends GetxController {
  var isLoading = true.obs;
  var eventDetails = {}.obs;      // Stores common event details
  var activityDetails = {}.obs;   // Stores category-specific details

  final SupabaseClient supabaseClient = SupabaseHandler().supabaseClient;
  final SupabaseService supabaseService = SupabaseService();

  /// Fetches event details from the 'events' table and then
  /// fetches activity-specific details from the corresponding table.
  Future<void> fetchEventDetails(int eventId, String eventCategory) async {
    try {
      isLoading.value = true;

      // Fetch common event details.
      final commonResponse = await supabaseClient
          .from('events')
          .select()
          .eq('event_id', eventId)
          .single();
      eventDetails.assignAll(commonResponse);

      // Determine the specific table name based on the event category.
      String? tableName;
      switch (eventCategory.toLowerCase()) {
        case "education":
          tableName = "education_event_details";
          break;
        case "health & wellness":
          tableName = "health_event_details";
          break;
        case "counselling":
          tableName = "counselling_event_details";
          break;
        case "conservation":
          tableName = "conservation_event_details";
          break;
        case "work with elders":
          tableName = "elders_event_details";
          break;
        case "work with orphans":
          tableName = "orphans_event_details";
          break;
        case "animal rescue":
          tableName = "animal_rescue_event_details";
          break;
        case "clean activity":
          tableName = "clean_event_details";
          break;
        default:
          tableName = null;
      }

      // If we have a table for extra fields, fetch them.
      if (tableName != null) {
        final activityResponse = await supabaseClient
            .from(tableName)
            .select()
            .eq('event_id', eventId)
            .single();
        activityDetails.assignAll(activityResponse);
      } else {
        activityDetails.clear();
      }
    } catch (e) {
      print("Error fetching event details: $e");
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onInit() {
    super.onInit();
    final args = Get.arguments;
    if (args != null) {
      final int eventId = args['eventCreatedId'] ?? 0;
      final String eventCategory = args['eventCategory'] ?? "";
      if (eventId > 0 && eventCategory.isNotEmpty) {
        fetchEventDetails(eventId, eventCategory);
      }
    }
  }
}
