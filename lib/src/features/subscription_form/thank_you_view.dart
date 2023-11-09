import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:proceedix_technical_assignment/src/app_translation.dart';
import 'package:proceedix_technical_assignment/src/routing/route_names.dart';
import 'package:proceedix_technical_assignment/src/widgets/button/button.dart';
import 'package:proceedix_technical_assignment/src/widgets/spacing.dart';

class ThankYouView extends StatelessWidget {
  const ThankYouView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              AppTranslation.thankYou,
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            const Spacing(),
            SizedBox(
              width: 300,
              child: Button(
                label: AppTranslation.orderAgain,
                onPressed: () => context.goNamed(
                  RouteNames.subscribe,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
