import 'package:volco/core/app_export.dart';
import 'package:volco/presentation/home_screen/binding/home_binding.dart';
import 'package:volco/presentation/home_screen/home_screen.dart';
import 'package:volco/presentation/let_s_you_in_screen/binding/let_s_you_in_binding.dart';
import 'package:volco/presentation/let_s_you_in_screen/let_s_you_in_screen.dart';
import 'package:volco/presentation/onboarding_one_screen/binding/onboarding_one_binding.dart';
import 'package:volco/presentation/onboarding_one_screen/controller/onboading_one_controller.dart';
import 'package:volco/presentation/onboarding_one_screen/onboading_one_screen.dart';
import 'package:volco/presentation/onboarding_three_screen/binding/onboarding_three_binding.dart';
import 'package:volco/presentation/onboarding_three_screen/onboading_three_screen.dart';
import 'package:volco/presentation/onboarding_two_screen/binding/onboarding_two_binding.dart';
import 'package:volco/presentation/onboarding_two_screen/onboading_two_screen.dart';
import 'package:volco/presentation/sign_in_screen/binding/sign_in_binding.dart';
import 'package:volco/presentation/sign_in_screen/sign_in_screen.dart';
import 'package:volco/presentation/splash_screen/binding/splash_binding.dart';
import 'package:volco/presentation/splash_screen/splash_screen.dart';
import 'package:volco/presentation/user_details_screen/binding/user_details_binding.dart';
import 'package:volco/presentation/user_details_screen/user_details_screen.dart';
import 'package:volco/presentation/welcome_screen/binding/welcome_binding.dart';
import 'package:volco/presentation/welcome_screen/welcome_screen.dart';

class AppRoutes {
  static const String splashScreen = '/splash_screen';

  static const String initialRoute = '/initialRoute';

  static const String welcomeScreen = '/welcome_screen';

  static const String onboardingOneScreen = '/onboarding_one_screen';

  static const String onboardingTwoScreen = '/onboarding_two_screen';

  static const String onboardingThreeScreen = '/onboading_three_screen';

  static const String letsYouInScreen = '/lets_you_in_screen';

  static const String signInScreen = '/sign_in_screen';

  static const String signUpScreen = '/sign_up_screen';

  static const String homeScreen = '/home_screen';

  static const String homeScreenInitialPage = '/home_screen_initial_page';

  static const String userDetailsScreen = '/user_details_screen';


  static List<GetPage> pages = [
    GetPage(
        name: splashScreen,
        page: () => SplashScreen(),
        bindings: [SplashBinding()]
    , ),


    GetPage(
        name: welcomeScreen,
        page: () => WelcomeScreen(),
        bindings: [WelcomeBinding()]
    ,  ),

    GetPage(
        name: onboardingOneScreen,
        page: () => OnboadingOneScreen(),
        bindings: [OnboardingOneBinding()]
    , ),

    GetPage(
        name: onboardingTwoScreen,
        page: () => OnboadingTwoScreen(),
        bindings: [OnboardingTwoBinding()]
    , ),

    GetPage(
        name: onboardingThreeScreen,
        page: () => OnboadingThreeScreen(),
        bindings: [OnboardingThreeBinding()]
    ,  ),

 GetPage(
        name: letsYouInScreen,
        page: () => LetSYouInScreen(),
        bindings: [LetsYouInBindings()]
 ,  ),
 GetPage(
        name: signInScreen,
        page: () => SignInScreen(),
        bindings: [SignInBinding()]
 ,  ),
    GetPage(
        name: homeScreen,
        page: () => HomeScreen(),
        bindings: [HomeBinding()]
    ,  ),
    GetPage(
        name: userDetailsScreen,
        page: () => UserDetailsScreen(),
        bindings: [UserDetailsBinding()]
    ,  ),


    GetPage(
        name: initialRoute,
        page: () => SplashScreen(),
        bindings: [SplashBinding()]
    ,  )
  ];
}
