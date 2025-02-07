import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:volco/core/app_export.dart';
import 'package:volco/core/utils/logger.dart';
import 'package:volco/core/utils/project_constants.dart';
import 'package:volco/presentation/home_screen/home_screen.dart';
import 'package:volco/presentation/let_s_you_in_screen/let_s_you_in_screen.dart';
import 'package:volco/presentation/splash_screen/splash_screen.dart';
import 'package:volco/routes/app_routes.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();


   SupabaseHandler().initialize(PROJECT_URL, PROJECT_ANON_KEY);

  Get.put(AuthController());
  SupabaseHandler()
      .supabaseClient
      .channel('profiles')
      .onPostgresChanges(
          schema: "public",
          event: PostgresChangeEvent.all,
          callback: (payload) {
            print("Postgres changes: $payload");
          })
      .subscribe();


  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then(
    (value) {
      Logger.init(kReleaseMode ? LogMode.live : LogMode.debug);
      runApp(const MyApp());
    },
  );
}

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
  });



  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          initialRoute: AppRoutes.initialRoute,
          getPages: AppRoutes.pages,
          title: 'Volco',
          theme: theme,
          navigatorKey: null,

        );
      },
    );
  }
}

