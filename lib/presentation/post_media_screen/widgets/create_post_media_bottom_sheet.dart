import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:volco/core/app_export.dart';
import 'package:volco/core/utils/project_constants.dart';
import 'package:volco/presentation/post_media_screen/controller/post_media_controller.dart';
import 'package:volco/widgets/custom_image_picker.dart';

class CreatePostBottomSheet extends StatefulWidget {
  final VoidCallback onPostSuccess;
  final PostMediaController controller;
  const CreatePostBottomSheet({
    Key? key,
    required this.onPostSuccess,
    required this.controller,
  }) : super(key: key);

  @override
  _CreatePostBottomSheetState createState() => _CreatePostBottomSheetState();
}

class _CreatePostBottomSheetState extends State<CreatePostBottomSheet> {
  final _createPostMediaFormKey =
      GlobalKey<FormState>(debugLabel: "CreatePostMediaFormGlobalKey");

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.h),
      // Adjust height as needed; here we use a fraction of screen height.
      height: MediaQuery.of(context).size.height * 0.6,
      decoration: BoxDecoration(
        color: appTheme.gray800,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16.h),
          topRight: Radius.circular(16.h),
        ),
      ),
      child: SingleChildScrollView(
        child: Form(
          key: _createPostMediaFormKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            spacing: 20.h,
            children: [
              Text("Create Post",
                  style: CustomTextStyles.headlineLargePrimary.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  )),

              // Description field (required)
              CustomTextFormField(
                hintText: "Enter Post Description",
                controller: widget.controller.postDescriptionController,
                maxLines: 4,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Description is required";
                  }
                  return null;
                },
              ),

              // Image Picker Widget
              CustomImagePickerWidget(
                onImagePicked: (String imagePath) {
                  widget.controller.pickedImage.value = XFile(imagePath);
                  print(
                      "Picked Image Path: ${widget.controller.pickedImage.value?.path}");
                },
              ),

              // Image Caption field (optional)
              CustomTextFormField(
                hintText: "Enter Image Caption (optional)",
                controller: widget.controller.postImageCaptionController,
                maxLines: 2,
              ),
              CustomTextFormField(
                hintText: "Enter Hashtags (comma separated)",
                controller: widget.controller.postHashTagController,
              ),
              // Confirm Post Button
              CustomElevatedButton(
                text: "Posts",
                onPressed: () async {
                  if (_createPostMediaFormKey.currentState!.validate()) {
                    bool success = await widget.controller.createPost();
                    if (success) {
                      print("Post line 2");
                      // widget.onPostSuccess;
                      Get.back();
                      print("Post line 3");
                    } else {
                      Get.snackbar("Error", "Failed to create post",
                          snackPosition: SnackPosition.BOTTOM);
                    }
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
