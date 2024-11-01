import 'package:flutter/material.dart';
import 'package:volco/core/app_export.dart';

extension on TextStyle {
  TextStyle get sourceSansPro {
    return copyWith(
      fontFamily: 'Source Sans Pro',
    );
  }

  TextStyle get urbanist {
    return copyWith(
      fontFamily: 'Urbanist',
    );
  }
}

class CustomTextStyles {
  static TextStyle get bodyLarge16 => theme.textTheme.bodyLarge!.copyWith(
        fontSize: 16.fSize,
      );
  static TextStyle get bodyLarge16_1 => theme.textTheme.bodyLarge!.copyWith(
        fontSize: 16.fSize,
      );
  static TextStyle get bodyLargeGray40001 =>
      theme.textTheme.bodyLarge!.copyWith(
        color: appTheme.gray40001,
        fontSize: 16.fSize,
      );
  static TextStyle get bodyLargePrimary => theme.textTheme.bodyLarge!.copyWith(
        color: theme.colorScheme.primary,
        fontSize: 16.fSize,
      );
  static TextStyle get bodyMediumBluegray100 =>
      theme.textTheme.bodyMedium!.copyWith(
        color: appTheme.blueGray100,
      );
  static TextStyle get bodyMediumGray40001 =>
      theme.textTheme.bodyMedium!.copyWith(
        color: appTheme.gray40001,
      );
  static TextStyle get bodyMediumGray50 => theme.textTheme.bodyMedium!.copyWith(
        color: appTheme.gray50,
      );
  static TextStyle get bodyMediumGray500 =>
      theme.textTheme.bodyMedium!.copyWith(
        color: appTheme.gray500,
      );
  static TextStyle get bodyMediumWhiteA700 =>
      theme.textTheme.bodyMedium!.copyWith(
        color: appTheme.whiteA700,
      );

  static TextStyle get bodySmall10 => theme.textTheme.bodySmall!.copyWith(
        fontSize: 10.fSize,
      );
  static get bodySmall_1 => theme.textTheme.bodySmall!;
// Headline text style
  static TextStyle get headlineLargePrimary =>
      theme.textTheme.headlineLarge!.copyWith(
        color: theme.colorScheme.primary,
      );
  static TextStyle get headlineSmallPrimary =>
      theme.textTheme.headlineSmall!.copyWith(
        color: theme.colorScheme.primary,
      );
  static TextStyle get headlineSmallRed400 =>
      theme.textTheme.headlineSmall!.copyWith(
        color: appTheme.red400,
      );
// Label text style
  static TextStyle get labelLargeGray40001 =>
      theme.textTheme.labelLarge!.copyWith(
        color: appTheme.gray40001,
      );
  static TextStyle get labelLargeWhiteA700 =>
      theme.textTheme.labelLarge!.copyWith(
        color: appTheme.whiteA700,
        fontWeight: FontWeight.w600,
      );
  static TextStyle get labelMediumBluegray100 =>
      theme.textTheme.labelMedium!.copyWith(
        color: appTheme.blueGray100,
      );
  static TextStyle get labelMediumCyan200 =>
      theme.textTheme.labelMedium!.copyWith(
        color: appTheme.cyan200,
      );

  static TextStyle get labelMediumCyan300 =>
      theme.textTheme.labelMedium!.copyWith(
        color: appTheme.cyan300,
        fontWeight: FontWeight.w600,
      );
  static TextStyle get labelMediumPrimary =>
      theme.textTheme.labelMedium!.copyWith(
        color: theme.colorScheme.primary,
        fontWeight: FontWeight.w700,
      );
  static TextStyle get labelMediumPrimaryBold =>
      theme.textTheme.labelMedium!.copyWith(
        color: theme.colorScheme.primary,
        fontWeight: FontWeight.w700,
      );
  static TextStyle get labelMediumRed400 =>
      theme.textTheme.labelMedium!.copyWith(
        color: appTheme.red400,
        fontWeight: FontWeight.w600,
      );
  static TextStyle get labelMediumRed400_1 =>
      theme.textTheme.labelMedium!.copyWith(
        color: appTheme.red400,
      );
  // Title text style
  static TextStyle get titleLarge20 => theme.textTheme.titleLarge!.copyWith(
        fontSize: 20.fSize,
      );
  static TextStyle get titleLargePrimary =>
      theme.textTheme.titleLarge!.copyWith(
        color: theme.colorScheme.primary,
        fontSize: 20.fSize,
      );

  static TextStyle get titleLargeSemiBold =>
      theme.textTheme.titleLarge!.copyWith(
        fontWeight: FontWeight.w600,
      );
  static TextStyle get titleMedium16 => theme.textTheme.titleMedium!.copyWith(
        fontSize: 16.fSize,
      );
  static TextStyle get titleMedium16_1 => theme.textTheme.titleMedium!.copyWith(
        fontSize: 16.fSize,
      );
  static TextStyle get titleMediumGray40001 =>
      theme.textTheme.titleMedium!.copyWith(
        color: appTheme.gray40001,
        fontWeight: FontWeight.w500,
      );
  static TextStyle get titleMediumGray50 =>
      theme.textTheme.titleMedium!.copyWith(
        color: appTheme.gray50,
        fontWeight: FontWeight.w600,
      );
  static TextStyle get titleMediumOnPrimaryContainer =>
      theme.textTheme.titleMedium!.copyWith(
        color: theme.colorScheme.onPrimaryContainer,
        fontSize: 16.fSize,
        fontWeight: FontWeight.w600,
      );
  static TextStyle get titleMediumPrimary =>
      theme.textTheme.titleMedium!.copyWith(
        color: theme.colorScheme.primary,
        fontSize: 16.fSize,
        fontWeight: FontWeight.w600,
      );
  static TextStyle get titleMediumPrimary16 =>
      theme.textTheme.titleMedium!.copyWith(
        color: theme.colorScheme.primary,
        fontSize: 16.fSize,
      );

  static TextStyle get titleMediumPrimarySemiBold =>
      theme.textTheme.titleMedium!.copyWith(
        color: theme.colorScheme.primary,
        fontSize: 16.fSize,
        fontWeight: FontWeight.w600,
      );
  static TextStyle get titleMediumPrimary_1 =>
      theme.textTheme.titleMedium!.copyWith(
        color: theme.colorScheme.primary,
      );
  static TextStyle get titleMediumRed400 =>
      theme.textTheme.titleMedium!.copyWith(
        color: appTheme.red400,
        fontWeight: FontWeight.w600,
      );
  static TextStyle get titleMediumSemiBold =>
      theme.textTheme.titleMedium!.copyWith(
        fontSize: 16.fSize,
        fontWeight: FontWeight.w600,
      );
  static TextStyle get titleMediumSemiBold16 =>
      theme.textTheme.titleMedium!.copyWith(
        fontSize: 16.fSize,
        fontWeight: FontWeight.w600,
      );
  static TextStyle get titleMediumSemiBold_1 =>
      theme.textTheme.titleMedium!.copyWith(
        fontWeight: FontWeight.w600,
      );
  static TextStyle get titleMediumSourceSansPro =>
      theme.textTheme.titleMedium!.sourceSansPro.copyWith(
        fontWeight: FontWeight.w600,
      );
  static TextStyle get titleSmallGray400 =>
      theme.textTheme.titleSmall!.copyWith(
        color: appTheme.gray400,
        fontWeight: FontWeight.w500,
      );

  static TextStyle get titleSmallGray40001 =>
      theme.textTheme.titleSmall!.copyWith(
        color: appTheme.gray40001,
        fontWeight: FontWeight.w500,
      );
  static TextStyle get titleSmallPrimary =>
      theme.textTheme.titleSmall!.copyWith(
        color: theme.colorScheme.primary,
      );
  static get titleSmall_1 => theme.textTheme.titleSmall!;
}
