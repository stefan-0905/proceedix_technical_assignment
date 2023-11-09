import 'package:flutter/material.dart';
import 'package:proceedix_technical_assignment/src/app_theme_colors.dart';

class SubscriptionTier extends StatelessWidget {
  const SubscriptionTier({
    super.key,
    required this.title,
    required this.trailing,
    required this.isSelected,
    required this.onTap,
  });
  final String title;
  final String trailing;
  final bool isSelected;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
      selected: isSelected,
      tileColor: AppThemeColors.secondary.withOpacity(0.15),
      selectedTileColor: AppThemeColors.secondary,
      selectedColor: Colors.white,
      onTap: onTap,
      title: Text(
        title.toUpperCase(),
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      trailing: Text(
        trailing,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  }
}
