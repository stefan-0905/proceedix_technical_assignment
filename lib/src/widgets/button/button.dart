import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:proceedix_technical_assignment/src/app_theme_colors.dart';
import 'package:proceedix_technical_assignment/src/widgets/button/button_type.dart';

class Button extends StatelessWidget {
  const Button({
    super.key,
    required this.label,
    this.onPressedCallback,
    this.type = ButtonType.elevated,
    this.trailingChevron = false,
    this.showIcon = false,
    this.icon,
  });

  final String label;
  final VoidCallback? onPressedCallback;
  final ButtonType type;
  final bool trailingChevron;
  final bool showIcon;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    final backgroundColor =
        type == ButtonType.secondary ? AppThemeColors.secondary : Colors.white;
    final textColor =
        type != ButtonType.secondary ? AppThemeColors.secondary : Colors.white;

    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50.0),
        ),
        visualDensity: const VisualDensity(vertical: 2),
      ),
      onPressed: onPressedCallback,
      child: Row(
        children: [
          Expanded(
            child: Text.rich(
              TextSpan(
                children: [
                  if (showIcon && icon != null)
                    WidgetSpan(
                        child: Icon(
                      icon,
                      color: textColor,
                      size: 18,
                    ),),
                  const WidgetSpan(
                    child: SizedBox(width: 10),
                  ),
                  TextSpan(
                    text: label,
                    style: TextStyle(
                      color: textColor,
                      fontSize: 18,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ],
              ),
              textAlign: TextAlign.center,
            ),
          ),
          if (trailingChevron)
            Icon(
              FluentIcons.caret_right_16_filled,
              color: textColor,
              size: 18,
            ),
        ],
      ),
    );
  }
}
