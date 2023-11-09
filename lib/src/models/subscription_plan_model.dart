import 'package:proceedix_technical_assignment/src/util/format_price.dart';
import 'package:proceedix_technical_assignment/src/util/subscription_plan_tier.dart';

class SubscriptionPlanModel {
  const SubscriptionPlanModel({
    required this.title,
    required this.amount,
    this.isAnnual = false,
  });

  final SubscriptionPlanTier title;
  final double amount;
  final bool isAnnual;

  String getPrice({bool? isAnnualOverride}) =>
      formatWithCurrency(isAnnualOverride ?? isAnnual ? amount * 10 : amount);

  String getAnnualPrice() =>
      formatWithCurrency(isAnnual ? amount * 10 : amount * 12);
}
