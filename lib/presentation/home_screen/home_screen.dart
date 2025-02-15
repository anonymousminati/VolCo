import 'package:flutter/material.dart';
import 'package:volco/core/app_export.dart';
import 'package:volco/presentation/create_event_catogory_screen/create_event_catogory_screen.dart';
import 'package:volco/presentation/home_screen/controller/home_controller.dart';
import 'package:volco/presentation/home_screen/home_screen_initial_page.dart';
import 'package:volco/presentation/search_screen/search_screen.dart';
import 'package:volco/widgets/custom_bottom_bar.dart';


class HomeScreen extends GetWidget<HomeController> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Navigator(
          key: Get.nestedKey(1),
          initialRoute: AppRoutes.homeScreenInitialPage,
          onGenerateRoute: (routeSetting) => GetPageRoute(
            page: () => getCurrentPage(routeSetting.name!),
            transition: Transition.noTransition,
          ),
        ),
        bottomNavigationBar: SizedBox(
          width: double.maxFinite,
          child: _buildBottomNavigationBar(),
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildBottomNavigationBar() {
    return SizedBox(
      width: double.maxFinite,
      child: CustomBottomBar(
        onChanged: (BottomBarEnum type) {
          Get.offNamed(getCurrentRoute(type), id: 1);
        },
      ),
    );
  }

  ///Handling route based on bottom click actions
  String getCurrentRoute(BottomBarEnum type) {
    switch (type) {
      case BottomBarEnum.Home:
        return AppRoutes.homeScreenInitialPage;
      case BottomBarEnum.Search:
        return AppRoutes.searchScreen;
      case BottomBarEnum.Create:
        return AppRoutes.createEventCatogoryScreen;
      // case BottomBarEnum.Profile:
      //   return AppRoutes.profileSettingsPage;
      default:
        return "/";
    }
  }

  ///Handling page based on route
  Widget getCurrentPage(String currentRoute) {
    switch (currentRoute) {
      case AppRoutes.homeScreenInitialPage:
        return HomeScreenInitialPage();
      case AppRoutes.searchScreen:
        return SearchScreen();
      case AppRoutes.createEventCatogoryScreen:
        return CreateEventCatogoryScreen();
      // case AppRoutes.profileSettingsPage:
      //   return ProfileSettingsPage();
      default:
        return DefaultWidget();
    }
  }
}
