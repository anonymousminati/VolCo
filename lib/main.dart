import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:volco/core/app_export.dart';
import 'package:volco/core/utils/logger.dart';
import 'package:volco/presentation/splash_screen/splash_screen.dart';
import 'package:volco/routes/app_routes.dart';
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then((value){

    Logger.init(kReleaseMode ? LogMode.live: LogMode.debug);
    runApp(const MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context,orientation,deviceType){
      return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: AppRoutes.initialRoute,
        getPages: AppRoutes.pages,
        title: 'Volco',
        theme: theme,
        navigatorKey: null,

      );


  });}
}
