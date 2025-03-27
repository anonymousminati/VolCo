import 'package:volco/core/app_export.dart';
import 'package:volco/presentation/saved_screen/controller/saved_controller.dart';
import 'package:volco/presentation/search_screen/controller/search_controller.dart';



class SavedBinding extends Bindings{
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut(()=>SavedController());
  }
}