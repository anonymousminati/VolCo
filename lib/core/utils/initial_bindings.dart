

import 'package:volco/core/app_export.dart';

class InitialBindings extends Bindings{

@override
  void dependencies() {
    // TODO: implement dependencies
  Get.put(PrefUtils.instance);

  }
}