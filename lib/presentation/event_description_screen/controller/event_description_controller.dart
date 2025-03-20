import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:volco/core/utils/supabase_handler.dart';

class EventDescriptionController extends GetxController {
  var isLoading = true.obs;
  var eventDetails = {}.obs; // Stores common event details
  var activityDetails = {}.obs; // Stores category-specific details
  var eventTags = [].obs; // Stores event tags
  RxString userId = ''.obs; // RxString for reactive updates
  RxBool isUserisRegistered =
      false.obs; // Reactive flag for registration status

  RxList<Map<String, dynamic>> volunteerProfiles = <Map<String, dynamic>>[].obs;
  final SupabaseClient supabaseClient = SupabaseHandler().supabaseClient;
  final SupabaseService supabaseService = SupabaseService();

  @override
  void onInit() async {
    super.onInit();
    final args = Get.arguments;
    if (args != null) {
      final int eventId = args['eventCreatedId'] ?? 0;
      final String eventCategory = args['eventCategory'] ?? "";
      if (eventId > 0 && eventCategory.isNotEmpty) {
        // First, fetch the event details
        await fetchEventDetails(eventId, eventCategory);
        // Then, fetch the user ID
        await _fetchUserId();
        // Check if the volunteer is registered (if applicable)
        if (eventDetails["event_id"] != null) {
          await isVolunteerRegistered(userId.value, eventDetails["event_id"]);
        }
        // Finally, fetch the volunteer profiles for this event
        await fetchEventRegisteredVolunteers();
        // And subscribe to realtime changes on registrations for this event
        subscribeToRegisteredVolunteerChanges();
      }
    }
  }

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

      final tagsResponse = await supabaseClient
          .from('event_tags')
          .select()
          .eq('event_id', eventId)
          .single();
      print(tagsResponse["tag_name"].split(","));
      eventTags.assignAll(tagsResponse["tag_name"].split(","));
      // Determine the specific table name based on the event category.
      String? tableName;
      switch (eventCategory.toLowerCase()) {
        case "education":
          tableName = "education_event_details";
          break;
        case "health & wellness":
          tableName = "health_event_details";
          break;
        case "counseling":
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
        case "cleaning":
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

  Future<void> _fetchUserId() async {
    try {
      User? user = await SupabaseService().getUserData();
      if (user != null) {
        print('User metadata: ${user.userMetadata}');
        userId.value = user.id; // Update reactive value
        // Update reactive value
      }
    } catch (error) {
      print('Error fetching avatar URL: $error');
    }
  }

  Future<void> isVolunteerRegistered(String volunteerId, int eventId) async {
    try {
      final response = await supabaseClient
          .from('registrations')
          .select('registration_id')
          .eq('volunteer_id', volunteerId)
          .eq('event_id', eventId)
          .maybeSingle(); // Returns null if no record is found

      isUserisRegistered.value = response != null;
    } catch (e) {
      Get.snackbar("Error", "Failed to check registration: ${e.toString()}");
    }
  }

  Future<void> fetchEventRegisteredVolunteers() async {
    try {
      int eventId = eventDetails["event_id"];
      // Call the RPC function 'get_event_volunteers'
      final response = await supabaseClient
          .rpc('get_registered_event_volunteers', params: {'p_event_id': eventId}).select();
      print("Volunteer profiles response: $response");
      if (response != null) {
        volunteerProfiles.assignAll(List<Map<String, dynamic>>.from(response));
      }
    } catch (e) {
      print("Error fetching event volunteers: $e");
    }
  }

  /// Subscribe to realtime changes on the registrations table for this event.
  void subscribeToRegisteredVolunteerChanges() {
    supabaseClient
        .from('registrations')
        .stream(primaryKey: ['registration_id'])
        .eq('event_id', eventDetails["event_id"])
        .listen((data) {
      print("Realtime update on registrations: $data");
      fetchEventRegisteredVolunteers();
    });
  }

  /// Cancel the volunteer registration for the current event.
  Future<bool> cancelRegistration() async {
    try {
      if (eventDetails.isEmpty) return false;
      int eventId = eventDetails["event_id"];
      final response = await supabaseClient
          .from('registrations')
          .delete()
          .eq('volunteer_id', userId.value)
          .eq('event_id', eventId);
      print("cancel response: $response");
      if (response == null) {
        print("cancel regis error null");
        isUserisRegistered.value = false;

        return true;
      } else {
        print("cencel registration false");
        return false;
      }
    } catch (e) {
      Get.snackbar("Error", "Failed to cancel registration: ${e.toString()}");
      print("error:failed to cancel registration ${e.toString()}");
      return false;
    }
  }
}
