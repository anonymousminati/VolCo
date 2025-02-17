import 'package:flutter/material.dart';
import 'package:volco/core/app_export.dart';

class LabelWidget extends StatelessWidget {
  final String labelText;
  final Color color;
  final VoidCallback? onTap; // Nullable onTap function

  const LabelWidget({
    Key? key,
    required this.labelText,
    required this.color,
    this.onTap, // Nullable parameter
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap ?? () {
        print("onTap is null");
      }, // If onTap is null, do nothing
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(50),
        ),
        child: Center(
          child: Text(
            labelText,
            style: TextStyle(
              color: Colors.black,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}
