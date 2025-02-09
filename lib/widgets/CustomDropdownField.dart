import 'package:flutter/material.dart';
import 'package:volco/core/app_export.dart';

class CustomSelectDropdown extends StatefulWidget {
  final String hintText;
  final List<String> options;
  final Function(String?)? onChanged;
  final String? initialValue;
  final EdgeInsetsGeometry? contentPadding;
  final Color? fillColor;
  final BoxBorder? borderDecoration;

  const CustomSelectDropdown({
    Key? key,
    required this.hintText,
    required this.options,
    this.onChanged,
    this.initialValue,
    this.contentPadding,
    this.fillColor,
    this.borderDecoration,
  }) : super(key: key);

  @override
  _CustomSelectDropdownState createState() => _CustomSelectDropdownState();
}

class _CustomSelectDropdownState extends State<CustomSelectDropdown> {
  String? selectedItem;

  @override
  void initState() {
    super.initState();
    selectedItem = widget.initialValue;
  }

  void _showDropdownDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.h),
          ),
          backgroundColor: appTheme.blueGray900,
          title: Text(
            widget.hintText?? "Select an option",
            style: theme.textTheme.titleMedium?.copyWith(color: appTheme.gray400),
          ),
          content: SizedBox(
            width: double.maxFinite,
            child: ListView(
              shrinkWrap: true,
              children: widget.options.map((String option) {
                return ListTile(
                  title: Text(
                    option,
                    style: theme.textTheme.titleSmall?.copyWith(color: appTheme.gray500),
                  ),
                  onTap: () {
                    setState(() {
                      selectedItem = option;
                    });
                    widget.onChanged?.call(option);
                    Navigator.pop(context);
                  },
                );
              }).toList(),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _showDropdownDialog(context),
      child: Container(
        width: double.infinity,
        padding: widget.contentPadding ?? EdgeInsets.all(18.h),
        decoration: BoxDecoration(
          color: widget.fillColor ?? appTheme.blueGray900,
          borderRadius: BorderRadius.circular(12.h),
          border: widget.borderDecoration ?? Border.all(
            color: theme.colorScheme.primary,
            width: 1,
          ),
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                selectedItem ?? widget.hintText,
                style: theme.textTheme.titleSmall?.copyWith(
                  color: selectedItem == null ? appTheme.gray500 : appTheme.gray700,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Icon(Icons.arrow_drop_down, color: theme.colorScheme.primary),
          ],
        ),
      ),
    );
  }
}
