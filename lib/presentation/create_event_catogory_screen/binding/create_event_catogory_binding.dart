import 'package:volco/core/app_export.dart';
import 'package:volco/presentation/create_event_catogory_screen/controller/create_event_catogory_controller.dart';
import 'package:volco/presentation/let_s_you_in_screen/controller/let_s_you_in_controller.dart';
import 'package:volco/presentation/sign_in_screen/controller/sign_in_controller.dart';
import 'package:volco/presentation/user_details_screen/controller/user_details_controller.dart';



class CreateEventCatogoryBinding extends Bindings{
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut(()=>CreateEventCatogoryController());
  }
}