import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:volco/core/app_export.dart';

class CustomMultiSelectDropdown extends StatefulWidget {
  /// List of options available for selection.
  final List<String> items;

  /// Hint text to display when no option is selected.
  final String hintText;

  /// Callback to pass back the list of selected items.
  final Function(List<String>) onSelectionChanged;

  /// Optionally, provide initially selected items.
  final List<String>? initialSelectedItems;

  /// Optional custom border decoration for the container.
  final BoxBorder? borderDecoration;

  /// Optional fill color for the container.
  final Color? fillColor;

  /// Optional content padding for the container.
  final EdgeInsets? contentPadding;

  const CustomMultiSelectDropdown({
    Key? key,
    required this.items,
    required this.hintText,
    required this.onSelectionChanged,
    this.initialSelectedItems,
    this.borderDecoration,
    this.fillColor,
    this.contentPadding,
  }) : super(key: key);

  @override
  _CustomMultiSelectDropdownState createState() =>
      _CustomMultiSelectDropdownState();
}

class _CustomMultiSelectDropdownState extends State<CustomMultiSelectDropdown> {
  late List<String> selectedItems;

  @override
  void initState() {
    super.initState();
    selectedItems = widget.initialSelectedItems ?? [];
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Dropdown Field styled similarly to CustomTextFormField.
        GestureDetector(
          onTap: _showMultiSelectDialog,
          child: Container(
            width: double.infinity,
            padding: widget.contentPadding ?? EdgeInsets.all(18.h),
            decoration: BoxDecoration(
              color: widget.fillColor ?? appTheme.blueGray900,
              borderRadius: BorderRadius.circular(12.h),
              border: widget.borderDecoration ??
                  Border.all(
                    color: theme.colorScheme.primary,
                    width: 1,
                  ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    selectedItems.isEmpty
                        ? widget.hintText
                        : selectedItems.join(', '),
                    style: theme.textTheme.titleSmall?.copyWith(
                      color: selectedItems.isEmpty
                          ? appTheme.gray500
                          : appTheme.gray700,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Icon(Icons.arrow_drop_down, color: theme.colorScheme.primary),
              ],
            ),
          ),
        ),
        SizedBox(height: 10),
        // Display selected items as chips.
        Wrap(
          spacing: 8,
          runSpacing: 4,
          children: selectedItems.map((item) {
            return Chip(
              backgroundColor: theme.colorScheme.primaryContainer,
              label: Text(
                item,
                style: theme.textTheme.bodySmall
                    ?.copyWith(color: theme.colorScheme.onPrimaryContainer),
              ),
              deleteIcon: Icon(Icons.close,
                  size: 18, color: theme.colorScheme.onPrimaryContainer),
              onDeleted: () {
                setState(() {
                  selectedItems.remove(item);
                  widget.onSelectionChanged(selectedItems);
                });
              },
            );
          }).toList(),
        ),
      ],
    );
  }

  /// Opens a dialog that displays the list of options with checkboxes.
  void _showMultiSelectDialog() async {
    // Create a temporary copy of the selected items.
    List<String> tempSelectedItems = List.from(selectedItems);

    await showDialog(

      context: context,
      builder: (context) {
        return MultiSelectDialog(

          items: widget.items,
          selectedItems: tempSelectedItems,
          onConfirm: (List<String> selected) {
            setState(() {
              selectedItems = selected;
              widget.onSelectionChanged(selectedItems);
            });
          },
        );
      },
    );
  }
}

/// A dialog widget that displays the available items as checkboxes.
class MultiSelectDialog extends StatefulWidget {
  final List<String> items;
  final List<String> selectedItems;
  final Function(List<String>) onConfirm;

  const MultiSelectDialog({
    Key? key,
    required this.items,
    required this.selectedItems,
    required this.onConfirm,
  }) : super(key: key);

  @override
  _MultiSelectDialogState createState() => _MultiSelectDialogState();
}

class _MultiSelectDialogState extends State<MultiSelectDialog> {
  late List<String> tempSelectedItems;

  @override
  void initState() {
    super.initState();
    tempSelectedItems = List.from(widget.selectedItems);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(

      backgroundColor: appTheme.blueGray900,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.h)),
      title: Text(
        "Select Options",
        style:
            theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
      ),
      content: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: widget.items.map((item) {
              bool isSelected = tempSelectedItems.contains(item);
              return CheckboxListTile(
                checkboxShape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4.h),
                    side: BorderSide(color: appTheme.gray700, width: 1)),
                activeColor: theme.colorScheme.primary,
                title: Text(item, style: theme.textTheme.bodyMedium),
                value: isSelected,
                onChanged: (bool? selected) {
                  setState(() {
                    if (selected == true) {
                      tempSelectedItems.add(item);
                    } else {
                      tempSelectedItems.remove(item);
                    }
                  });
                },
              );
            }).toList(),
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text("Cancel",
              style: theme.textTheme.bodyMedium
                  ?.copyWith(color: theme.colorScheme.error)),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: theme.colorScheme.primary,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.h)),
          ),
          onPressed: () {
            widget.onConfirm(tempSelectedItems);
            Navigator.pop(context);
          },
          child: Text("Confirm",
              style: theme.textTheme.bodyMedium
                  ?.copyWith(color: theme.colorScheme.onPrimary)),
        ),
      ],
    );
  }
}
