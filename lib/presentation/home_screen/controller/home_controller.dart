import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:volco/core/app_export.dart';
import 'package:volco/core/utils/project_constants.dart';
import 'package:volco/presentation/home_screen/models/home_model.dart';
import 'package:volco/presentation/home_screen/models/home_screen_initial_model.dart';
import 'package:volco/widgets/event_card_widget.dart';
import 'package:dio/dio.dart';


class HomeController extends GetxController {
  TextEditingController searchBarController = TextEditingController();
  Rx<HomeModel> homeModelObj = HomeModel().obs;
  Rx<HomeScreenInitialModel> homeScreenInitialModelObj =
      HomeScreenInitialModel().obs;

  RxString avatarUrl = ''.obs; // RxString for reactive updates
  RxString userId = ''.obs; // RxString for reactive updates
  RxString selectedPlaceName = ''.obs;
  LatLng? selectedCoordinates ;
  RxList<EventCardWidget> eventList = <EventCardWidget>[].obs;
  RxList<EventCardWidget> recommendedEventList = <EventCardWidget>[].obs;
  final SupabaseClient supabaseClient = SupabaseHandler().supabaseClient;
  final SupabaseService supabaseService = SupabaseService();
  final dio = Dio();


  @override
  void onReady() {
    super.onReady();
    fetchRecommendedEvents();

    _fetchAvatarUrl(); // Fetch avatar URL when the controller is ready
    fetchEventsByAddress("Bhelkenagar, Kothrud, Pune, Maharashtra, India");
  }

  Future<void> fetchRecommendedEvents() async {
    try {
      userId.value = await supabaseService.getUserId() ?? '';
      var user = await supabaseClient.from("profiles").select().eq("id", userId).single();
      var user_id = user['id'];
      var user_lat = user['location_cords']['latitude'];
      var user_lon = user['location_cords']['longitude'];
      final String url =
          '${RecommendationBaseURL}/recommendations?user_id=$user_id&user_lat=$user_lat&user_lon=$user_lon';

      final response = await dio.get(url) ;
      print('response:$response');
      if (response.statusCode == 200) {
        List<Map<String, dynamic>> recommendedEvents =
        List<Map<String, dynamic>>.from(response.data['recommendations'] ?? []);

        recommendedEventList.assignAll(recommendedEvents.map((event) => EventCardWidget(
          eventName: event['event_name'],
          imageUrl: event['image_url'] ?? '',
          eventDate: event['event_date'].toString(),
          eventTime: event['event_time'].toString(),
          volunteerCount: int.tryParse(event['volunteer_requirements'] ?? '0') ?? 0,
          location: event['location'],
          joinText: "Wants Join",
          onTap: () {
            print("${event['event_name']} clicked!");
          },
          onJoinTap: () {
            print("User wants to sign up for ${event['event_name']}!");
            Get.toNamed(AppRoutes.eventDescriptionScreen, arguments: {
              "eventCreatedId": event["event_id"],
              "eventCategory": event["activity_type"],
              "isForRegister": true,
            });
          }, isFavorite: false,
        )));
        recommendedEventList.shuffle();
        recommendedEventList.refresh();
      } else {
        print("Error fetching recommended events: ${response.statusCode}");
      }
    } catch (error) {
      print("Error fetching recommended events: $error");
    }
  }


  Future<void> _fetchAvatarUrl()  async {
    try {
      User? user  =await SupabaseService().getUserData();
      if (user != null) {
        print('User metadata: ${user.userMetadata}');
        userId.value = user.id; // Update reactive value
        avatarUrl.value = user.userMetadata?['avatar_url'] ; // Update reactive value
      }
    } catch (error) {
      print('Error fetching avatar URL: $error');
    }
  }

  Future<void> fetchEventsByAddress(String address) async {
    try {
      var response = await supabaseClient
          .rpc('search_events_by_address', params: {'search_address': address})
          .select();
      print(response);
      List<Map<String, dynamic>> events = List<Map<String, dynamic>>.from(response ?? []);

      eventList.assignAll(events.map((event) => EventCardWidget(
        eventName: event['event_name'],
        imageUrl: event['image_url'] ?? '',
        eventDate: event['event_date'].toString(),
        eventTime: event['event_time'].toString(),
        volunteerCount: int.tryParse(event['volunteer_requirements'] ?? '0') ?? 0,
        location: event['location'],
        joinText: "Wants Join",
        onTap: () {
          print("${event['event_name']} clicked!");
        },
        onJoinTap: () {
          print("User wants to sign up for ${event['event_name']}!");
          Get.toNamed(AppRoutes.eventDescriptionScreen, arguments: {
            "eventCreatedId": event["event_id"],
            "eventCategory": event["activity_type"],
            "isForRegister": true,
          });
        }, isFavorite: false,
      )));

      eventList.refresh();
    } catch (error) {
      print("Error fetching events: $error");
    }
  }

  @override
  void onClose() {
    super.onClose();
    searchBarController.dispose();
  }
}
