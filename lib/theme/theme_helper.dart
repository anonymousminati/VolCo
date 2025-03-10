import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:volco/core/app_export.dart';


LightCodeColors get appTheme => ThemeHelper().themeColor();
ThemeData get theme => ThemeHelper().themeData();

class ThemeHelper {
  var _appTheme = PrefUtils.instance.getThemeData();

  Map<String, LightCodeColors> _supportedCustomScheme = {
    'lightCode': LightCodeColors()
  };
  Map<String, ColorScheme> _supportedColorScheme = {
    'lightCode': ColorSchemes.lightCodeColorScheme
  };

  void changeTheme(String _newTheme) {
    PrefUtils.instance.setThemeData(_newTheme);
    Get.forceAppUpdate();
  }

  LightCodeColors _getThemeColors() {
    return _supportedCustomScheme[_appTheme] ?? LightCodeColors();
  }

  ThemeData _getThemeData() {
    var colorScheme =
        _supportedColorScheme[_appTheme] ?? ColorSchemes.lightCodeColorScheme;
    return ThemeData(
      visualDensity: VisualDensity.standard,
      colorScheme: colorScheme,
      textTheme: TextThemes.textTheme(colorScheme),
      scaffoldBackgroundColor: colorScheme.onPrimary,
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
              backgroundColor: colorScheme.primary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(26),
              ),
              elevation: 0,
              visualDensity: const VisualDensity(vertical: -4, horizontal: -4),
              padding: EdgeInsets.zero)),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          backgroundColor: Colors.transparent,
          side: BorderSide(
            color: colorScheme.primary,
            width: 2,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
          visualDensity: const VisualDensity(
            vertical: -4,
            horizontal: -4,
          ),
          padding: EdgeInsets.zero,
        ),
      ),
      dividerTheme: DividerThemeData(
        thickness: 1,
        space: 1,
        color: appTheme.gray700
      )
    );
  }

  LightCodeColors themeColor()=> _getThemeColors();

  ThemeData themeData() => _getThemeData();

}

class TextThemes {
  static TextTheme textTheme(ColorScheme colorScheme) => TextTheme(
    bodyLarge: TextStyle(
      color: appTheme.whiteA700,
      fontSize: 18.fSize,
      fontFamily: 'Urbanist',
      fontWeight: FontWeight.w400,

    ),
    bodyMedium: TextStyle(
      color: appTheme.gray400,
      fontSize: 14.fSize,
      fontFamily: 'Urbanist',
      fontWeight: FontWeight.w400,
    ),
    bodySmall: TextStyle(
      color: appTheme.gray400,
      fontSize: 12.fSize,
      fontFamily: 'Urbanist',
      fontWeight: FontWeight.w400,
    ),
    displayLarge: TextStyle(
      color: colorScheme.primary ,
      fontSize: 64.fSize,
      fontFamily: 'Urbanist',
      fontWeight: FontWeight.w900,
    ),
    displayMedium: TextStyle(
      color: appTheme.whiteA700,
      fontSize: 48.fSize,
      fontFamily: 'Urbanist',
      fontWeight: FontWeight.w700,
    ),
    headlineLarge: TextStyle(
      color: appTheme.whiteA700,
      fontSize: 32.fSize,
      fontFamily: 'Urbanist',
      fontWeight: FontWeight.w700,
    ),
    headlineSmall: TextStyle(
      color: appTheme.whiteA700,
      fontSize: 24.fSize,
      fontFamily: 'Urbanist',
      fontWeight: FontWeight.w700,
    ),
    labelLarge: TextStyle(
      color: appTheme.gray50,
      fontSize: 12.fSize,
      fontFamily: 'Urbanist',
      fontWeight: FontWeight.w700,
    ),
    labelMedium: TextStyle(
      color: appTheme.gray400,
      fontSize: 10.fSize,
      fontFamily: 'Urbanist',
      fontWeight: FontWeight.w500,
    ),
    titleLarge: TextStyle(
      color: appTheme.whiteA700,
      fontSize: 22.fSize,
      fontFamily: 'Urbanist',
      fontWeight: FontWeight.w700,
    ),
    titleMedium: TextStyle(
      color: appTheme.whiteA700,
      fontSize: 18.fSize,
      fontFamily: 'Urbanist',
      fontWeight: FontWeight.w700,
    ),
    titleSmall: TextStyle(
      color: appTheme.whiteA700,
      fontSize: 14.fSize,
      fontFamily: 'Urbanist',
      fontWeight: FontWeight.w700,
    ),
  );
}


class ColorSchemes{
  static final lightCodeColorScheme = ColorScheme.light(
      primary: Color(0XFF1AADB6),
      primaryContainer: Color(0X8F282828),
      errorContainer: Color(0XB2000000),
      onError: Color(0XFF9E9E9E),
      onErrorContainer: Color(0XFF003087) ,
      onPrimary: Color(0XFF181A20) ,
      onPrimaryContainer: Color(0XFFE7E9E9),
  );
}

class LightCodeColors{
  Color get amber500 =>  Color(0XFFFBBC05);
  // Black
  Color get black900 => Color (0XFF0E1010);
  Color get black90001 => Color (0XFF020E0F);
  // Blackc
  Color get black9000c => Color (0X0C04060F);
  // Blue
  Color get blueA200 => Color (0XFF4285F4);
  Color get blueA400 => Color (0XFF1877F2);
  // BlueGray
  Color get blueGray100 => Color (0XFFC8CCCC);
  Color get blueGray900 => Color (0XFF31343B);
  Color get blueGray90059 => Color (0X59353535);
  Color get blueGray90076 => Color (0X762E2E2E);
  // Cyan
  Color get cyan200 => Color (0XFF7BE6EC);
  Color get cyan300 => Color (0XFF46DBE5);
  Color get cyan500 => Color (0XFF00BCD3);

  Color get cyan600 =>Color (0XFF19ACB6);
  Color get cyan900 => Color (0XFF0F656A);
  // Gray
  Color get gray400 => Color (0XFFB8BDBD);
  Color get gray40001 => Color (0XFFB0B6B6);
  Color get gray50 => Color (0XFFFBFBFB);
  Color get gray500 => Color (0XFF919999);
  Color get gray5001 => Color (0XFFF7FCFF);
  Color get gray700 => Color (0XFF646D6D);
  Color get gray800 => Color (0XFF35383F);
  Color get gray80000 => Color (0X004B4B4B);
  Color get gray80046 => Color (0X463A3A3A);
  Color get gray900 => Color (0XFF1F1F1F);

// Grayd
  Color get gray8001d => Color (0X1D444444);
  Color get gray8002d => Color (0X2D404040);
  // Green
  Color get green600 => Color (0XFF34A853);
  Color get green60019 => Color (0X19359766);
  // GreenAf
  Color get greenA7003f => Color (0X3F1AB65C);
  // Indigo
  Color get indigo900 => Color (0XFF012169);
  Color get indigoA20014 => Color (0X145A6CEA);
  // LightBlue
  Color get lightBlue600 => Color (0XFF009CDE);
  // Red
  Color get red400 => Color (0XFFEA5B52);
  Color get red40019 => Color (0X19C65454);
  Color get red500 => Color (0XFFEB4335);
  // Teal
  Color get teal900 => Color (0XFF093A3D);
  // White
  Color get whiteA700 => Color (0XFFFFFFFF);
  // Yellow
  Color get yellowA700 => Color (0XFFFFD300);
}
