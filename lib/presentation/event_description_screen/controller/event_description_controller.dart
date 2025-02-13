import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:volco/core/utils/supabase_handler.dart';

class EventDescriptionController extends GetxController {
  var isLoading = true.obs;
  var eventDetails = {}.obs; // Stores general event details
  var activityDetails = {}.obs; // Stores category-specific details

  final SupabaseClient supabaseClient = SupabaseHandler().supabaseClient;

  Future<void> fetchEventDetails(int eventId, String eventCategory) async {
    try {
      isLoading.value = true;

      // Fetch event details
      final responseofevents = await supabaseClient
          .from('events')
          .select()
          .eq('event_id', eventId)
          .single();

      // Fetch activity-specific details
      final responseofActivityEvents = await supabaseClient
          .from('${eventCategory.toLowerCase()}_event_details')
          .select()
          .eq('event_id', eventId)
          .single();

      // Store event details
      eventDetails.assignAll(responseofevents);
      activityDetails.assignAll(responseofActivityEvents);

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
      final int eventId = args['eventCreatedId'] ?? 30;
      final String eventCategory = args['eventCategory'] ?? "education";

      if (eventId > 0 && eventCategory.isNotEmpty) {
        fetchEventDetails(eventId, eventCategory);
      }
    }
  }
}
