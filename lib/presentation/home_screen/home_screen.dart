import 'package:flutter/material.dart';
import 'package:volco/core/app_export.dart';
import 'package:volco/presentation/home_screen/controller/home_controller.dart';
import 'package:volco/presentation/home_screen/home_screen_initial_page.dart';
import 'package:volco/presentation/home_screen/controller/home_controller.dart';
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
          Get.toNamed(getCurrentRoute(type), id: 1);
        },
      ),
    );
  }

  ///Handling route based on bottom click actions
  String getCurrentRoute(BottomBarEnum type) {
    switch (type) {
      case BottomBarEnum.Home:
        return AppRoutes.homeScreenInitialPage;
      // case BottomBarEnum.Search:
      //   return AppRoutes.searchPage;
      // case BottomBarEnum.Booking:
      //   return AppRoutes.bookingCompletedPage;
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
      // case AppRoutes.searchPage:
      //   return SearchPage();
      // case AppRoutes.bookingCompletedPage:
      //   return BookingCompletedPage();
      // case AppRoutes.profileSettingsPage:
      //   return ProfileSettingsPage();
      default:
        return DefaultWidget();
    }
  }
}
