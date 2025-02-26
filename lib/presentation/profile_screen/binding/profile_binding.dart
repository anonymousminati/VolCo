import 'package:volco/core/app_export.dart';
import 'package:volco/presentation/profile_screen/controller/profile_controller.dart';
import 'package:volco/presentation/search_screen/controller/search_controller.dart';



class ProfileBinding extends Bindings{
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut(()=>ProfileController());
  }
}