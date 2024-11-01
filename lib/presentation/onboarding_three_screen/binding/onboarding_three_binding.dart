import 'package:volco/core/app_export.dart';
import 'package:volco/presentation/onboarding_one_screen/controller/onboading_one_controller.dart';
import 'package:volco/presentation/onboarding_three_screen/controller/onboading_three_controller.dart';
import 'package:volco/presentation/onboarding_two_screen/controller/onboading_two_controller.dart';
import 'package:volco/presentation/welcome_screen/controller/welcome_controller.dart';


class OnboardingThreeBinding extends Bindings{
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut(()=>OnboadingThreeController());
  }
}