import 'package:flutter/material.dart';
import 'package:volco/core/app_export.dart';

class CustomDropdownField extends StatelessWidget {
  final String label;
  final List<String> options;
  final Function(String?)? onChanged;
  final String? initialValue;

  const CustomDropdownField({
    Key? key,
    required this.label,
    required this.options,
    this.onChanged,
    this.initialValue,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InputDecorator(
      decoration: InputDecoration(
        labelText: label,
        labelStyle: theme.textTheme.bodyMedium,
        contentPadding: EdgeInsets.symmetric(horizontal: 20.h, vertical: 18.h),
        filled: true,
        fillColor: appTheme.blueGray900,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.h),
          borderSide: BorderSide.none,
        ),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: initialValue,
          isExpanded: true,
          hint: Text("Select $label".tr, style: theme.textTheme.bodyMedium),
          items: options.map((option) {
            return DropdownMenuItem<String>(
              value: option,
              child: Text(option, style: theme.textTheme.bodyMedium),
            );
          }).toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }
}
