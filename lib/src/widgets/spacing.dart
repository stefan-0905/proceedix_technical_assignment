import 'package:flutter/material.dart';

enum SpacingType {
  horizontal,
  vertical,
}

class Spacing extends StatelessWidget {
  const Spacing({
    super.key,
    this.type = SpacingType.vertical,
    this.height = 20,
    this.width = 10,
  });

  final SpacingType type;
  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    if (type == SpacingType.horizontal) {
      return SizedBox(
        width: width,
      );
    } else {
      return SizedBox(
        height: height,
      );
    }
  }
}
