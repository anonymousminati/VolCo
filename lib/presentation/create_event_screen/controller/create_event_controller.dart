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
  // **📌 Common Event Fields**
  final eventNameController = TextEditingController();
  final eventDescriptionController = TextEditingController();
  final durationController = TextEditingController();
  final mobileNumberController = TextEditingController();
  final locationController = TextEditingController();
  final skillsController = TextEditingController();
  final ageController = TextEditingController();
  final volunteerController = TextEditingController();
  final socialMediaController = TextEditingController();
  // **📌 Image Picker & Date-Time Fields**
  Rxn<XFile> pickedImage = Rxn<XFile>();
  Rxn<DateTime> selectedDate = Rxn<DateTime>();
  Rxn<TimeOfDay> selectedTime = Rxn<TimeOfDay>();
  RxString selectedCategory = ''.obs;
  RxList<String> selectedTags = <String>[].obs;

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
  var materialsNeeded = "".obs;

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
      futures.add(loadEducationAgeGroups());
      futures.add(loadEducationSubjectFocus());
    } else if (type == "Health & Wellness") {
      futures.add(loadHealthServicesType());
      futures.add(loadHealthMedicalProfessionals());
    } else if (type == "Counseling") {
      futures.add(loadCounselingTypes());
      futures.add(loadCounselingSessionFormats());
    } else if (type == "Conservation") {
      futures.add(loadConservationActivityTypes());
    } else if (type == "Work with Elders") {
      futures.add(loadElderActivityTypes());
    } else if (type == "Work with Orphans") {
      futures.add(loadOrphanActivityTypes());
    } else if (type == "Animal Rescue") {
      futures.add(loadAnimalTypes());
      futures.add(loadTaskInvolved());
    } else if (type == "Clean Activity") {
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

  /// **📌 Reset All Fields When Switching Activities**
  void resetFields() {
    selectedAgeGroup.value = null;
    selectedSubjectFocus.value = null;
    languageRequirementsController.text="";
    materialsNeeded.value = "";

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
    ageGroups.value = await supabaseService.fetchEventFieldOptions('education', 'age_group');
    print("ageGroups: $ageGroups");
  }

  Future<void> loadEducationSubjectFocus() async {
    subjectFocus.value = await supabaseService.fetchEventFieldOptions('education', 'subject_focus');
    print("subjectFocus: $subjectFocus");
  }

  // ** Health & Wellness Loaders **
  Future<void> loadHealthServicesType() async {
    typeOfServices.value = await supabaseService.fetchEventFieldOptions('health_and_wellness', 'type_of_service');
    print("typeOfServices: $typeOfServices");
  }

  Future<void> loadHealthMedicalProfessionals() async {
    medicalProfessionalList.value = await supabaseService.fetchEventFieldOptions('health_and_wellness', 'medical_professional_required');
    print("medicalProfessionalList: $medicalProfessionalList");
  }

  // ** Counseling Loaders **
  Future<void> loadCounselingTypes() async {
    counselingTypes.value = await supabaseService.fetchEventFieldOptions('counseling', 'counseling_type');
    print("counselingTypes: $counselingTypes");
  }

  Future<void> loadCounselingSessionFormats() async {
    sessionFormats.value = await supabaseService.fetchEventFieldOptions('counseling', 'session_format');
    print("sessionFormats: $sessionFormats");
  }

  // ** Conservation Loader **
  Future<void> loadConservationActivityTypes() async {
    conservationActivityTypes.value = await supabaseService.fetchEventFieldOptions('conservation', 'activity_type');
    print("conservationActivityTypes: $conservationActivityTypes");
  }

  // ** Work with Elders Loader **
  Future<void> loadElderActivityTypes() async {
    elderActivityTypes.value = await supabaseService.fetchEventFieldOptions('work_with_elders', 'activity_type');
    print("elderActivityTypes: $elderActivityTypes");
  }

  // ** Work with Orphans Loader **
  Future<void> loadOrphanActivityTypes() async {
    orphanActivityTypes.value = await supabaseService.fetchEventFieldOptions('work_with_orphans', 'activity_type');
    print("orphanActivityTypes: $orphanActivityTypes");
  }

  // ** Animal Rescue Loaders **
  Future<void> loadAnimalTypes() async {
    animalTypes.value = await supabaseService.fetchEventFieldOptions('animal_rescue', 'animal_type');
    print("animalTypes: $animalTypes");
  }

  Future<void> loadTaskInvolved() async {
    taskInvolved.value = await supabaseService.fetchEventFieldOptions('animal_rescue', 'task_involved');
    print("taskInvolved: $taskInvolved");
  }

  // ** Clean Activity Loaders **
  Future<void> loadAreaTypes() async {
    areaTypes.value = await supabaseService.fetchEventFieldOptions('clean_activity', 'area_type');
    print("areaTypes: $areaTypes");
  }

  Future<void> loadWasteCategories() async {
    wasteCategories.value = await supabaseService.fetchEventFieldOptions('clean_activity', 'waste_category');
    print("wasteCategories: $wasteCategories");
  }

  /// **📌 Create New Event**
  Future<bool> createEvent() async {
    try {
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

      // **📌 Upload Event Image**
      String? imageUrl;
      if (pickedImage.value != null) {
        imageUrl =
        await supabaseService.uploadImage(File(pickedImage.value!.path));
      } else {
        Get.snackbar("Error", "Please select an event image.");
        return false;
      }

      // **📌 Merge Date & Time**
      final DateTime date = selectedDate.value!;
      final TimeOfDay time = selectedTime.value!;
      final DateTime eventDateTime =
      DateTime(date.year, date.month, date.day, time.hour, time.minute);

      // **📌 Prepare Event Data**
      final Map<String, dynamic> eventData = {
        'organizer_id': supabaseClient.auth.currentUser?.id,
        'event_name': eventNameController.text.trim(),
        'event_description': eventDescriptionController.text.trim(),
        'image_url': imageUrl,
        'event_date': eventDateTime.toIso8601String(),
        'duration_hours': int.parse(durationController.text.trim()),
        'location': locationController.text.trim(),
        'contact_number': mobileNumberController.text.trim(),
        'activity_type': selectedCategory.value,
        'tags': selectedTags,
        'created_at': DateTime.now().toIso8601String(),
        'updated_at': DateTime.now().toIso8601String(),
      };

      // **📌 Insert Event Record**
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


    super.onClose();
  }
}
