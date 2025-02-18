import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:volco/core/app_export.dart';
import 'package:volco/core/utils/image_constant.dart';
import 'package:volco/core/utils/validation_functions.dart';
import 'package:volco/presentation/create_event_screen/controller/create_event_controller.dart';
import 'package:volco/presentation/create_event_screen/widgets/eventFields.dart';
import 'package:volco/presentation/volunteer_registration_screen/controller/volunteer_registration_controller.dart';
import 'package:volco/widgets/CustomDropdownField.dart';
import 'package:volco/widgets/customMultiSelectDropdown.dart';
import 'package:volco/widgets/custom_image_picker.dart';

class VolunteerRegistrationScreen
    extends GetView<VolunteerRegistrationController> {
  /// The selected activity category passed from the previous screen.

  final int eventId;

  VolunteerRegistrationScreen({Key? key, required this.eventId})
      : super(key: key){
    controller.updateEventId(eventId);
  }
  GlobalKey<FormState> _volunteerEventRegistrationformKey =
      GlobalKey<FormState>(debugLabel: '_volunteerEventRegistrationformKey');

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: Obx(() {
            if (controller.isLoading.value) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return RefreshIndicator(
                onRefresh: ()async{
                  controller.updateEventId(eventId);
                  print("Refreshed");
                },
                child: Form(
                  key: _volunteerEventRegistrationformKey,
                  child: SizedBox(
                    width: double.maxFinite,
                    child: SingleChildScrollView(
                      child: Container(
                        width: double.maxFinite,
                        padding: EdgeInsets.only(
                          left: 24.h,
                          right: 24.h,
                          top: 10.h,
                        ),
                        child:
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 24),

                            // Title
                            Text(
                              "Join the Movement!",
                              style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),

                            SizedBox(height: 24),

                            _buildEventRegistrationFormSection(),

                            SizedBox(height: 24),

                            // Submit Button
                            CustomElevatedButton(
                              text: "Register",
                              onPressed: () async {
                                if (_volunteerEventRegistrationformKey
                                    .currentState!
                                    .validate()) {
                                  if (!controller
                                      .termsAndConditionsAccept.value) {
                                    Get.snackbar("Error",
                                        "You must accept the Terms and Conditions.");
                                    return;
                                  }

                                  bool response =
                                  await controller.registerVolunteer();
                                  if (response) {
                                    Get.snackbar("Success",
                                        "You have successfully registered!");
                                    Get.offAllNamed(AppRoutes.homeScreen);
                                  } else {
                                    Get.snackbar("Error",
                                        "Registration failed. Please try again.");
                                  }
                                }
                              },
                            ),

                            SizedBox(height: 24),
                            CustomElevatedButton(
                              text: "regis 2",
                              onPressed: () async {
                                controller.updateEventId(eventId);
                                print("Refreshed");
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              );
            }
          })),
    );
  }


  Widget _buildCustomCheckbox(
      {required String title,
      required bool value,
      required Function(bool?) onChanged}) {
    return CheckboxListTile(
      activeColor: Colors.blue,
      checkColor: Colors.white,
      title: Text(title, style: TextStyle(color: Colors.white, fontSize: 16)),
      checkboxShape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(2),
        side: BorderSide(color: Colors.white, width: 2),
      ),
      value: value,
      onChanged: onChanged,
      controlAffinity: ListTileControlAffinity.leading,
      contentPadding: EdgeInsets.symmetric(horizontal: 12),
    );
  }

  Widget _buildEventRegistrationFormSection() {
    return SizedBox(
      width: double.maxFinite,
      child: Column(
        spacing: 20.h,
        children: [

          // Emergency Contact
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 10.h,
              children: [
                Text("Emergency Contact",
                    style: TextStyle(color: Colors.white)),
                CustomTextFormField(
                  controller: controller.emergencyContactController,
                  hintText: "Enter emergency contact",
                  validator: (value) {
                    if (!isValidPhone(value)) {
                      return "Please enter a valid phone number";
                    }
                    return null;
                  },
                ),
              ],
            ),
          ),
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 10.h,
              children: [
                Text("Preferred Communication",
                    style: TextStyle(color: Colors.white)),
                CustomSelectDropdown(
                  hintText: 'Select communication method',
                  options: ["Call", "SMS", "Email"],
                  onChanged: (value) {
                    controller.preferredCommunication.value = value!;
                  },
                ),
              ],
            ),
          ),

          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 10.h,
              children: [
                Text("Do you have any medical conditions?",
                    style: TextStyle(color: Colors.white)),
                CustomSelectDropdown(
                  hintText: 'Select an option',
                  options: ["Yes", "No"],
                  onChanged: (value) {
                    controller.hasMedicalConditions.value =value!;
                  },
                ),
              ],
            ),
          ),
          // Medical Conditions Dropdown

          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 10.h,
              children: [
                Text("Do you need any special assistance?",
                    style: TextStyle(color: Colors.white)),
                CustomSelectDropdown(
                  hintText: 'Select an option',
                  options: ["Yes", "No"],
                  onChanged: (value) {
                    controller.needsAssistance.value =  value!;
                  },
                ),
              ],
            ),
          ),
          // Needs Assistance Dropdown

          // Additional Notes
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 10.h,
              children: [
                Text("Additional Notes (Allergies, special needs, etc.)",
                    style: TextStyle(color: Colors.white)),
                CustomTextFormField(
                  controller: controller.additionalNotesController,
                  hintText: "Enter details",
                  maxLines: 4,
                ),
              ],
            ),
          ),

          // Terms & Conditions Checkbox
          Obx(() => CheckboxListTile(
                activeColor: Colors.blue,
                checkColor: Colors.white,
                title: Text("I accept the Terms & Conditions",
                    style: TextStyle(color: Colors.white)),
                checkboxShape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                  side: BorderSide(color: Colors.white, width: 2),
                ),
                value: controller.termsAndConditionsAccept.value,
                onChanged: (value) {
                  controller.termsAndConditionsAccept.value = value!;
                },
                controlAffinity: ListTileControlAffinity.leading,
                contentPadding: EdgeInsets.symmetric(horizontal: 12),
              )),
        ],
      ),
    );
  }
}
