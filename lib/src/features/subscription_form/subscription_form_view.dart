import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:go_router/go_router.dart';
import 'package:proceedix_technical_assignment/src/app_theme_colors.dart';
import 'package:proceedix_technical_assignment/src/app_translation.dart';
import 'package:proceedix_technical_assignment/src/features/subscription_form/widgets/person_form.dart';
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
  SubscriptionPlanModel? _subscriptionPlan;
  late PersonModel? _person;

  @override
  void initState() {
    _subscriptionPlan = _initSubscriptionFromStorage();
    _person = _initPersonFromStorage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    steps = getSteps();

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(AppTranslation.subscription),
        backgroundColor: AppThemeColors.secondary,
      ),
      body: FormBuilder(
        key: _formKey,
        initialValue: _person?.toJson() ?? {},
        child: Stepper(
          currentStep: _currentStep,
          steps: steps,
          connectorColor:
              const MaterialStatePropertyAll(AppThemeColors.secondary),
          type: StepperType.horizontal,
          onStepContinue: _next,
          onStepCancel: _previousPage,
          controlsBuilder: (context, details) {
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 30),
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
    );
  }

  List<Step> getSteps() => [
        Step(
          title: Text(_currentStep == 0 ? AppTranslation.contact : ""),
          content: const PersonForm(),
          isActive: _currentStep >= 0,
          state: _currentStep > 0 ? StepState.complete : StepState.indexed,
        ),
        Step(
          title: Text(_currentStep == 1 ? AppTranslation.subscription : ''),
          content: Subscription(
            subscriptionPlan: _subscriptionPlan,
            setSubscriptionPlan: _setSubscriptionPlan,
          ),
          isActive: _currentStep >= 1,
          state: _currentStep > 1 ? StepState.complete : StepState.indexed,
        ),
        Step(
          title: Text(_currentStep == 2 ? AppTranslation.summary : ''),
          content: Summary(
            person: _person,
            subscriptionPlan: _subscriptionPlan,
          ),
          isActive: _currentStep >= 2,
          state: _currentStep > 2 ? StepState.complete : StepState.indexed,
        ),
      ];

  SubscriptionPlanModel? _initSubscriptionFromStorage() {
    return SubscriptionPlanModel.fromSharedPreferences();
  }

  PersonModel? _initPersonFromStorage() {
    return PersonModel.fromSharedPreferences();
  }

  PersonModel? _getPersonFromForm() {
    final state = _formKey.currentState;
    if (state == null) {
      return null;
    }
    final formValues = state.instantValue;

    return PersonModel.fromJson(formValues);
  }

  void _setSubscriptionPlan(SubscriptionPlanModel plan) {
    setState(() {
      _subscriptionPlan = plan;
    });
  }

    void _setPerson(PersonModel? person) {
    setState(() {
      _person = person;
    });
  }

  void _next() async {
    if (_currentStep < steps.length - 1) {
      if (await _validate()) {
        return _nextPage();
      }
      return;
    }

    _confirm();
  }

  Future<bool> _validate() async {
    switch (_currentStep) {
      case 0:
        {
          // First step validation
          if (_formKey.currentState?.validate() == false) {
            return false;
          }

          _setPerson(_getPersonFromForm());
          await _person?.toSharePreferences();

          break;
        }
      case 1:
        {
          // Second step validation
          if (_currentStep == 1 && _subscriptionPlan == null) {
            _showSubscriptionRequiredModal();
            return false;
          }

          await _subscriptionPlan?.toSharePreferences();

          break;
        }
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
    _reset();
    context.goNamed(RouteNames.thankYou);
  }

  void _reset() {
    _currentStep = 0;
    _formKey.currentState?.reset();
    _subscriptionPlan?.removeFromSharedPreferences();
    _person?.removeFromSharedPreferences();
  }

  void _showSubscriptionRequiredModal() {
    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text(AppTranslation.subscriptionRequired),
        content: const Text(AppTranslation.subscriptionRequiredContent),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text(AppTranslation.ok),
          ),
        ],
      ),
    );
  }
}
