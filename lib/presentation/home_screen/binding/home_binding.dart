import 'package:volco/core/app_export.dart';
import 'package:volco/presentation/home_screen/controller/home_controller.dart';
import 'package:volco/presentation/let_s_you_in_screen/controller/let_s_you_in_controller.dart';



class HomeBinding extends Bindings{
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut(()=>HomeController());
  }
}