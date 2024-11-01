import 'package:volco/core/app_export.dart';
import 'package:volco/presentation/let_s_you_in_screen/controller/let_s_you_in_controller.dart';
import 'package:volco/presentation/sign_in_screen/controller/sign_in_controller.dart';



class SignInBinding extends Bindings{
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut(()=>SignInController());
  }
}