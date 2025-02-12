import 'dart:io';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:volco/core/app_export.dart';

class CustomImagePickerWidget extends StatefulWidget {
  /// Callback to be invoked after image upload (if needed).
  final Function(String imageUrl)? onImagePicked;

  /// An optional initial image URL to display (for example, when editing).
  final String? initialImageUrl;

  const CustomImagePickerWidget({
    Key? key,
    this.onImagePicked,
    this.initialImageUrl,
  }) : super(key: key);

  @override
  _CustomImagePickerWidgetState createState() => _CustomImagePickerWidgetState();
}

class _CustomImagePickerWidgetState extends State<CustomImagePickerWidget> {
  File? _imageFile;
  final ImagePicker _picker = ImagePicker();

  /// Picks an image from the gallery.
  Future<void> _pickImage() async {
    final XFile? pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
      widget.onImagePicked?.call(pickedFile.path);
      // Optionally, if you want to immediately notify the controller with the file path or URL,
      // you can call the callback here. (Typically, the upload is handled outside of this widget.)
      // widget.onImagePicked?.call(pickedFile.path);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _pickImage, // Tap anywhere to open the image picker.
      child: Container(
        width: double.infinity,
        height: 180.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.h),
          color: appTheme.blueGray900,
        ),
        child: _buildContent(),
      ),
    );
  }

  Widget _buildContent() {
    if (_imageFile != null) {
      // Display the picked image.
      return Padding(
        padding: EdgeInsets.all(12.h),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(5.h),
          child: Image.file(
            _imageFile!,
            width: double.infinity,
            height: 180.h,
            fit: BoxFit.cover,
          ),
        ),
      );
    } else if (widget.initialImageUrl != null) {
      // Display the initial image with a dotted border.
      return Padding(
        padding: EdgeInsets.all(12.h),
        child: DottedBorder(
          color: appTheme.gray700.withAlpha(70),
          strokeWidth: 3,
          dashPattern: [8, 3],
          borderType: BorderType.RRect,
          radius: Radius.circular(5.h),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(5.h),
            child: Image.network(
              widget.initialImageUrl!,
              width: double.infinity,
              height: 180.h,
              fit: BoxFit.cover,
            ),
          ),
        ),
      );
    } else {
      // Display the placeholder with a dotted border.
      return Padding(
        padding: EdgeInsets.all(12.h),
        child: DottedBorder(
          color: appTheme.gray700.withAlpha(70),
          strokeWidth: 3,
          dashPattern: [8, 3],
          borderType: BorderType.RRect,
          radius: Radius.circular(5.h),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.add_a_photo, size: 50.h, color: Colors.white70),
                SizedBox(height: 8.h),
                Text(
                  "Upload Image",
                  style: CustomTextStyles.bodyMediumBluegray100,
                ),
              ],
            ),
          ),
        ),
      );
    }
  }
}
