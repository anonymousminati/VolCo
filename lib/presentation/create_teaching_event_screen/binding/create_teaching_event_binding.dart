import 'package:volco/core/app_export.dart';
import 'package:volco/presentation/create_teaching_event_screen/controller/create_teaching_event_controller.dart';



class CreateTeachingEventBinding extends Bindings{
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut(()=>CreateTeachingEventController());
  }
}