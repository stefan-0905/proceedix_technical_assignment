import 'package:flutter/material.dart';
import 'package:proceedix_technical_assignment/src/app_theme_colors.dart';
import 'package:proceedix_technical_assignment/src/app_translation.dart';
import 'package:proceedix_technical_assignment/src/widgets/button/button.dart';
import 'package:proceedix_technical_assignment/src/widgets/button/button_type.dart';

final List<Widget> subscriptionTypes = [
  const Text(AppTranslation.monthly),
  const Text(AppTranslation.annual),
];

class AnnualToggler extends StatefulWidget {
  const AnnualToggler({super.key, this.toggle});

  final void Function(bool isAnnualNew)? toggle;

  @override
  State<AnnualToggler> createState() => _AnnualTogglerState();
}

class _AnnualTogglerState extends State<AnnualToggler> {
  final List<bool> _selectedSubscriptionType = [true, false];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ToggleButtons(
          direction: Axis.horizontal,
          onPressed: _onToggle,
          borderRadius: const BorderRadius.all(Radius.circular(8)),
          selectedColor: Colors.white,
          fillColor: AppThemeColors.secondary,
          color: AppThemeColors.pink,
          constraints: const BoxConstraints(
            minHeight: 40.0,
            minWidth: 80.0,
          ),
          isSelected: _selectedSubscriptionType,
          children: subscriptionTypes,
        ),
      ],
    );
  }

  void _onToggle(int index) {
    setState(() {
      // The button that is tapped is set to true, and the others to false.
      for (int i = 0; i < _selectedSubscriptionType.length; i++) {
        _selectedSubscriptionType[i] = i == index;
      }
    });

    widget.toggle?.call(index == 1);

    if (_selectedSubscriptionType[1]) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text(AppTranslation.annualSubscription),
          content: const Text(AppTranslation.annualDiscount),
          actions: [
            Button(
              label: AppTranslation.ok,
              type: ButtonType.secondary,
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      );
    }
  }
}
