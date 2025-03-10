import 'package:flutter/material.dart';
import 'package:volco/core/app_export.dart';

extension TextFormFieldStyleHelper on CustomTextFormField {
  static OutlineInputBorder get custom => OutlineInputBorder(
        borderSide: BorderSide.none,
      );

  static OutlineInputBorder get outlinePrimary => OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.h),
        borderSide: BorderSide(
          color: theme.colorScheme.primary,
          width: 1,
        ),
      );

  static OutlineInputBorder get fillBlueGray1 => OutlineInputBorder(
        borderSide: BorderSide.none,
      );
}

class CustomTextFormField extends StatelessWidget {
  CustomTextFormField(
      {Key? key,
      this.alignment,
      this.width,
      this.boxDecoration,
      this.scrollPadding,
      this.controller,
      this.focusNode,
      this.autofocus = false,
      this.textStyle,
      this.obscureText = false,
      this.readOnly = false,
      this.onTap,
      this.textInputAction = TextInputAction.next,
      this.textInputType = TextInputType.text,
      this.maxLines,
      this.minLines,
      this.hintText,
      this.hintStyle,
      this.prefix,
      this.prefixConstraints,
      this.suffix,
      this.suffixConstraints,
      this.contentPadding,
      this.borderDecoration,
      this.fillColor,
      this.filled = true,
      this.validator})
      : super(
          key: key,
        );

  final Alignment? alignment;
  final double? width;
  final BoxDecoration? boxDecoration;
  final TextEditingController? scrollPadding;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final bool? autofocus;
  final TextStyle? textStyle;
  final bool? obscureText;
  final bool? readOnly;
  final VoidCallback? onTap;
  final TextInputAction? textInputAction;
  final TextInputType? textInputType;
  final int? maxLines;
  final int? minLines;
  final String? hintText;
  final TextStyle? hintStyle;
  final Widget? prefix;
  final BoxConstraints? prefixConstraints;
  final Widget? suffix;
  final BoxConstraints? suffixConstraints;
  final EdgeInsets? contentPadding;
  final InputBorder? borderDecoration;
  final Color? fillColor;
  final bool? filled;
  final FormFieldValidator<String>? validator;
  @override
  Widget build(BuildContext context) {
    return alignment != null
        ? Align(
            alignment: alignment ?? Alignment.center,
            child: textFormFieldWidget)
        : textFormFieldWidget;
  }

  Widget get textFormFieldWidget => Container(
        width: width ?? double.maxFinite,
        decoration: boxDecoration,
        child: TextFormField(
          scrollPadding: EdgeInsets.only(
              bottom: MediaQuery.of(Get.context!).viewInsets.bottom),
          controller: controller,
          focusNode: focusNode,
          onTapOutside: (event) {
            if (focusNode != null) {
              focusNode?.unfocus();
            } else {
              FocusManager.instance.primaryFocus?.unfocus();
            }
          },
          autofocus: autofocus!,
          style: textStyle ?? theme.textTheme.titleSmall,
          obscureText: obscureText!,
          readOnly: readOnly!,
          onTap: () {
            onTap?.call();
          },
          textInputAction: textInputAction,
          keyboardType: textInputType,
          maxLines: maxLines ?? 1,
          minLines: minLines??1,
          decoration: decoration,
          validator: validator,
        ),
      );

  InputDecoration get decoration => InputDecoration(
      hintText: hintText ?? "",
      hintStyle: hintStyle ?? CustomTextStyles.bodyMediumBluegray100,
      prefixIcon: prefix,
      prefixIconConstraints: prefixConstraints,
      suffixIcon: suffix,
      suffixIconConstraints: suffixConstraints,
      isDense: true,
      contentPadding: contentPadding ?? EdgeInsets.all(18.h),
      fillColor: fillColor ?? appTheme.blueGray900,
      filled: filled,
      border: borderDecoration ??
          OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.h),
            borderSide: BorderSide.none,
          ),
      enabledBorder: borderDecoration ??
          OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.h),
            borderSide: BorderSide.none,
          ),
      focusedBorder: (borderDecoration ??
            OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.h),
            )).copyWith(
          borderSide: BorderSide(
        color: theme.colorScheme.primary,
        width: 1,
      )));
}
