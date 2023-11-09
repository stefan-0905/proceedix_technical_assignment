import 'package:go_router/go_router.dart';
import 'package:proceedix_technical_assignment/src/features/landing/landing_view.dart';
import 'package:proceedix_technical_assignment/src/features/subscription_form/subscription_form_view.dart';
import 'package:proceedix_technical_assignment/src/features/subscription_form/thank_you_view.dart';
import 'package:proceedix_technical_assignment/src/routing/route_names.dart';

final routes = GoRouter(
  initialLocation: '/landing',
  routes: [
    GoRoute(
      path: '/landing',
      name: RouteNames.landing,
      builder: (context, state) => const LandingView(),
    ),
    GoRoute(
      path: '/subscription',
      name: RouteNames.subscribe,
      builder: (context, state) => const SubscriptionFormView(),
    ),
    GoRoute(
      path: '/thank-you',
      name: RouteNames.thankYou,
      builder: (context, state) => const ThankYouView(),
    ),
  ],
);
