import 'dart:ffi';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:volco/core/app_export.dart';
import 'package:volco/core/utils/image_constant.dart';
import 'package:volco/core/utils/supabase_handler.dart';
import 'package:volco/presentation/user_details_screen/models/user_details_model.dart';

class CreateEventController extends GetxController {
  final dateFormatter = DateFormat('yyyy-MM-dd');
  // **📌 Common Event Fields**
  final eventNameController = TextEditingController();
  final eventDescriptionController = TextEditingController();
  final durationController = TextEditingController();
  final mobileNumberController = TextEditingController();
  final locationController = TextEditingController();
  LatLng? selectedCoordinates ;
  final skillsController = TextEditingController();
  final ageController = TextEditingController();
  final volunteerController = TextEditingController();
  final socialMediaController = TextEditingController();
  final dateController = TextEditingController();
  final timeController = TextEditingController();
  final emergencyContactController = TextEditingController();
  // **📌 Image Picker & Date-Time Fields**
  Rxn<XFile> pickedImage = Rxn<XFile>();
  Rxn<DateTime> selectedDate = Rxn<DateTime>();
  Rxn<TimeOfDay> selectedTime = Rxn<TimeOfDay>();
  RxString selectedCategory = ''.obs;
  RxList<String> selectedTags = <String>[].obs;
  RxList<String> TagsValueList = <String>[].obs;

  // **📌 Supabase Services**
  final SupabaseClient supabaseClient = SupabaseHandler().supabaseClient;
  final SupabaseService supabaseService = SupabaseService();

  // **📌 Special Fields for Different Activities**
  // **Education Activity**
  RxList<String> ageGroups = <String>[].obs;
  RxList<String> subjectFocus = <String>[].obs;

  var selectedAgeGroup = RxnString();
  var selectedSubjectFocus = RxnString();
  final languageRequirementsController = TextEditingController();
  final materialsNeededController = TextEditingController();

  // **Health & Wellness**
  RxList<String> typeOfServices = <String>[].obs;
  RxList<String> medicalProfessionalList = <String>[].obs;

  var selectedServices = <String>[].obs;
  var selectedMedicalProfessional = RxnString();
  final equipmentNeeded = TextEditingController();
  final medicationGuidelines = TextEditingController();

  // **Counseling**
  RxList<String> counselingTypes = <String>[].obs;
  RxList<String> sessionFormats = <String>[].obs;

  var selectedCounselingType = RxnString();
  var selectedSessionFormat = RxnString();

  // **Conservation**
  RxList<String> conservationActivityTypes = <String>[].obs;

  var selectedActivityType = RxnString();
  final toolsProvided = TextEditingController();
  final environmentalImpact = TextEditingController();
  final wasteDisposalPlan = TextEditingController();

  // **Work with Elders**
  RxList<String> elderActivityTypes = <String>[].obs;
  var selectedElderActivityType = RxnString();
  final itemsToBring = TextEditingController();
  final wheelChairAccessible = RxnString();

  // **Work with Orphans**
  RxList<String> orphanActivityTypes = <String>[].obs;
  final childAgeRange = TextEditingController();
  var selectedOrphanActivityType = RxnString();
  final donationNeeds = TextEditingController();

  // **Animal Rescue**
  RxList<String> animalTypes = <String>[].obs;
  RxList<String> taskInvolved = <String>[].obs;

  var selectedAnimalType = RxnString();
  var selectedTaskInvolved = RxnString();
  final vaccinationStatus = TextEditingController();
  final handlingEquipment = TextEditingController();

  // **Clean Activity**
  RxList<String> areaTypes = <String>[].obs;
  RxList<String> wasteCategories = <String>[].obs;
  var selectedAreaType = RxnString();
  var selectedWasteCategory = RxnString();
  final recyclingPlan = TextEditingController();

  // **📌 Loading State**
  RxBool isLoading = true.obs;

  int eventId = 0;

  @override
  void onInit() {
    super.onInit();

    ever(selectedCategory, (type) {
      loadActivitySpecificFields(type!);
    });

    // Initial Load
    loadActivitySpecificFields(selectedCategory.value);
  }

  void updateSelectedCategory(String category) {
    print("Received categoryType: $category");
    selectedCategory.value = category;
  }

  Future<void> loadActivitySpecificFields(String? type) async {
    isLoading.value = true;
    List<Future> futures = [];
    if (type == "Education") {
      futures.add(loadTags('education'));
      futures.add(loadEducationAgeGroups());
      futures.add(loadEducationSubjectFocus());
    } else if (type == "Health & Wellness") {
      futures.add(loadTags('health_and_wellness'));
      futures.add(loadHealthServicesType());
      futures.add(loadHealthMedicalProfessionals());
    } else if (type == "Counseling") {
      futures.add(loadTags('counseling'));
      futures.add(loadCounselingTypes());
      futures.add(loadCounselingSessionFormats());
    } else if (type == "Conservation") {
      futures.add(loadTags('conservation'));
      futures.add(loadConservationActivityTypes());
    } else if (type == "Work With Elders") {
      futures.add(loadTags('work_with_elders'));
      futures.add(loadElderActivityTypes());
    } else if (type == "Work With Orphans") {
      futures.add(loadTags('work_with_orphans'));
      futures.add(loadOrphanActivityTypes());
    } else if (type == "Animal Rescue") {
      futures.add(loadTags('animal_rescue'));
      futures.add(loadAnimalTypes());
      futures.add(loadTaskInvolved());
    } else if (type == "Cleaning") {
      futures.add(loadTags('clean'));
      futures.add(loadAreaTypes());
      futures.add(loadWasteCategories());
    }

    await Future.wait(futures);
    isLoading.value = false;
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
                dateController.text = dateFormatter.format(args.value);
                update();
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
      timeController.text = pickedTime.format(context);
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

  /// **📌 Reset All Fields When Switching Activities**
  void resetFields() {
    selectedAgeGroup.value = null;
    selectedSubjectFocus.value = null;
    languageRequirementsController.text = "";
    materialsNeededController.text = "";

    selectedServices.clear();
    selectedMedicalProfessional.value = null;
    equipmentNeeded.text = "";
    medicationGuidelines.text = "";

    selectedCounselingType.value = null;
    selectedSessionFormat.value = null;

    selectedActivityType.value = null;
    toolsProvided.text = "";
    environmentalImpact.text = "";
    wasteDisposalPlan.text = "";

    selectedElderActivityType.value = null;
    itemsToBring.text = "";

    childAgeRange.text = "";
    selectedOrphanActivityType.value = null;
    donationNeeds.text = "";

    selectedAnimalType.value = null;
    selectedTaskInvolved.value = null;
    vaccinationStatus.text = "";
    handlingEquipment.text = "";

    selectedAreaType.value = null;
    selectedWasteCategory.value = null;
    recyclingPlan.text = "";
  }

  // from here eventFields methods

  // ** Education Activity Loaders **
  Future<void> loadEducationAgeGroups() async {
    ageGroups.value =
        await supabaseService.fetchEventFieldOptions('education', 'age_group');
    print("ageGroups: $ageGroups");
  }
  Future<void> loadEducationSubjectFocus() async {
    subjectFocus.value = await supabaseService.fetchEventFieldOptions(
        'education', 'subject_focus');
    print("subjectFocus: $subjectFocus");
  }
  // ** Health & Wellness Loaders **
  Future<void> loadHealthServicesType() async {
    typeOfServices.value = await supabaseService.fetchEventFieldOptions(
        'health_and_wellness', 'type_of_service');
    print("typeOfServices: $typeOfServices");
  }
  Future<void> loadHealthMedicalProfessionals() async {
    medicalProfessionalList.value =
        await supabaseService.fetchEventFieldOptions(
            'health_and_wellness', 'medical_professional_required');
    print("medicalProfessionalList: $medicalProfessionalList");
  }
  // ** Counseling Loaders **
  Future<void> loadCounselingTypes() async {
    counselingTypes.value = await supabaseService.fetchEventFieldOptions(
        'counseling', 'counseling_type');
    print("counselingTypes: $counselingTypes");
  }
  Future<void> loadCounselingSessionFormats() async {
    sessionFormats.value = await supabaseService.fetchEventFieldOptions(
        'counseling', 'session_format');
    print("sessionFormats: $sessionFormats");
  }
  // ** Conservation Loader **
  Future<void> loadConservationActivityTypes() async {
    conservationActivityTypes.value = await supabaseService
        .fetchEventFieldOptions('conservation', 'activity_type');
    print("conservationActivityTypes: $conservationActivityTypes");
  }
  // ** Work with Elders Loader **
  Future<void> loadElderActivityTypes() async {
    elderActivityTypes.value = await supabaseService.fetchEventFieldOptions(
        'work_with_elders', 'activity_type');
    print("elderActivityTypes: $elderActivityTypes");
  }
  // ** Work with Orphans Loader **
  Future<void> loadOrphanActivityTypes() async {
    orphanActivityTypes.value = await supabaseService.fetchEventFieldOptions(
        'work_with_orphans', 'activity_type');
    print("orphanActivityTypes: $orphanActivityTypes");
  }
  // ** Animal Rescue Loaders **
  Future<void> loadAnimalTypes() async {
    animalTypes.value = await supabaseService.fetchEventFieldOptions(
        'animal_rescue', 'animal_type');
    print("animalTypes: $animalTypes");
  }
  Future<void> loadTaskInvolved() async {
    taskInvolved.value = await supabaseService.fetchEventFieldOptions(
        'animal_rescue', 'tasks_involved');
    print("taskInvolved: $taskInvolved");
  }
  // ** Clean Activity Loaders **
  Future<void> loadAreaTypes() async {
    areaTypes.value = await supabaseService.fetchEventFieldOptions(
        'clean', 'area_type');
    print("areaTypes: $areaTypes");
  }
  Future<void> loadWasteCategories() async {
    wasteCategories.value = await supabaseService.fetchEventFieldOptions(
        'clean', 'waste_category');
    print("wasteCategories: $wasteCategories");
  }
  // ** tag loader **
  Future<void> loadTags(String tageventcatogory) async {
    TagsValueList.value =
        await supabaseService.fetchEventFieldOptions(tageventcatogory, 'tag');
    print("selectedTags: $TagsValueList");
  }

  /// **📌 Create New Event**

  Future<bool> createNewEvent() async {
    Get.bottomSheet(
      Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          color: appTheme.gray800,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset(
              ImageConstant.uploadAnimationLottie,
            ),
          ],
        ),
      ),
      isDismissible: false,
    );
    try {
      print("uploading....");
      print("createNewEvent 1");
      // **Fetch Organizer ID (Current User)**
      final User? user = await supabaseService.getUserData();
      print("createNewEvent 2");

      if (user == null) {
        print("User not logged in.");
        Get.back();
        return false;
      }
      final organizerId = user.id;
      print("createNewEvent 3");

      // **Upload Image to Supabase Storage**
      String imageUrl = "";

      if (pickedImage.value != null) {
        print("createNewEvent 4");

        final imageFile = File(pickedImage.value!.path);
        final imageName =
            "event_images/${DateTime.now().millisecondsSinceEpoch}_${pickedImage.value!.path.split('/').last}";
        print("createNewEvent 5");

        final response = await supabaseClient.storage
            .from("event_images")
            .upload(imageName, imageFile);
        print("createNewEvent 6");

        if (response.isEmpty) {
          print("Image upload failed");
          Get.back();
          return false;
        }
        print("createNewEvent 7");

        imageUrl = await supabaseClient.storage
            .from("event_images")
            .getPublicUrl(imageName);

        print("createNewEvent 8");

        print("Image uploaded successfully: $imageUrl");
      }
      print("createNewEvent 9");

      // **Insert into Events Table**
      final eventInsertResponse = await supabaseClient.from('events').insert({
        'organizer_id': organizerId,
        'event_name': eventNameController.text.trim(),
        'event_description': eventDescriptionController.text.trim(),
        'image_url': imageUrl,
        'event_date': dateFormatter.format(selectedDate.value!),
        'event_time':
            "${selectedTime.value?.hour}:${selectedTime.value?.minute}",
        'duration_hours': int.tryParse(durationController.text) ?? 1,
        'location': locationController.text.trim(),
        'location_cords':{
          "latitude": selectedCoordinates!.latitude,
          "longitude": selectedCoordinates!.longitude
        },
        // 'required_volunteers': int.tryParse(volunteerController.text) ?? 1,
        'contact_number': mobileNumberController.text.trim(),
        'social_media_link': socialMediaController.text.trim(),
        'emergency_contact_info':
            emergencyContactController.text.trim()??"Emergency contact details here", // Update as needed
        'volunteer_requirements': volunteerController.text.trim(),
        'activity_type': selectedCategory.value,
      }).select('event_id');
      print("createNewEvent 10");

      if (eventInsertResponse == null || eventInsertResponse.isEmpty) {
        print("Failed to create event.");
        Get.back();
        return false;
      }
      print("createNewEvent 11");
      print("eventInsertResponse: $eventInsertResponse");
       eventId = eventInsertResponse.first['event_id'];
      print("Event Created with ID: $eventId");

      // **Insert Additional Fields Based on Category**
      print("Insert Additional Fields Based on Category : ${selectedCategory.value}");
      if (selectedCategory.value == "Education") {
        await supabaseClient.from('event_tags').insert({
          'event_id': eventId,
          'tag_name': selectedTags.join(", "),
        });
        await supabaseClient.from('education_event_details').insert({
          'event_id': eventId.toString(),
          'age_group': selectedAgeGroup.value ?? "",
          'subject_focus': selectedSubjectFocus.value ?? "",
          'language_requirements': languageRequirementsController.text.trim(),
          'materials_needed': materialsNeededController.text,
        });
        print("createNewEvent 12 1");
      }
      else if (selectedCategory.value == "Health & Wellness") {
        await supabaseClient.from('event_tags').insert({
          'event_id': eventId,
          'tag_name': selectedTags.join(", "),
        });
        await supabaseClient.from('health_event_details').insert({
          'event_id': eventId,
          'type_of_service': selectedServices.join(", "),
          'medical_professional_required':
              selectedMedicalProfessional.value ?? "",
          'equipment_needed': equipmentNeeded.text.trim(),
          'medication_handling_guidelines': medicationGuidelines.text.trim(),
        });
        print("createNewEvent 12 2");
      }
      else if (selectedCategory.value == "Counseling") {
        await supabaseClient.from('event_tags').insert({
          'event_id': eventId,
          'tag_name': selectedTags.join(", "),
        });
        await supabaseClient.from('counselling_event_details').insert({
          'event_id': eventId,
          'counseling_type': selectedCounselingType.value ?? "",
          'session_format': selectedSessionFormat.value ?? "",
        });
        print("createNewEvent 12 3");
      }
      else if (selectedCategory.value == "Conservation") {
        await supabaseClient.from('event_tags').insert({
          'event_id': eventId,
          'tag_name': selectedTags.join(", "),
        });
        await supabaseClient.from('conservation_event_details').insert({
          'event_id': eventId,
          'activity_type': selectedActivityType.value ?? "",
          'tools_provided_needed': toolsProvided.text.trim(),
          'environmental_impact_description': environmentalImpact.text.trim(),
          'waste_disposal_plan': wasteDisposalPlan.text.trim(),
        });
        print("createNewEvent 12 4");
      }
      else if (selectedCategory.value == "Work With Elders") {
        await supabaseClient.from('event_tags').insert({
          'event_id': eventId,
          'tag_name': selectedTags.join(", "),
        });
        await supabaseClient.from('elders_event_details').insert({
          'event_id': eventId,
          'activity_type': selectedElderActivityType.value ?? "",
          'items_to_bring': itemsToBring.text.trim(),
          'wheelchair_accessible': wheelChairAccessible.value ?? "No",
        });
        print("createNewEvent 12 5");
      }
      else if (selectedCategory.value == "Work With Orphans") {
        await supabaseClient.from('event_tags').insert({
          'event_id': eventId,
          'tag_name': selectedTags.join(", "),
        });
        await supabaseClient.from('orphans_event_details').insert({
          'event_id': eventId,
          'child_age_range': childAgeRange.text.trim(),
          'activity_type': selectedOrphanActivityType.value ?? "",
          'donation_needs': donationNeeds.text.trim(),
        });
        print("createNewEvent 12 6");
      }
      else if (selectedCategory.value == "Animal Rescue") {
        await supabaseClient.from('event_tags').insert({
          'event_id': eventId,
          'tag_name': selectedTags.join(", "),
        });
        await supabaseClient.from('animal_rescue_event_details').insert({
          'event_id': eventId,
          'animal_type': selectedAnimalType.value ?? "",
          'tasks_involved': selectedTaskInvolved.value ?? "",
          'vaccination_status_disclosure': vaccinationStatus.text.trim(),
          'handling_equipment': handlingEquipment.text.trim(),
        });
        print("createNewEvent 12 7");
      }
      else if (selectedCategory.value == "Cleaning") {
        await supabaseClient.from('event_tags').insert({
          'event_id': eventId,
          'tag_name': selectedTags.join(", "),
        });
        await supabaseClient.from('clean_event_details').insert({
          'event_id': eventId,
          'area_type': selectedAreaType.value ?? "",
          'waste_category': selectedWasteCategory.value ?? "",
          'recycling_plan_description': recyclingPlan.text.trim(),
        });
        print("createNewEvent 12 8");
      }

      print("Event created successfully!");
      Get.back();
      Get.bottomSheet(
        Container(
          height: double.infinity,
          width: double.infinity,
          decoration: BoxDecoration(
            color: appTheme.gray800,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Lottie.asset(
                ImageConstant.uploadSuccessAnimationLottie,
              ),
            ],
          ),
        ),
        isDismissible: false,
      );
      resetFields(); // Reset fields after successful creation
      return true;
    } catch (e) {
      Get.back();
      print("Error creating event: $e");

      return false;
    } finally {}
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
    volunteerController.dispose();
    socialMediaController.dispose();
    languageRequirementsController.dispose();
    equipmentNeeded.dispose();
    medicationGuidelines.dispose();
    toolsProvided.dispose();
    environmentalImpact.dispose();
    wasteDisposalPlan.dispose();
    itemsToBring.dispose();
    childAgeRange.dispose();
    donationNeeds.dispose();
    vaccinationStatus.dispose();
    handlingEquipment.dispose();
    recyclingPlan.dispose();
    materialsNeededController.dispose();
    emergencyContactController.dispose();
    super.onClose();
  }
}
