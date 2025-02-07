# volco

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

```
volco
├─  assets
│  ├─ fonts
│  │  ├─ SourceCodeProSemiBold.ttf
│  │  ├─ UrbanistBlack.ttf
│  │  ├─ UrbanistBlackItalic.ttf
│  │  ├─ UrbanistBold.ttf
│  │  ├─ UrbanistBoldItalic.ttf
│  │  ├─ UrbanistExtraBold.ttf
│  │  ├─ UrbanistExtraBoldItalic.ttf
│  │  ├─ UrbanistExtraLight.ttf
│  │  ├─ UrbanistExtraLightItalic.ttf
│  │  ├─ UrbanistItalic.ttf
│  │  ├─ UrbanistLight.ttf
│  │  ├─ UrbanistLightItalic.ttf
│  │  ├─ UrbanistMedium.ttf
│  │  ├─ UrbanistMediumItalic.ttf
│  │  ├─ UrbanistRegular.ttf
│  │  ├─ UrbanistSemiBold.ttf
│  │  ├─ UrbanistSemiBoldItalic.ttf
│  │  ├─ UrbanistThin.ttf
│  │  └─ UrbanistThinItalic.ttf
│  └─ images
│     ├─ apple_logo.svg
│     ├─ arrow_left.svg
│     ├─ facebook_logo.svg
│     ├─ google_logo.svg
│     ├─ img_bell_blue.svg
│     ├─ img_bookmark_skyblue.svg
│     ├─ img_email.svg
│     ├─ img_eye.svg
│     ├─ img_eye_slash.svg
│     ├─ img_home_skyblue.svg
│     ├─ img_home_white.svg
│     ├─ img_location.svg
│     ├─ img_note_skyblue.svg
│     ├─ img_note_white.svg
│     ├─ img_profile_skyblue.svg
│     ├─ img_profile_white.svg
│     ├─ img_search_contrast.svg
│     ├─ img_search_gray.svg
│     ├─ img_search_white.svg
│     ├─ img_setting_skyblue.svg
│     ├─ img_star_filled_skyblue.svg
│     ├─ img_star_filled_white.svg
│     ├─ img_star_filled_yellow.svg
│     ├─ img_star_sharp.svg
│     ├─ make_an_impact.png
│     ├─ orimg.png
│     ├─ teacher_teaching_orphan.png
│     ├─ VolCo_logo_high_res.png
│     ├─ VolCo_logo_standard.png
│     ├─ volunteering_cleaning.jpg
│     ├─ volunteer_your_time.png
│     └─ welcome_rectangle1.jpg
├─
├─ lib
│  ├─ core
│  │  ├─ app_export.dart
│  │  └─ utils
│  │     ├─ image_constant.dart
│  │     ├─ initial_bindings.dart
│  │     ├─ logger.dart
│  │     ├─ pref_utils.dart
│  │     ├─ size_utils.dart
│  │     └─ validation_functions.dart
│  ├─ data
│  ├─ main.dart
│  ├─ presentation
│  │  ├─ home_screen
│  │  │  ├─ binding
│  │  │  │  └─ home_binding.dart
│  │  │  ├─ controller
│  │  │  │  └─ home_controller.dart
│  │  │  ├─ home_screen.dart
│  │  │  ├─ home_screen_initial_page.dart
│  │  │  ├─ models
│  │  │  │  ├─ homescreenlist_item_model.dart
│  │  │  │  ├─ home_model.dart
│  │  │  │  └─ home_screen_initial_model.dart
│  │  │  └─ widget
│  │  │     └─ homescreenlist_item_widget.dart
│  │  ├─ let_s_you_in_screen
│  │  │  ├─ binding
│  │  │  │  └─ let_s_you_in_binding.dart
│  │  │  ├─ controller
│  │  │  │  └─ let_s_you_in_controller.dart
│  │  │  ├─ let_s_you_in_screen.dart
│  │  │  └─ models
│  │  │     └─ let_s_you_in_model.dart
│  │  ├─ onboarding_one_screen
│  │  │  ├─ binding
│  │  │  │  └─ onboarding_one_binding.dart
│  │  │  ├─ controller
│  │  │  │  └─ onboading_one_controller.dart
│  │  │  ├─ models
│  │  │  │  └─ onboading_one_model.dart
│  │  │  └─ onboading_one_screen.dart
│  │  ├─ onboarding_three_screen
│  │  │  ├─ binding
│  │  │  │  └─ onboarding_three_binding.dart
│  │  │  ├─ controller
│  │  │  │  └─ onboading_three_controller.dart
│  │  │  ├─ models
│  │  │  │  └─ onboading_three_model.dart
│  │  │  └─ onboading_three_screen.dart
│  │  ├─ onboarding_two_screen
│  │  │  ├─ binding
│  │  │  │  └─ onboarding_two_binding.dart
│  │  │  ├─ controller
│  │  │  │  └─ onboading_two_controller.dart
│  │  │  ├─ models
│  │  │  │  └─ onboading_two_model.dart
│  │  │  └─ onboading_two_screen.dart
│  │  ├─ sign_in_screen
│  │  │  ├─ binding
│  │  │  │  └─ sign_in_binding.dart
│  │  │  ├─ controller
│  │  │  │  └─ sign_in_controller.dart
│  │  │  ├─ models
│  │  │  │  └─ sign_in_model.dart
│  │  │  └─ sign_in_screen.dart
│  │  ├─ splash_screen
│  │  │  ├─ binding
│  │  │  │  └─ splash_binding.dart
│  │  │  ├─ controller
│  │  │  │  └─ splash_controller.dart
│  │  │  ├─ models
│  │  │  │  └─ splash_model.dart
│  │  │  └─ splash_screen.dart
│  │  └─ welcome_screen
│  │     ├─ binding
│  │     │  └─ welcome_binding.dart
│  │     ├─ controller
│  │     │  └─ welcome_controller.dart
│  │     ├─ models
│  │     │  └─ welcome_model.dart
│  │     └─ welcome_screen.dart
│  ├─ routes
│  │  └─ app_routes.dart
│  ├─ theme
│  │  ├─ app_decoration.dart
│  │  ├─ custom_button_style.dart
│  │  ├─ custom_text_style.dart
│  │  └─ theme_helper.dart
│  └─ widgets
│     ├─ app_bar
│     │  ├─ appbar_leading_image.dart
│     │  ├─ appbar_title.dart
│     │  └─ custom_app_bar.dart
│     ├─ base_button.dart
│     ├─ custom_bottom_bar.dart
│     ├─ custom_elevated_button.dart
│     ├─ custom_image_view.dart
│     ├─ custom_outlined_button.dart
│     └─ custom_text_form_field.dart
├─ pubspec.lock
├─ pubspec.yaml
├─ README.md
└─ test
   └─ widget_test.dart

