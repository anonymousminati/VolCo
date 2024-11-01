import 'package:flutter/material.dart';
import 'package:volco/core/app_export.dart';


enum Style{bgGradientnamegray80000namegray900}

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget{

  CustomAppBar( {Key? key, this.height,
    this.shape, this.styleType,
    this.leadingWidth,
    this.leading,
    this.title,
    this.centerTitle,
    this.actions})
      : super(
    key: key,
  );
  final double? height;
  final ShapeBorder? shape;
  final Style? styleType;
  final double? leadingWidth;
  final Widget? leading;
  final Widget? title;
  final bool? centerTitle;
  final List<Widget>? actions;


  @override
  Widget build(BuildContext context) {
    return AppBar( elevation: 0,
      shape: shape,
      toolbarHeight: height ?? 114.h, automaticallyImplyLeading: false,
      backgroundColor: Colors.transparent,
      flexibleSpace: _getStyle(),
      leadingWidth: leadingWidth ?? 0,
      leading: leading,
      title: title,
      titleSpacing: 0,
      centerTitle: centerTitle ?? false,
      actions: actions,
    );
  }
  @override
  Size get preferredSize => Size(
  SizeUtils.width,
  height?? 114.h,
  );
  _getStyle() {
    switch (styleType) {
      case Style.bgGradientnamegray80000namegray900:
        return Container(
          height: 114.h,
          width: double.maxFinite,
          decoration: BoxDecoration(
          gradient: LinearGradient(
          begin: Alignment (0.5, -0.78),
          end: Alignment (0.5, 1),
          colors: [appTheme.gray80000, appTheme.gray900],
          ),
          ),
        );
      default:
        return null;
    }
  }
}


