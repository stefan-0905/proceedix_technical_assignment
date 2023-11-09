import 'package:flutter/material.dart';
import 'package:proceedix_technical_assignment/src/app_translation.dart';
import 'package:proceedix_technical_assignment/src/models/subscription_plan_model.dart';
import 'package:proceedix_technical_assignment/src/util/format_price.dart';
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
            subscription.tier.title.name.toUpperCase(),
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        ListTile(
          title: const Text(AppTranslation.price),
          trailing: Text(
            subscription.isAnnual
                ? formatWithCurrency(subscription.tier.amount * 10)
                : formatWithCurrency(subscription.tier.amount),
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
            subscription.isAnnual
                ? formatWithCurrency(subscription.tier.amount * 10)
                : formatWithCurrency(subscription.tier.amount * 12),
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        )
      ]),
    );
  }
}
