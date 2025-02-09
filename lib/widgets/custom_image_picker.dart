import 'dart:io';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:get/get.dart';
import 'package:volco/core/app_export.dart';

class CustomImagePickerWidget extends StatefulWidget {
  final Function(String imageUrl)? onImagePicked; // Callback after upload
  final String? initialImageUrl; // For editing existing image

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

  /// **📌 Pick Image from Gallery**
  Future<void> _pickImage() async {
    final XFile? pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() => _imageFile = File(pickedFile.path));
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _pickImage, // **📌 Tap anywhere to open image picker**
      child: Container(
        width: double.infinity,
        height: 180.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.h),
          color: appTheme.blueGray900,
        ),
        child: _imageFile != null
            ? Padding(
          padding: EdgeInsets.all(12.h),
          //add property outer padding
          child: ClipRRect(
            borderRadius: BorderRadius.circular(5.h),

            child: Image.file(
              _imageFile!,
              width: double.infinity,
              height: 180.h,
              fit: BoxFit.cover,
            ),
          ),
        )
            : widget.initialImageUrl != null
            ? Padding(
          padding: EdgeInsets.all(12.h),


          //add property outer padding and dashed border

        child: DottedBorder(
          color: appTheme.gray700.withAlpha(70),
          strokeWidth: 3,
          dashPattern: [8,3],
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
            )
            : Padding(
          padding: EdgeInsets.all(12.h),

          //add property outer padding and dashed border

        child: DottedBorder(
          color: appTheme.gray700.withAlpha(70),
          strokeWidth: 3,
          dashPattern: [8,3],
          child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.add_a_photo, size: 50.h, color: Colors.white70),
                              SizedBox(height: 8.h),
                              Text("Upload Image", style: CustomTextStyles.bodyMediumBluegray100),
                            ],
                          ),
                        ),
        ),
            ),
      ),
    );
  }
}
