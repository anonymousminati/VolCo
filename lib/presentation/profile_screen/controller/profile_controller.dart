import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:volco/core/utils/supabase_handler.dart';

class ProfileController extends GetxController with GetSingleTickerProviderStateMixin  {
  // Reactive variables
  RxBool isLoading = true.obs;
  RxBool isVolunteeredEventLoading = true.obs;
  RxBool isOrganizedEventLoading = true.obs;
  RxString avatarUrl = ''.obs;
  RxString fullName = ''.obs;
  RxString email = ''.obs;
  RxString mobileNumber = ''.obs;
  RxString bio = ''.obs;
  RxString location = ''.obs;
  RxString skills = ''.obs;
  RxInt age = 0.obs;

  late TabController tabController;
  // Volunteered Events
  RxList<Map<String, dynamic>> volunteeredEvents = <Map<String, dynamic>>[].obs;
  RxList<Map<String, dynamic>> organizedEvents = <Map<String, dynamic>>[].obs;

  final SupabaseClient supabaseClient = SupabaseHandler().supabaseClient;
  final SupabaseService supabaseService = SupabaseService();

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(length: 3, initialIndex: 0, vsync: this);

    fetchUserDetails();
    fetchVolunteeredEvents();


    tabController.addListener(() {
      if (tabController.index == 0) {
        fetchVolunteeredEvents();
      } else if (tabController.index == 2) {
        fetchOrganizedEvents();
      }
    });
  }

  Future<void> fetchUserDetails() async {
    isLoading.value = true;
    try {
      final userId = await supabaseService.getUserId();
      final response = await supabaseClient
          .from('profiles')
          .select()
          .eq('id', userId!)
          .single();

      if (response != null) {
        avatarUrl.value = response['avatar_url'] ?? "";
        fullName.value = response['full_name'] ?? "NA";
        email.value = response['username'] ?? "NA";
        mobileNumber.value = response['mobile_number'] ?? "NA";
        bio.value = response['bio'] ?? "NA";
        location.value = response['location'] ?? "NA";
        skills.value = response['skills'] ?? "NA";
        age.value = response['age'] ?? 0;
      }
    } catch (e) {
      print('Error fetching user details: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchVolunteeredEvents() async {
    isVolunteeredEventLoading.value = true;
    try {
      final userId = await supabaseService.getUserId();
      print('User ID: $userId');
      final response = await supabaseClient
          .rpc('get_volunteered_events', params: {'volunteer_uuid': userId.toString()});
      print('Volunteered events: $response')  ;
      if (response != null) {
        volunteeredEvents.assignAll(List<Map<String, dynamic>>.from(response));
        volunteeredEvents.refresh();
      }
    } catch (e) {
      print('Error fetching volunteered events: $e');
    } finally {
      isVolunteeredEventLoading.value = false;
    }
  }

  Future<void> fetchOrganizedEvents() async {
    isOrganizedEventLoading.value = true;
    try {
      final userId = await supabaseService.getUserId();
      print('User ID: $userId');
      final response = await supabaseClient
          .rpc('get_organized_events', params: {'organizer_uuid': userId});
      print('Organized events: $response')  ;
      if (response != null) {
        organizedEvents.assignAll(List<Map<String, dynamic>>.from(response));
        organizedEvents.refresh();
      }
    } catch (e) {
      print('Error fetching Organized events: $e');
    } finally {
      isOrganizedEventLoading.value = false;
    }
  }

}
