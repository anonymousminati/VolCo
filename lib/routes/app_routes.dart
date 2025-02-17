import 'package:volco/core/app_export.dart';
import 'package:volco/presentation/avatar_capture_screen/avatar_capture_screen.dart';
import 'package:volco/presentation/avatar_capture_screen/binding/avatar_capture_binding.dart';
import 'package:volco/presentation/create_event_catogory_screen/binding/create_event_catogory_binding.dart';
import 'package:volco/presentation/create_event_catogory_screen/create_event_catogory_screen.dart';
import 'package:volco/presentation/create_event_screen/binding/create_event_binding.dart';
import 'package:volco/presentation/create_event_screen/create_event_screen.dart';
import 'package:volco/presentation/event_description_screen/binding/event_description_binding.dart';
import 'package:volco/presentation/event_description_screen/event_description_screen.dart';
import 'package:volco/presentation/forgot_password_screen/binding/forgot_password_binding.dart';
import 'package:volco/presentation/forgot_password_screen/forgot_password_screen.dart';
import 'package:volco/presentation/home_screen/binding/home_binding.dart';
import 'package:volco/presentation/home_screen/home_screen.dart';
import 'package:volco/presentation/home_screen/home_screen_initial_page.dart';
import 'package:volco/presentation/let_s_you_in_screen/binding/let_s_you_in_binding.dart';
import 'package:volco/presentation/let_s_you_in_screen/let_s_you_in_screen.dart';
import 'package:volco/presentation/onboarding_one_screen/binding/onboarding_one_binding.dart';
import 'package:volco/presentation/onboarding_one_screen/controller/onboading_one_controller.dart';
import 'package:volco/presentation/onboarding_one_screen/onboading_one_screen.dart';
import 'package:volco/presentation/onboarding_three_screen/binding/onboarding_three_binding.dart';
import 'package:volco/presentation/onboarding_three_screen/onboading_three_screen.dart';
import 'package:volco/presentation/onboarding_two_screen/binding/onboarding_two_binding.dart';
import 'package:volco/presentation/onboarding_two_screen/onboading_two_screen.dart';
import 'package:volco/presentation/reset_password_screen/binding/reset_password_binding.dart';
import 'package:volco/presentation/reset_password_screen/reset_password_screen.dart';
import 'package:volco/presentation/sign_in_screen/binding/sign_in_binding.dart';
import 'package:volco/presentation/sign_in_screen/sign_in_screen.dart';
import 'package:volco/presentation/sign_up_screen/binding/sign_up_binding.dart';
import 'package:volco/presentation/sign_up_screen/sign_up_screen.dart';
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

  static const String avatarCaptureScreen = '/avatar_capture_screen';

  static const String forgotPasswordScreen = '/forgot_password_screen';

  static const String resetPasswordScreen = '/reset_password_screen';

  static const String createEventCatogoryScreen =
      '/create_event_catogory_screen';
  static const String createEventScreen = '/create_event_screen';

  static const String eventDescriptionScreen = '/event_description_screen';

  static const String searchScreen = '/search_screen';



  static List<GetPage> pages = [
    GetPage(
      name: splashScreen,
      page: () => SplashScreen(),
      bindings: [SplashBinding()],
    ),

    GetPage(
      name: welcomeScreen,
      page: () => WelcomeScreen(),
      bindings: [WelcomeBinding()],
    ),

    GetPage(
      name: onboardingOneScreen,
      page: () => OnboadingOneScreen(),
      bindings: [OnboardingOneBinding()],
    ),

    GetPage(
      name: onboardingTwoScreen,
      page: () => OnboadingTwoScreen(),
      bindings: [OnboardingTwoBinding()],
    ),

    GetPage(
      name: onboardingThreeScreen,
      page: () => OnboadingThreeScreen(),
      bindings: [OnboardingThreeBinding()],
    ),

    GetPage(
      name: letsYouInScreen,
      page: () => LetSYouInScreen(),
      bindings: [LetsYouInBindings()],
    ),
    GetPage(
      name: signInScreen,
      page: () => SignInScreen(),
      bindings: [SignInBinding()],
    ),
    GetPage(
      name: homeScreenInitialPage,
      page: () => HomeScreenInitialPage(),
      bindings: [HomeBinding()],
    ),
    GetPage(
      name: homeScreen,
      page: () => HomeScreen(),
      bindings: [HomeBinding()],
    ),
    GetPage(
      name: userDetailsScreen,
      page: () => UserDetailsScreen(),
      bindings: [UserDetailsBinding()],
    ),
    GetPage(
      name: avatarCaptureScreen,
      page: () => AvatarCaptureScreen(),
      bindings: [AvatarCaptureBinding()],
    ),

    GetPage(
      name: forgotPasswordScreen,
      page: () => ForgotPasswordScreen(),
      bindings: [ForgotPasswordBinding()],
    ),
    GetPage(
      name: resetPasswordScreen,
      page: () => ResetPasswordScreen(),
      bindings: [ResetPasswordBinding()],
    ),

    GetPage(
      name: initialRoute,
      page: () => SplashScreen(),
      bindings: [SplashBinding()],
    ),

    //create for signup screen
    GetPage(
      name: signUpScreen,
      page: () => SignUpScreen(),
      bindings: [SignUpBinding()],
    ),
    GetPage(
      name: createEventCatogoryScreen,
      page: () => CreateEventCatogoryScreen(),
      bindings: [CreateEventCatogoryBinding()],
    ),
    GetPage(
      name: createEventScreen,
      page: () {
        final String categoryType = Get.arguments['categoryType'] ?? "";

        return CreateEventScreen(categoryType: categoryType);
      },
      bindings: [CreateEventBinding()],
    ),
    GetPage(
      name: eventDescriptionScreen,
      page: () {
        final String selectedActivityCategory =
            Get.arguments['eventCategory'] ?? "";
        final int eventCreatedId = Get.arguments['eventCreatedId'] ?? 0;
        final bool isForRegister = Get.arguments['isForRegister'] ?? false;
        return EventDescriptionScreen(
            selectedActivityCategory: selectedActivityCategory,
            eventCreatedId: eventCreatedId,
            isForRegistration: isForRegister);
        },
      bindings: [EventDescriptionBinding()],
    ),
  ];
}
