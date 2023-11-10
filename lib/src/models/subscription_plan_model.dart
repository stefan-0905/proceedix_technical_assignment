import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:proceedix_technical_assignment/src/features/services/shared_preferences_wrapper.dart';
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

  Map<String, dynamic> toJson() {
    return {
      'title': title.name,
      'amount': amount,
      'isAnnual': isAnnual,
    };
  }

  static SubscriptionPlanModel fromJson(Map<String, dynamic> json) {
    return SubscriptionPlanModel(
      title: SubscriptionPlanTier.values.byName(json['title']),
      amount: json['amount'],
      isAnnual: json['isAnnual'],
    );
  }

  Future<void> toSharePreferences() async {
    final serialized = toJson();
    await SharedPreferencesWrapper()
        .saveObject('subscription', jsonEncode(serialized));
  }

  static SubscriptionPlanModel? fromSharedPreferences() {
    final string = SharedPreferencesWrapper().getObject('subscription');
    if (string != null) {
      debugPrint(string);
      return fromJson(jsonDecode(string));
    }
    return null;
  }

  void removeFromSharedPreferences() {
    SharedPreferencesWrapper().remove('subscription');
  }
}
