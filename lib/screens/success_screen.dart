import 'package:flutter/material.dart';

import 'home_screen.dart';

class SuccessScreen extends StatelessWidget {
  const SuccessScreen({super.key, required this.referenceNumber});

  static const routeName = '/success';

  final String referenceNumber;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(title: const Text('Grievance Submitted')),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Semantics(
                  label: 'Success. Your grievance has been submitted.',
                  child: ExcludeSemantics(
                    child: Icon(
                      Icons.check_circle,
                      size: 84,
                      color: colorScheme.primary,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Semantics(
                  header: true,
                  child: Text(
                    'Grievance Submitted',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Your grievance has been submitted successfully.',
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        Text(
                          'Reference Number',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        const SizedBox(height: 6),
                        Semantics(
                          label: 'Reference number $referenceNumber',
                          child: ExcludeSemantics(
                            child: Text(
                              referenceNumber,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge
                                  ?.copyWith(
                                    color: colorScheme.primary,
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 28),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: () =>
                        Navigator.of(context).pushNamedAndRemoveUntil(
                      HomeScreen.routeName,
                      (route) => false,
                    ),
                    icon: const Icon(Icons.home),
                    label: const Text('Return to Home'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}