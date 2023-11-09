import 'package:flutter/material.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:proceedix_technical_assignment/src/app_translation.dart';
import 'package:proceedix_technical_assignment/src/widgets/spacing.dart';
import 'package:proceedix_technical_assignment/src/widgets/text_input.dart';

class InfoForm extends StatelessWidget {
  const InfoForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
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
    );
  }
}
