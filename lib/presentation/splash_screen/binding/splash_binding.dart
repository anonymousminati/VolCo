import 'package:volco/core/app_export.dart';
import 'package:volco/presentation/splash_screen/controller/splash_controller.dart';


class SplashBinding extends Bindings{
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut(()=>SplashController());
  }
}