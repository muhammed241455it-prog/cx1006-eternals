import 'package:flutter/material.dart';

import 'screens/broken_form_screen.dart';
import 'screens/home_screen.dart';
import 'screens/remediated_form_screen.dart';
import 'screens/success_screen.dart';
import 'theme/app_theme.dart';

void main() {
  runApp(const Cx1006App());
}

class Cx1006App extends StatelessWidget {
  const Cx1006App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CX1006 - Accessibility Remediation Demo',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      initialRoute: HomeScreen.routeName,
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case HomeScreen.routeName:
            return MaterialPageRoute(builder: (_) => const HomeScreen());
          case BrokenFormScreen.routeName:
            return MaterialPageRoute(builder: (_) => const BrokenFormScreen());
          case RemediatedFormScreen.routeName:
            return MaterialPageRoute(
              builder: (_) => const RemediatedFormScreen(),
            );
          case SuccessScreen.routeName:
            final referenceNumber = settings.arguments as String? ?? 'N/A';
            return MaterialPageRoute(
              builder: (_) => SuccessScreen(referenceNumber: referenceNumber),
            );
          default:
            return MaterialPageRoute(builder: (_) => const HomeScreen());
        }
      },
    );
  }
}