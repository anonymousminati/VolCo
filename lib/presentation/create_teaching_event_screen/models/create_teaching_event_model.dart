// create_teaching_event_model.dart
import 'dart:convert';

class CreateTeachingEventModel {
  final String fullName;

  final String email;
  final String mobileNumber;
  final String location;
  final String skills;
  final int? age;
  late final String? profileImageUrl;

  CreateTeachingEventModel({
    required this.fullName,
    required this.email,
    required this.mobileNumber,
    required this.location,
    required this.skills,
    this.age,
    this.profileImageUrl,
  });

  // Convert to JSON for API request
  Map<String, dynamic> toJson() {
    return {
      'full_name': fullName,
      'username': email,
      'mobile_number': mobileNumber,
      'location': location,
      'skills': skills,
      'age': age,
      'avatar_url': profileImageUrl,
    };
  }

  // Create instance from JSON
  factory CreateTeachingEventModel.fromJson(Map<String, dynamic> json) {
    return CreateTeachingEventModel(
      fullName: json['full_name'],
      email: json['username'],
      mobileNumber: json['mobile_number'],
      location: json['location'],
      skills: json['skills'],
      age: json['age'],
      profileImageUrl: json['avatar_url'],
    );
  }

  // Validate fields
  bool isValid() {
    print("userdetailsvalid: ${fullName.isNotEmpty} , ${email.isNotEmpty} , ${mobileNumber.isNotEmpty} , ${location.isNotEmpty} , ${skills.isNotEmpty} , ${age == null || age! > 0}");
    return fullName.isNotEmpty &&
        email.isNotEmpty &&
        mobileNumber.isNotEmpty &&
        location.isNotEmpty &&
        skills.isNotEmpty &&
        (age == null || age! > 0);
  }
}
