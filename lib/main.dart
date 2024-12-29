import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:volco/core/app_export.dart';
import 'package:volco/core/utils/logger.dart';
import 'package:volco/core/utils/project_constants.dart';
import 'package:volco/presentation/splash_screen/splash_screen.dart';
import 'package:volco/routes/app_routes.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: PROJECT_URL,
    anonKey: PROJECT_ANON_KEY,
    authOptions: FlutterAuthClientOptions(authFlowType: AuthFlowType.pkce),
    realtimeClientOptions: const RealtimeClientOptions(
      eventsPerSecond: 2,
    ),
  );

  SupabaseHandler()
      .client
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

  Future<void> fetchUser() async {
    final SupabaseClient _supabaseClient = Supabase.instance.client;

    final response = await _supabaseClient.from('profiles').select();
    print("reponse from users tables: $response");
  }

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
