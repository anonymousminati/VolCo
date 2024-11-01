import 'package:flutter/material.dart';
import 'package:volco/core/app_export.dart';
import 'package:volco/core/utils/image_constant.dart';

enum BottomBarEnum { Home, Search, Booking, Profile }

class CustomBottomBar extends StatelessWidget {
  CustomBottomBar({super.key, this.onChanged});

  RxInt selectedIndex = 0.obs;
  List<BottomMenuModel> bottomMenuList = [
    BottomMenuModel(
      icon: ImageConstant.imgHomeWhite,
      activeIcon: ImageConstant.imgHomeSkyBlue,
      title: "home".tr,
      type: BottomBarEnum.Home,
    ),
    BottomMenuModel(
      icon: ImageConstant.imgSearchWhite,
      activeIcon: ImageConstant.imgSearchContrast,
      title: "search".tr,
      type: BottomBarEnum.Search,
    ),
    BottomMenuModel(
      icon: ImageConstant.imgNoteWhite,
      activeIcon: ImageConstant.imgNoteSkyBlue,
      title: "booking".tr,
      type: BottomBarEnum.Booking,
    ),
    BottomMenuModel(
      icon: ImageConstant.imgProfileWhite,
      activeIcon: ImageConstant.imgProfileSkyBlue,
      title: "profile".tr,
      type: BottomBarEnum.Profile,
    )
  ];

  Function(BottomBarEnum)? onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0XFF0E1010),
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(16.h),
        ),
      ),
      child: Obx(() => BottomNavigationBar(
            backgroundColor: Colors.transparent,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            selectedFontSize: 0,
            elevation: 0,
            currentIndex: selectedIndex.value,
            type: BottomNavigationBarType.fixed,
            items: List.generate(bottomMenuList.length, (index) {
              return BottomNavigationBarItem(
                icon: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CustomImageView(
                      imagePath: bottomMenuList[index].icon,
                      height: 24.h,
                      width: 24.h,
                      color: Color(0XFFC8CCCC),
                    ),
                    Text(
                      bottomMenuList[index].title ?? "",
                      style: CustomTextStyles.labelMediumBluegray100.copyWith(
                        color: Color(0XFFC8CCCC),
                      ),
                    )
                  ],
                ),
                activeIcon: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CustomImageView(
                      imagePath: bottomMenuList[index].activeIcon,
                      height: 24.h,
                      width: 24.h,
                      color: Color(0XFFC8CCCC),
                    ),
                    Text(
                      bottomMenuList[index].title ?? "",
                      style: CustomTextStyles.labelMediumBluegray100.copyWith(
                        color: Color(0XFF1AADB6),
                      ),
                    )
                  ],
                ),
                label: '',
              );
            }),
            onTap: (index) {
              selectedIndex.value = index;
              onChanged?.call(bottomMenuList[index].type);
            },
          )),
    );
  }
}

class BottomMenuModel {
  BottomMenuModel({
    required this.icon,
    required this.activeIcon,
    this.title,
    required this.type,
  });

  String icon;
  String activeIcon;
  String? title;
  BottomBarEnum type;
}

class DefaultWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        color: Color(0xffffffff),
        padding: EdgeInsets.all(10),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Please replace the respective Widget here',
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
            ],
          ),
        ));
  }
}
