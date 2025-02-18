import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:volco/core/app_export.dart';

class InfoContainer extends StatelessWidget {
  final String title;
  final String value;

  const InfoContainer({
    Key? key,
    required this.title,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1, // Keeps the container square
      child: Container(
        padding: EdgeInsets.all(12.h),
        decoration: BoxDecoration(
          color: appTheme.blueGray900,
          borderRadius: BorderRadius.circular(12.h),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, // Centers content vertically
          crossAxisAlignment: CrossAxisAlignment.center, // Centers content horizontally
          children: [
            AutoSizeText(
              value, // Value comes first
              textAlign: TextAlign.center,
              style: theme.textTheme.headlineSmall!.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 46.h
              ),
              maxLines: 1,
            ),
            SizedBox(height: 10.h), // Space between texts
            Text(
              title,
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyLarge!.copyWith(
                color: Colors.white70,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
