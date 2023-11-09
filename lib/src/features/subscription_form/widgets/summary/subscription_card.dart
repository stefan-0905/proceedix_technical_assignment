import 'package:flutter/material.dart';
import 'package:proceedix_technical_assignment/src/app_translation.dart';
import 'package:proceedix_technical_assignment/src/models/subscription_plan_model.dart';
import 'package:proceedix_technical_assignment/src/widgets/spacing.dart';

class SubscriptionCard extends StatelessWidget {
  const SubscriptionCard({
    super.key,
    required this.subscription,
  });

  final SubscriptionPlanModel subscription;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(children: [
        ListTile(
          title: const Text(AppTranslation.tier),
          trailing: Text(
            subscription.title.name.toUpperCase(),
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        ListTile(
          title: const Text(AppTranslation.price),
          trailing: Text(
            subscription.getPrice(),
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        ListTile(
          title: const Text(AppTranslation.frequency),
          trailing: Text(
            subscription.isAnnual
                ? AppTranslation.annual
                : AppTranslation.monthly,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const Spacing(),
        ListTile(
          title: const Text(AppTranslation.totalPerYear),
          trailing: Text(
            subscription.getAnnualPrice(),
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        )
      ]),
    );
  }
}
