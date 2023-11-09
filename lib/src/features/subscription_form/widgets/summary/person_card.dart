import 'package:flutter/material.dart';
import 'package:proceedix_technical_assignment/src/app_translation.dart';
import 'package:proceedix_technical_assignment/src/models/person_model.dart';

class PersonCard extends StatelessWidget {
  const PersonCard({
    super.key,
    required this.person,
  });

  final PersonModel person;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            title: const Text(AppTranslation.name),
            trailing: Text(
              person.name,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          ListTile(
            title: const Text(AppTranslation.email),
            trailing: Text(
              person.email,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          ListTile(
            title: const Text(AppTranslation.phoneNumber),
            trailing: Text(
              person.number,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
