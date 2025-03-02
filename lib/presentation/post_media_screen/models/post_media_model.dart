class PostMediaModel {
  String categoryName;
  String imageIcon;
  String redirectString;

  PostMediaModel({
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
  factory PostMediaModel.fromJson(Map<String, dynamic> json) {
    return PostMediaModel(
      categoryName: json['category_name'] ?? '',
      imageIcon: json['image_icon'] ?? '',
      redirectString: json['redirect_string'] ?? '',
    );
  }
}
