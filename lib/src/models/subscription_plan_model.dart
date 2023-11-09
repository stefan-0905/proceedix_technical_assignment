import 'package:proceedix_technical_assignment/src/models/pricing_tier_model.dart';

class SubscriptionPlanModel {
  const SubscriptionPlanModel({
    required this.tier,
    this.isAnnual = false,
  });

  final PricingTierModel tier;
  final bool isAnnual;
}
