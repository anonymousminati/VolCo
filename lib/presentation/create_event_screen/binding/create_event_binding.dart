import 'package:volco/core/app_export.dart';
import 'package:volco/presentation/create_event_screen/controller/create_event_controller.dart';



class CreateEventBinding extends Bindings{
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut(()=>CreateEventController());
  }
}