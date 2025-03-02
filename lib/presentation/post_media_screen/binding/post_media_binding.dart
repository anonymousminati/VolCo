import 'package:volco/core/app_export.dart';
import 'package:volco/presentation/post_media_screen/controller/post_media_controller.dart';
import 'package:volco/presentation/search_screen/controller/search_controller.dart';



class PostMediaBinding extends Bindings{
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut(()=>PostMediaController());
  }
}