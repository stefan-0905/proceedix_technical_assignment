import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:proceedix_technical_assignment/src/app_theme_colors.dart';

class TextInput extends StatelessWidget {
  const TextInput({
    super.key,
    required this.name,
    this.label,
    this.validator,
    this.textInputType = TextInputType.text,
  });

  final String name;
  final String? label;
  final String? Function(String?)? validator;
  final TextInputType textInputType;

  @override
  Widget build(BuildContext context) {
    return FormBuilderTextField(
      name: name,
      validator: validator,
      keyboardType: textInputType,
      decoration: InputDecoration(
        hintText: label,
        hintStyle: const TextStyle(
          color: Colors.grey,
          fontSize: 15,
        ),
        filled: true,
        fillColor: Colors.white24,
        focusedErrorBorder: _outlineInputBorder(color: Colors.red),
        errorBorder: _outlineInputBorder(color: Colors.red),
        focusedBorder: _outlineInputBorder(color: AppThemeColors.secondary),
        border: _outlineInputBorder(),
      ),
    );
  }

  OutlineInputBorder _outlineInputBorder({Color? color}) {
    return OutlineInputBorder(
      borderRadius: const BorderRadius.all(Radius.circular(8)),
      borderSide: color == null
          ? const BorderSide(color: Colors.grey)
          : BorderSide(
              color: color,
            ),
    );
  }
}
