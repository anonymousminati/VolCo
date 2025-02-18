import 'package:volco/core/app_export.dart';
import 'package:volco/presentation/create_event_screen/controller/create_event_controller.dart';
import 'package:volco/presentation/volunteer_registration_screen/controller/volunteer_registration_controller.dart';



class VolunteerRegistrationBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(()=>VolunteerRegistrationController());
  }
}