import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:proceedix_technical_assignment/src/features/subscription_form/widgets/info_form.dart';
import 'package:proceedix_technical_assignment/src/features/subscription_form/widgets/pricing/subscription.dart';
import 'package:proceedix_technical_assignment/src/features/subscription_form/widgets/summary.dart';
import 'package:proceedix_technical_assignment/src/models/subscription_plan_model.dart';
import 'package:proceedix_technical_assignment/src/widgets/button/button.dart';
import 'package:proceedix_technical_assignment/src/widgets/button/button_type.dart';

class SubscriptionFormView extends StatefulWidget {
  const SubscriptionFormView({super.key});

  @override
  State<SubscriptionFormView> createState() => _SubscriptionFormViewState();
}

class _SubscriptionFormViewState extends State<SubscriptionFormView> {
  int _currentStep = 0;
  final _formKey = GlobalKey<FormBuilderState>();
  SubscriptionPlanModel? selectedTier;
  late List<Step> steps;

  @override
  Widget build(BuildContext context) {
    steps = getSteps();

    return Scaffold(
      body: Container(
        padding: const EdgeInsets.only(top: 100),
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
                          label: 'Back',
                          onPressed: details.onStepCancel,
                        ),
                      )
                    else
                      const Spacer(),
                    const Spacer(),
                    Expanded(
                      child: Button(
                         label: _currentStep == steps.length - 1
                            ? 'Confirm'
                            : 'Next',
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
          title: Text(_currentStep == 0 ? 'Information' : ""),
          content: const InfoForm(),
          isActive: _currentStep >= 0,
          state: _currentStep > 0 ? StepState.complete : StepState.indexed,
        ),
        Step(
          title: Text(_currentStep == 1 ? 'Subscription' : ''),
          content: Subscription(
            selectedTier: selectedTier,
            setSelectedTier: _selectTier,
          ),
          isActive: _currentStep >= 1,
          state: _currentStep > 1 ? StepState.complete : StepState.indexed,
        ),
        Step(
          title: Text(_currentStep == 2 ? 'Summary' : ''),
          content: const Summary(),
          isActive: _currentStep >= 2,
          state: _currentStep > 2 ? StepState.complete : StepState.indexed,
        ),
      ];

  void _selectTier(SubscriptionPlanModel tier) {
    setState(() {
      selectedTier = tier;
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
    debugPrint(_currentStep.toString());
  }

  void _previousPage() {
    if (_currentStep >= 0) {
      setState(() => _currentStep -= 1);
    }
  }

  void _confirm() {}
}
