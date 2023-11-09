import 'package:flutter/material.dart';
import 'package:proceedix_technical_assignment/src/features/subscription_form/widgets/pricing/annual_toggler.dart';
import 'package:proceedix_technical_assignment/src/features/subscription_form/widgets/pricing/tier.dart';
import 'package:proceedix_technical_assignment/src/models/pricing_tier_model.dart';
import 'package:proceedix_technical_assignment/src/models/subscription_plan_model.dart';
import 'package:proceedix_technical_assignment/src/util/pricing_tier_label.dart';
import 'package:proceedix_technical_assignment/src/widgets/spacing.dart';

List<PricingTierModel> tiers = [
  PricingTierModel(amount: 9, title: PricingTierLabel.basic),
  PricingTierModel(amount: 12, title: PricingTierLabel.normal),
  PricingTierModel(amount: 15, title: PricingTierLabel.advanced),
];

class Subscription extends StatefulWidget {
  const Subscription({
    super.key,
    required this.setSelectedTier,
    this.selectedTier,
  });

  final void Function(SubscriptionPlanModel tier) setSelectedTier;
  final SubscriptionPlanModel? selectedTier;

  @override
  State<Subscription> createState() => _SubscriptionState();
}

class _SubscriptionState extends State<Subscription> {
  bool isAnnual = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "${isAnnual ? 'Yearly' : 'Monthly'} Subscription",
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        const Spacing(),
        ...tiers.map(
          (tier) => Tier(
            title: tier.title.name,
            trailing: isAnnual
                ? "${tier.amount * 10} / year"
                : "${tier.amount} / month",
            isSelected: widget.selectedTier?.tier.title == tier.title,
            onTap: () => _onTierSelected(tier, isAnnual: isAnnual),
          ),
        ),
        const Spacing(),
        AnnualToggler(
          toggle: _toggleIsAnnual,
        ),
      ],
    );
  }

  void _toggleIsAnnual(bool isAnnualNew) {
    setState(() {
      isAnnual = isAnnualNew;
    });
    final selected = widget.selectedTier;
    if (selected != null) {
      _onTierSelected(
        selected.tier,
        isAnnual: isAnnualNew,
      );
    }
  }

  void _onTierSelected(PricingTierModel tier, {bool isAnnual = false}) {
    widget.setSelectedTier(
      SubscriptionPlanModel(
        tier: tier,
        isAnnual: isAnnual,
      ),
    );
  }
}
