// create_teaching_event_model.dart
import 'dart:convert';

import 'package:google_maps_flutter/google_maps_flutter.dart';

class UserDetailsModel {
  final String fullName;

  final String email;
  final String mobileNumber;
  final String location;
  final Map<String, dynamic> location_cords;
  final String skills;
  final int? age;
  late final String? profileImageUrl;

  UserDetailsModel({
    required this.fullName,
    required this.email,
    required this.mobileNumber,
    required this.location,
    required this.location_cords,
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
      'location_cords': location_cords,
      'skills': skills,
      'age': age,
      'avatar_url': profileImageUrl,
    };
  }

  // Create instance from JSON
  factory UserDetailsModel.fromJson(Map<String, dynamic> json) {
    return UserDetailsModel(
      fullName: json['full_name'],
      email: json['username'],
      mobileNumber: json['mobile_number'],
      location: json['location'],
      location_cords: json['location_cords'] is String
          ? jsonDecode(json['location_cords'])
          : Map<String, dynamic>.from(json['location_cords']),
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
