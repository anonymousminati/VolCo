import 'package:volco/core/app_export.dart';
import 'package:volco/presentation/onboarding_one_screen/controller/onboading_one_controller.dart';
import 'package:volco/presentation/welcome_screen/controller/welcome_controller.dart';


class OnboardingOneBinding extends Bindings{
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut(()=>OnboadingOneController());
  }
}