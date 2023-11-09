import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:go_router/go_router.dart';
import 'package:proceedix_technical_assignment/src/app_translation.dart';
import 'package:proceedix_technical_assignment/src/features/subscription_form/widgets/info_form.dart';
import 'package:proceedix_technical_assignment/src/features/subscription_form/widgets/pricing/subscription.dart';
import 'package:proceedix_technical_assignment/src/features/subscription_form/widgets/summary/summary.dart';
import 'package:proceedix_technical_assignment/src/models/person_model.dart';
import 'package:proceedix_technical_assignment/src/models/subscription_plan_model.dart';
import 'package:proceedix_technical_assignment/src/routing/route_names.dart';
import 'package:proceedix_technical_assignment/src/widgets/button/button.dart';
import 'package:proceedix_technical_assignment/src/widgets/button/button_type.dart';

class SubscriptionFormView extends StatefulWidget {
  const SubscriptionFormView({super.key});

  @override
  State<SubscriptionFormView> createState() => _SubscriptionFormViewState();
}

class _SubscriptionFormViewState extends State<SubscriptionFormView> {
  late List<Step> steps;

  int _currentStep = 0;

  final _formKey = GlobalKey<FormBuilderState>();
  SubscriptionPlanModel? subscriptionPlan;

  @override
  Widget build(BuildContext context) {
    steps = getSteps();

    return Scaffold(
      body: Center(
        child: FormBuilder(
          key: _formKey,
          child: Stepper(
            currentStep: _currentStep,
            steps: steps,
            type: StepperType.horizontal,
            onStepContinue: _next,
            onStepCancel: _previousPage,
            controlsBuilder: (context, details) {
              return Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 30),
                child: Row(
                  children: [
                    if (_currentStep > 0)
                      Expanded(
                        child: Button(
                          label: AppTranslation.back,
                          onPressed: details.onStepCancel,
                        ),
                      )
                    else
                      const Spacer(),
                    const Spacer(),
                    Expanded(
                      child: Button(
                        label: _currentStep == steps.length - 1
                            ? AppTranslation.confirm
                            : AppTranslation.next,
                        type: ButtonType.secondary,
                        onPressed: details.onStepContinue,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  List<Step> getSteps() => [
        Step(
          title: Text(_currentStep == 0 ? AppTranslation.contact : ""),
          content: const InfoForm(),
          isActive: _currentStep >= 0,
          state: _currentStep > 0 ? StepState.complete : StepState.indexed,
        ),
        Step(
          title: Text(_currentStep == 1 ? AppTranslation.subscription : ''),
          content: Subscription(
            subscriptionPlan: subscriptionPlan,
            setSubscriptionPlan: _selectSubscriptionPlan,
          ),
          isActive: _currentStep >= 1,
          state: _currentStep > 1 ? StepState.complete : StepState.indexed,
        ),
        Step(
          title: Text(_currentStep == 2 ? AppTranslation.summary : ''),
          content: Summary(
            person: _getUser(),
            subscriptionPlan: subscriptionPlan,
          ),
          isActive: _currentStep >= 2,
          state: _currentStep > 2 ? StepState.complete : StepState.indexed,
        ),
      ];

  PersonModel? _getUser() {
    final state = _formKey.currentState;
    if (state == null) {
      return null;
    }
    final formValues = state.instantValue;

    return PersonModel(
      name: formValues['name'],
      email: formValues['email'],
      number: formValues['phoneNumber'],
    );
  }

  void _selectSubscriptionPlan(SubscriptionPlanModel tier) {
    setState(() {
      subscriptionPlan = tier;
    });
  }

  void _next() {
    if (_currentStep < steps.length - 1) {
      if (_validate()) {
        return _nextPage();
      }
    }

    _confirm();    
  }

  bool _validate() {
    if (_formKey.currentState?.validate() == false) {
      return false;
    }

    return true;
  }

  void _nextPage() {
    setState(() => _currentStep += 1);
  }

  void _previousPage() {
    if (_currentStep >= 0) {
      setState(() => _currentStep -= 1);
    }
  }

  void _confirm() {
    context.goNamed(RouteNames.thankYou);
  }
}
