import 'package:flutter/material.dart';
import 'package:proceedix_technical_assignment/src/features/subscription_form/widgets/info_form.dart';
import 'package:proceedix_technical_assignment/src/features/subscription_form/widgets/pricing_tiers.dart';
import 'package:proceedix_technical_assignment/src/features/subscription_form/widgets/summary.dart';
import 'package:proceedix_technical_assignment/src/widgets/button/button.dart';
import 'package:proceedix_technical_assignment/src/widgets/button/button_type.dart';

class SubscriptionFormView extends StatefulWidget {
  const SubscriptionFormView({super.key});

  @override
  State<SubscriptionFormView> createState() => _SubscriptionFormViewState();
}

class _SubscriptionFormViewState extends State<SubscriptionFormView> {
  int _currentIndex = 0;
  late final PageController _pageController;
  final List<WidgetBuilder> _pageOptions = [
    (_) => const InfoForm(),
    (_) => const PricingTiers(),
    (_) => const Summary(),
  ];

  @override
  void initState() {
    _pageController = PageController(initialPage: _currentIndex);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _pageOptions.length,
              itemBuilder: (context, index) => _pageOptions[index](context),
            ),
          ),
          Row(
            children: [
              if (_currentIndex > 0)
                Flexible(
                  child: Button(
                      label: 'Previous', onPressedCallback: _previousPage),
                )
              else
                const Spacer(),
              const Spacer(),
              Flexible(
                child: Button(
                  type: ButtonType.secondary,
                  label: _currentIndex < 2 ? 'Next' : 'Confirm',
                  onPressedCallback: _next,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  void _next() {
    if (_currentIndex < 2) {
      return _nextPage();
    }

    debugPrint('Confirm');
  }

  void _nextPage() {
    if (_pageController.hasClients) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeIn,
      );
      setState(() {
        _currentIndex += 1;
      });
    }
  }

  void _previousPage() {
    if (_pageController.hasClients) {
      _pageController
          .previousPage(
            duration: const Duration(milliseconds: 400),
            curve: Curves.easeIn,
          )
          .then((value) => {});
      setState(() {
        _currentIndex -= 1;
      });
    }
  }

  void _confirm() {}
}
