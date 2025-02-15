import 'package:volco/core/app_export.dart';
import 'package:volco/presentation/search_screen/controller/search_controller.dart';



class SearchBinding extends Bindings{
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut(()=>SearchEventController());
  }
}