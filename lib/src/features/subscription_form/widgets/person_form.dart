import 'dart:io';

import 'package:flutter/material.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:proceedix_technical_assignment/src/app_translation.dart';
import 'package:proceedix_technical_assignment/src/widgets/spacing.dart';
import 'package:proceedix_technical_assignment/src/widgets/text_input.dart';

class PersonForm extends StatelessWidget {
  const PersonForm({super.key});

  @override
  Widget build(BuildContext context) {
    final width = Platform.isAndroid || Platform.isIOS ? 1 : 0.5;

    return Center(
      child: SizedBox(
        width: MediaQuery.of(context).size.width * width,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              TextInput(
                name: 'name',
                label: AppTranslation.name,
                validator: FormBuilderValidators.required(),
              ),
              const Spacing(),
              TextInput(
                name: 'email',
                label: AppTranslation.email,
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.email(),
                  FormBuilderValidators.required(),
                ]),
                textInputType: TextInputType.emailAddress,
              ),
              const Spacing(),
              TextInput(
                name: 'phoneNumber',
                label: AppTranslation.phoneNumber,
                validator: FormBuilderValidators.required(),
                textInputType: TextInputType.number,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
