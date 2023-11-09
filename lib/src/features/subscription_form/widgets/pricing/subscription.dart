import 'package:flutter/material.dart';
import 'package:proceedix_technical_assignment/src/app_translation.dart';
import 'package:proceedix_technical_assignment/src/features/subscription_form/widgets/pricing/annual_toggler.dart';
import 'package:proceedix_technical_assignment/src/features/subscription_form/widgets/pricing/subscription_tier.dart';
import 'package:proceedix_technical_assignment/src/models/subscription_plan_model.dart';
import 'package:proceedix_technical_assignment/src/util/subscription_plan_tier.dart';
import 'package:proceedix_technical_assignment/src/widgets/spacing.dart';

List<SubscriptionPlanModel> plans = [
  const SubscriptionPlanModel(amount: 9, title: SubscriptionPlanTier.basic),
  const SubscriptionPlanModel(amount: 12, title: SubscriptionPlanTier.normal),
  const SubscriptionPlanModel(amount: 15, title: SubscriptionPlanTier.advanced),
];

class Subscription extends StatefulWidget {
  const Subscription({
    super.key,
    required this.setSubscriptionPlan,
    this.subscriptionPlan,
  });

  final void Function(SubscriptionPlanModel tier) setSubscriptionPlan;
  final SubscriptionPlanModel? subscriptionPlan;

  @override
  State<Subscription> createState() => _SubscriptionState();
}

class _SubscriptionState extends State<Subscription> {
  bool isAnnual = false;

  @override
  void initState() {
    isAnnual = widget.subscriptionPlan?.isAnnual ?? false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "${isAnnual ? AppTranslation.annual : AppTranslation.monthly} ${AppTranslation.subscription}",
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        const Spacing(),
        ...plans.map(
          (plan) => SubscriptionTier(
            title: plan.title.name,
            trailing:
                "${plan.getPrice(isAnnualOverride: isAnnual)} / ${isAnnual ? AppTranslation.year : AppTranslation.month}",
            isSelected: widget.subscriptionPlan?.title == plan.title,
            onTap: () => _onPlanSelected(plan, isAnnual: isAnnual),
          ),
        ),
        const Spacing(),
        AnnualToggler(
          initialValue: isAnnual,
          toggle: _toggleIsAnnual,
        ),
      ],
    );
  }

  void _toggleIsAnnual(bool isAnnualNew) {
    setState(() {
      isAnnual = isAnnualNew;
    });
    final selected = widget.subscriptionPlan;
    if (selected != null) {
      _onPlanSelected(
        selected,
        isAnnual: isAnnualNew,
      );
    }
  }

  void _onPlanSelected(SubscriptionPlanModel plan, {bool isAnnual = false}) {
    widget.setSubscriptionPlan(
      SubscriptionPlanModel(
        title: plan.title,
        amount: plan.amount,
        isAnnual: isAnnual,
      ),
    );
  }
}
