import 'package:flutter/material.dart';

import 'broken_form_screen.dart';
import 'remediated_form_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static const routeName = '/';

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(title: const Text('CX1006 · Eternals')),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ExcludeSemantics(
                child: Center(
                  child: Container(
                    height: 84,
                    width: 84,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: colorScheme.primaryContainer,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.accessibility_new,
                      size: 44,
                      color: colorScheme.onPrimaryContainer,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Semantics(
                header: true,
                child: Text(
                  'The Disability the App Forgot',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Making inaccessible government services usable for '
                'everyone.',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: colorScheme.onSurfaceVariant,
                    ),
              ),
              const SizedBox(height: 24),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(18),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Semantics(
                        header: true,
                        child: Text(
                          'The Problem',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ),
                      const SizedBox(height: 6),
                      const Text(
                        'Many government e-governance portals are '
                        'technically "labelled" but still unusable with a '
                        'screen reader — fields are announced out of '
                        'order, buttons are unclear, and errors are never '
                        'announced. Citizens with disabilities abandon '
                        'forms they have a legal right to use.',
                      ),
                      const SizedBox(height: 16),
                      Semantics(
                        header: true,
                        child: Text(
                          'Our Solution',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ),
                      const SizedBox(height: 6),
                      const Text(
                        'A remediation layer that reconstructs logical '
                        'reading order, restructures semantics, manages '
                        'error focus, and adds Indian Sign Language '
                        'guidance — without redesigning the underlying '
                        'form.',
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Card(
                color: colorScheme.surfaceContainerHighest,
                child: Padding(
                  padding: const EdgeInsets.all(18),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Semantics(
                        header: true,
                        child: Text(
                          'Accessibility Demonstration',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ),
                      const SizedBox(height: 10),
                      const _FeatureRow(
                        icon: Icons.low_priority,
                        label: 'Logical reading order',
                      ),
                      const _FeatureRow(
                        icon: Icons.record_voice_over,
                        label: 'Screen-reader semantics',
                      ),
                      const _FeatureRow(
                        icon: Icons.fact_check,
                        label: 'Accessible form validation',
                      ),
                      const _FeatureRow(
                        icon: Icons.center_focus_strong,
                        label: 'Error focus management',
                      ),
                      const _FeatureRow(
                        icon: Icons.sign_language,
                        label: 'Indian Sign Language guidance',
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 28),
              Semantics(
                button: true,
                label: 'View Broken Form',
                hint: 'Demonstrates a form with poor accessibility '
                    'structure',
                child: ExcludeSemantics(
                  child: ElevatedButton.icon(
                    onPressed: () => Navigator.of(context)
                        .pushNamed(BrokenFormScreen.routeName),
                    icon: const Icon(Icons.error_outline),
                    label: const Text('View Broken Form'),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Semantics(
                button: true,
                label: 'View Remediated Form',
                hint: 'Demonstrates the same form after accessibility '
                    'remediation',
                child: ExcludeSemantics(
                  child: OutlinedButton.icon(
                    onPressed: () => Navigator.of(context)
                        .pushNamed(RemediatedFormScreen.routeName),
                    icon: const Icon(Icons.check_circle_outline),
                    label: const Text('View Remediated Form'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _FeatureRow extends StatelessWidget {
  const _FeatureRow({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: MergeSemantics(
        child: Row(
          children: [
            ExcludeSemantics(
              child: Icon(
                icon,
                size: 20,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(child: Text(label)),
          ],
        ),
      ),
    );
  }
}