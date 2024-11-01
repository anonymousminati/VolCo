import 'package:volco/core/app_export.dart';
import 'package:volco/presentation/welcome_screen/controller/welcome_controller.dart';


class WelcomeBinding extends Bindings{
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut(()=>WelcomeController());
  }
}