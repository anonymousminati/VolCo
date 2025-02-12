import 'package:volco/core/app_export.dart';
import 'package:volco/presentation/create_event_screen/controller/create_event_controller.dart';
import 'package:volco/presentation/event_description_screen/controller/event_description_controller.dart';



class EventDescriptionBinding extends Bindings{
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut(()=>EventDescriptionController());
  }
}