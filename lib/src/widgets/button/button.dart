import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:proceedix_technical_assignment/src/app_theme_colors.dart';
import 'package:proceedix_technical_assignment/src/widgets/button/button_type.dart';

class Button extends StatelessWidget {
  const Button({
    super.key,
    required this.label,
    this.onPressed,
    this.type = ButtonType.elevated,
    this.trailingChevron = false,
    this.showIcon = false,
    this.icon,
    this.isDisabled = false,
  });

  final String label;
  final VoidCallback? onPressed;
  final ButtonType type;
  final bool trailingChevron;
  final bool showIcon;
  final IconData? icon;
  final bool isDisabled;

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
      onPressed: isDisabled ? null : onPressed,
      child: Row(
        children: [
          Expanded(
            child: Text.rich(
              textAlign: TextAlign.center,
              TextSpan(
                children: [
                  if (showIcon && icon != null)
                    WidgetSpan(
                      child: Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: Icon(
                          icon,
                          color: textColor,
                          size: 18,
                        ),
                      ),
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
