// user_details_model.dart
import 'dart:convert';

class UserDetailsModel {
  final String firstName;
  final String lastName;
  final String email;
  final String mobileNumber;
  final String location;
  final String skills;
  final int? age;
  late final String? profileImageUrl;

  UserDetailsModel({
    required this.firstName,
    required this.lastName,
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
      'first_name': firstName,
      'last_name': lastName,
      'email': email,
      'mobile_number': mobileNumber,
      'location': location,
      'skills': skills,
      'age': age,
      'avatar_url': profileImageUrl,
    };
  }

  // Create instance from JSON
  factory UserDetailsModel.fromJson(Map<String, dynamic> json) {
    return UserDetailsModel(
      firstName: json['first_name'],
      lastName: json['last_name'],
      email: json['email'],
      mobileNumber: json['mobile_number'],
      location: json['location'],
      skills: json['skills'],
      age: json['age'],
      profileImageUrl: json['avatar_url'],
    );
  }

  // Validate fields
  bool isValid() {
    return firstName.isNotEmpty &&
        lastName.isNotEmpty &&
        email.isNotEmpty &&
        mobileNumber.isNotEmpty &&
        location.isNotEmpty &&
        skills.isNotEmpty &&
        (age == null || age! > 0);
  }
}
