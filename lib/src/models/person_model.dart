import 'dart:convert';

import 'package:proceedix_technical_assignment/src/features/services/shared_preferences_wrapper.dart';

class PersonModel {
  const PersonModel({
    required this.name,
    required this.email,
    required this.phoneNumber,
  });

  final String name;
  final String email;
  final String phoneNumber;

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'phoneNumber': phoneNumber,
    };
  }

  static PersonModel fromJson(Map<String, dynamic> json) {
    return PersonModel(
      name: json['name'],
      email: json['email'],
      phoneNumber: json['phoneNumber'],
    );
  }

  Future<void> toSharePreferences() async {
    final serialized = toJson();
    await SharedPreferencesWrapper()
        .saveObject('person', jsonEncode(serialized));
  }

  static PersonModel? fromSharedPreferences() {
    final string = SharedPreferencesWrapper().getObject('person');
    if (string != null) {
      return fromJson(jsonDecode(string));
    }
    return null;
  }

  void removeFromSharedPreferences() {
    SharedPreferencesWrapper().remove('person');
  }
}
