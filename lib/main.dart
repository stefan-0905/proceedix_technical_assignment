import 'package:flutter/material.dart';
import 'package:proceedix_technical_assignment/src/features/services/shared_preferences_wrapper.dart';
import 'package:proceedix_technical_assignment/src/routing/routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPreferencesWrapper().initialize();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: routes,
    );
  }
}
