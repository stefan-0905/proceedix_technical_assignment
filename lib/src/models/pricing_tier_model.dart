import 'package:proceedix_technical_assignment/src/util/pricing_tier_label.dart';

class PricingTierModel {
  PricingTierModel({
    required this.amount,
    required this.title,
    this.isYearly = false,
  });

  final double amount;
  final PricingTierLabel title;
  bool isYearly;
}
