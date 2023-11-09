import 'package:flutter/material.dart';
import 'package:proceedix_technical_assignment/src/app_translation.dart';
import 'package:proceedix_technical_assignment/src/features/subscription_form/widgets/summary/person_card.dart';
import 'package:proceedix_technical_assignment/src/features/subscription_form/widgets/summary/subscription_card.dart';
import 'package:proceedix_technical_assignment/src/models/person_model.dart';
import 'package:proceedix_technical_assignment/src/models/subscription_plan_model.dart';
import 'package:proceedix_technical_assignment/src/widgets/spacing.dart';

class Summary extends StatelessWidget {
  const Summary({
    super.key,
    required this.person,
    required this.subscriptionPlan,
  });

  final PersonModel? person;
  final SubscriptionPlanModel? subscriptionPlan;

  @override
  Widget build(BuildContext context) {
    final localPerson = person;
    final localSubscription = subscriptionPlan;
    if (localPerson == null || localSubscription == null) {
      return Container();
    }

    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.all(10.0),
                child: Text(
                  AppTranslation.contact,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              PersonCard(
                person: localPerson,
              ),
              const Spacing(),
              const Padding(
                padding: EdgeInsets.all(10.0),
                child: Text(
                  AppTranslation.subscription,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SubscriptionCard(
                subscription: localSubscription,
              )
            ],
          ),
        ),
      ],
    );
  }
}
