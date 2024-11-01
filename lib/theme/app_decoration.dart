import 'package:flutter/material.dart';
import 'package:volco/core/app_export.dart';

class AppDecoration {
  static BoxDecoration get background1 => BoxDecoration(
        color: theme.colorScheme.onPrimary,
      );

  static BoxDecoration get background2 => BoxDecoration(
        color: appTheme.blueGray900,
        boxShadow: [
          BoxShadow(
            color: appTheme.black9000c,
            spreadRadius: 2.h,
            blurRadius: 2.h,
            offset: Offset(
              0,
              4,
            ),
          )
        ],
      );
  static BoxDecoration get background2CardShadow1 => BoxDecoration(
        color: appTheme.blueGray900,
        boxShadow: [
          BoxShadow(
            color: appTheme.black9000c.withOpacity(0.08),
            spreadRadius: 2.h,
            blurRadius: 2.h,
            offset: Offset(
              0,
              4,
            ),
          )
        ],
      );

// Button decorations
  static BoxDecoration get buttonShadow1 => BoxDecoration(); // Fill decorations
  static BoxDecoration get fillBlueGray => BoxDecoration(
        color: appTheme.blueGray900,
      );
  static BoxDecoration get fillCyan => BoxDecoration(
        color: appTheme.cyan600,
      );
  static BoxDecoration get fillGray => BoxDecoration(
        color: appTheme.gray700,
      );
  static BoxDecoration get fillPrimary => BoxDecoration(
        color: theme.colorScheme.primary,
      );
// Gradient decorations
  static BoxDecoration get gradient => BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment(0.5, 0),
          end: Alignment(0.5, 1),
          colors: [
            appTheme.gray80000,
            appTheme.blueGray90059,
            appTheme.gray900.withOpacity(0.59)
          ],
        ),
      );
// Info decorations
  static BoxDecoration get info1 => BoxDecoration(
        color: appTheme.green60019,
      );
  static BoxDecoration get info2 => BoxDecoration(
        color: appTheme.red40019,
      );

// Neutral decorations
  static BoxDecoration get neutral700 => BoxDecoration(
        color: appTheme.blueGray900,
        border: Border.all(
          color: appTheme.gray700,
          width: 1.h,
        ),
      );
  static BoxDecoration get neutral700Background1 => BoxDecoration(
        color: theme.colorScheme.onPrimary,
        border: Border.all(
          color: appTheme.gray700,
          width: 1.h,
        ),
      );
// Primary decorations
  static BoxDecoration get primary500 => BoxDecoration(
        border: Border.all(
          color: theme.colorScheme.primary,
          width: 2.h,
        ),
      );
  static BoxDecoration get primary700 => BoxDecoration(
        color: appTheme.cyan900,
        boxShadow: [
          BoxShadow(
            color: appTheme.indigoA20014,
            spreadRadius: 2.h,
            blurRadius: 2.h,
            offset: Offset(
              0,
              0,
            ),
          )
        ],
      );
}

class BorderRadiusStyle {
// Circle borders
  static BorderRadius get circleBorder22 => BorderRadius.circular(
        22.h,
      );
  static BorderRadius get circleBorder40 => BorderRadius.circular(
        40.h,
      );
  static BorderRadius get circleBorder60 => BorderRadius.circular(
        60.h,
      );
  static BorderRadius get circleBorder70 => BorderRadius.circular(
        70.h,
      );
// Custom borders
  static BorderRadius get customBorderBL36 => BorderRadius.vertical(
        bottom: Radius.circular(36.h),
      );
  static BorderRadius get customBorderTL40 => BorderRadius.vertical(
        top: Radius.circular(40.h),
      );
// Rounded borders
  static BorderRadius get roundedBorder10 => BorderRadius.circular(
        10.h,
      );
  static BorderRadius get roundedBorder16 => BorderRadius.circular(
        16.h,
      );
  static BorderRadius get roundedBorder2 => BorderRadius.circular(
        2.h,
      );
  static BorderRadius get roundedBorder26 => BorderRadius.circular(
        26.h,
      );
  static BorderRadius get roundedBorder36 => BorderRadius.circular(
        36.h,
      );
}
