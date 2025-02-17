import 'package:flutter/material.dart';
import 'package:volco/core/app_export.dart';

class RoundedImageWidget extends StatelessWidget {
  final String? imageUrl;

  RoundedImageWidget({required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16.h),
      child: CustomImageView(
       imagePath:  imageUrl,
        width: double.infinity, // Full width
        height: 170.h,
        fit: BoxFit.cover, // Ensures the image covers the space properly
      ),
    );
  }
}
