class CreateEventCategoryModel {
  String categoryName;
  String imageIcon;
  String redirectString;

  CreateEventCategoryModel({
    required this.categoryName,
    required this.imageIcon,
    required this.redirectString,
  });

  // Convert to JSON for API request
  Map<String, dynamic> toJson() {
    return {
      'category_name': categoryName,
      'image_icon': imageIcon,
      'redirect_string': redirectString,
    };
  }

  // Create instance from JSON
  factory CreateEventCategoryModel.fromJson(Map<String, dynamic> json) {
    return CreateEventCategoryModel(
      categoryName: json['category_name'] ?? '',
      imageIcon: json['image_icon'] ?? '',
      redirectString: json['redirect_string'] ?? '',
    );
  }
}
