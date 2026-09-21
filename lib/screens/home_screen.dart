import 'package:flutter/material.dart';

import '../theme/app_theme.dart';
import 'broken_form_screen.dart';
import 'remediated_form_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static const routeName = '/';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.porcelain,
      appBar: AppBar(
        backgroundColor: AppTheme.midnight,
        foregroundColor: AppTheme.white,
        titleSpacing: 24,
        title: Row(
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: AppTheme.cobalt,
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(
                Icons.accessibility_new,
                color: AppTheme.white,
                size: 22,
              ),
            ),
            const SizedBox(width: 12),
            const Text(
              'CX1006',
              style: TextStyle(
                color: AppTheme.white,
                fontSize: 19,
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(width: 8),
            Container(
              width: 1,
              height: 20,
              color: AppTheme.parchment,
            ),
            const SizedBox(width: 8),
            const Text(
              'ETERNALS',
              style: TextStyle(
                color: AppTheme.parchment,
                fontSize: 14,
                fontWeight: FontWeight.w600,
                letterSpacing: 1,
              ),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(24, 36, 24, 48),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(
                maxWidth: 1200,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // ======================================================
                  // HERO
                  // ======================================================

                  Container(
                    padding: const EdgeInsets.all(32),
                    decoration: BoxDecoration(
                      color: AppTheme.midnight,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: AppTheme.cobalt,
                      ),
                    ),
                    child: Column(
                      children: [
                        Container(
                          width: 76,
                          height: 76,
                          decoration: BoxDecoration(
                            color: AppTheme.cobalt,
                            borderRadius: BorderRadius.circular(22),
                            border: Border.all(
                              color: AppTheme.antiqueBrass,
                              width: 2,
                            ),
                          ),
                          child: const Icon(
                            Icons.accessibility_new,
                            color: AppTheme.white,
                            size: 42,
                          ),
                        ),

                        const SizedBox(height: 22),

                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 14,
                            vertical: 7,
                          ),
                          decoration: BoxDecoration(
                            color: AppTheme.antiqueBrass,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Text(
                            'ACCESSIBILITY-FIRST DIGITAL GOVERNANCE',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: AppTheme.midnight,
                              fontSize: 11,
                              fontWeight: FontWeight.w800,
                              letterSpacing: .6,
                            ),
                          ),
                        ),

                        const SizedBox(height: 18),

                        Semantics(
                          header: true,
                          child: const Text(
                            'The Disability the App Forgot',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: AppTheme.white,
                              fontSize: 36,
                              height: 1.15,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ),

                        const SizedBox(height: 12),

                        const Text(
                          'Making inaccessible government services usable for everyone.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: AppTheme.parchment,
                            fontSize: 17,
                            height: 1.5,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 24),

                  // ======================================================
                  // PROBLEM / SOLUTION
                  // ======================================================

                  LayoutBuilder(
                    builder: (context, constraints) {
                      if (constraints.maxWidth < 800) {
                        return Column(
                          children: [
                            _infoCard(
                              icon: Icons.warning_amber_rounded,
                              title: 'The Problem',
                              body:
                                  'Many government e-governance portals may look labelled visually but remain difficult to use with screen readers. Fields can be announced out of order, controls can be unclear, and validation errors may not be communicated effectively.',
                              accent: AppTheme.antiqueBrass,
                            ),
                            const SizedBox(height: 16),
                            _infoCard(
                              icon: Icons.accessibility_new,
                              title: 'Our Solution',
                              body:
                                  'CX1006 demonstrates a remediation layer that reconstructs logical reading order, improves semantics, manages error focus, and adds Indian Sign Language guidance without rebuilding the underlying form.',
                              accent: AppTheme.cobalt,
                            ),
                          ],
                        );
                      }

                      return Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: _infoCard(
                              icon: Icons.warning_amber_rounded,
                              title: 'The Problem',
                              body:
                                  'Many government e-governance portals may look labelled visually but remain difficult to use with screen readers. Fields can be announced out of order, controls can be unclear, and validation errors may not be communicated effectively.',
                              accent: AppTheme.antiqueBrass,
                            ),
                          ),
                          const SizedBox(width: 18),
                          Expanded(
                            child: _infoCard(
                              icon: Icons.accessibility_new,
                              title: 'Our Solution',
                              body:
                                  'CX1006 demonstrates a remediation layer that reconstructs logical reading order, improves semantics, manages error focus, and adds Indian Sign Language guidance without rebuilding the underlying form.',
                              accent: AppTheme.cobalt,
                            ),
                          ),
                        ],
                      );
                    },
                  ),

                  const SizedBox(height: 24),

                  // ======================================================
                  // FEATURES
                  // ======================================================

                  _sectionContainer(
                    title: 'Accessibility Demonstration',
                    subtitle:
                        'The same grievance experience is shown before and after accessibility remediation.',
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        final columns = constraints.maxWidth >= 800 ? 2 : 1;

                        return GridView.count(
                          crossAxisCount: columns,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          crossAxisSpacing: 14,
                          mainAxisSpacing: 14,
                          childAspectRatio: 4.8,
                          children: const [
                            _FeatureItem(
                              icon: Icons.format_list_numbered,
                              title: 'Logical reading order',
                            ),
                            _FeatureItem(
                              icon: Icons.record_voice_over,
                              title: 'Screen-reader semantics',
                            ),
                            _FeatureItem(
                              icon: Icons.error_outline,
                              title: 'Accessible validation',
                            ),
                            _FeatureItem(
                              icon: Icons.center_focus_strong,
                              title: 'Error focus management',
                            ),
                            _FeatureItem(
                              icon: Icons.sign_language,
                              title: 'Indian Sign Language guidance',
                            ),
                            _FeatureItem(
                              icon: Icons.volume_up,
                              title: 'Voice guidance',
                            ),
                          ],
                        );
                      },
                    ),
                  ),

                  const SizedBox(height: 28),

                  // ======================================================
                  // DEMO ACTIONS
                  // ======================================================

                  Semantics(
                    header: true,
                    child: const Text(
                      'Experience the difference',
                      style: TextStyle(
                        color: AppTheme.midnight,
                        fontSize: 22,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),

                  const SizedBox(height: 6),

                  const Text(
                    'Compare the intentionally broken experience with the remediated accessible experience.',
                    style: TextStyle(
                      color: AppTheme.secondaryText,
                      fontSize: 14,
                      height: 1.5,
                    ),
                  ),

                  const SizedBox(height: 18),

                  LayoutBuilder(
                    builder: (context, constraints) {
                      if (constraints.maxWidth < 650) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            _demoButton(
                              context: context,
                              icon: Icons.warning_amber_rounded,
                              title: 'View Broken Form',
                              subtitle:
                                  'See the accessibility problems',
                              color: AppTheme.antiqueBrass,
                              onPressed: () {
                                Navigator.of(context).pushNamed(
                                  BrokenFormScreen.routeName,
                                );
                              },
                            ),
                            const SizedBox(height: 14),
                            _demoButton(
                              context: context,
                              icon: Icons.accessibility_new,
                              title: 'View Remediated Form',
                              subtitle:
                                  'Experience the accessible version',
                              color: AppTheme.cobalt,
                              onPressed: () {
                                Navigator.of(context).pushNamed(
                                  RemediatedFormScreen.routeName,
                                );
                              },
                            ),
                          ],
                        );
                      }

                      return Row(
                        children: [
                          Expanded(
                            child: _demoButton(
                              context: context,
                              icon: Icons.warning_amber_rounded,
                              title: 'View Broken Form',
                              subtitle:
                                  'See the accessibility problems',
                              color: AppTheme.antiqueBrass,
                              onPressed: () {
                                Navigator.of(context).pushNamed(
                                  BrokenFormScreen.routeName,
                                );
                              },
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: _demoButton(
                              context: context,
                              icon: Icons.accessibility_new,
                              title: 'View Remediated Form',
                              subtitle:
                                  'Experience the accessible version',
                              color: AppTheme.cobalt,
                              onPressed: () {
                                Navigator.of(context).pushNamed(
                                  RemediatedFormScreen.routeName,
                                );
                              },
                            ),
                          ),
                        ],
                      );
                    },
                  ),

                  const SizedBox(height: 28),

                  // ======================================================
                  // FOOTER
                  // ======================================================

                  Container(
                    padding: const EdgeInsets.all(18),
                    decoration: BoxDecoration(
                      color: AppTheme.white,
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(
                        color: AppTheme.parchment,
                      ),
                    ),
                    child: const Row(
                      children: [
                        Icon(
                          Icons.info_outline,
                          color: AppTheme.cobalt,
                        ),
                        SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            'CX1006 is a proof-of-concept demonstrating accessibility remediation techniques for government digital services.',
                            style: TextStyle(
                              color: AppTheme.secondaryText,
                              fontSize: 13,
                              height: 1.45,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  static Widget _infoCard({
    required IconData icon,
    required String title,
    required String body,
    required Color accent,
  }) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppTheme.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppTheme.parchment,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: accent.withValues(alpha: .12),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              icon,
              color: accent,
              size: 25,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            title,
            style: const TextStyle(
              color: AppTheme.midnight,
              fontSize: 21,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 9),
          Text(
            body,
            style: const TextStyle(
              color: AppTheme.secondaryText,
              fontSize: 14,
              height: 1.55,
            ),
          ),
        ],
      ),
    );
  }

  static Widget _sectionContainer({
    required String title,
    required String subtitle,
    required Widget child,
  }) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppTheme.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppTheme.parchment,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: AppTheme.midnight,
              fontSize: 21,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            subtitle,
            style: const TextStyle(
              color: AppTheme.secondaryText,
              fontSize: 14,
              height: 1.45,
            ),
          ),
          const SizedBox(height: 20),
          child,
        ],
      ),
    );
  }

  static Widget _demoButton({
    required BuildContext context,
    required IconData icon,
    required String title,
    required String subtitle,
    required Color color,
    required VoidCallback onPressed,
  }) {
    return Semantics(
      button: true,
      label: title,
      hint: subtitle,
      child: Material(
        color: AppTheme.midnight,
        borderRadius: BorderRadius.circular(14),
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(14),
          child: Container(
            constraints: const BoxConstraints(
              minHeight: 86,
            ),
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              border: Border.all(
                color: color,
                width: 1.5,
              ),
            ),
            child: Row(
              children: [
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: color,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    icon,
                    color: AppTheme.midnight,
                    size: 26,
                  ),
                ),
                const SizedBox(width: 15),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          color: AppTheme.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const SizedBox(height: 3),
                      Text(
                        subtitle,
                        style: const TextStyle(
                          color: AppTheme.parchment,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
                const Icon(
                  Icons.arrow_forward_rounded,
                  color: AppTheme.white,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _FeatureItem extends StatelessWidget {
  const _FeatureItem({
    required this.icon,
    required this.title,
  });

  final IconData icon;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 15,
        vertical: 12,
      ),
      decoration: BoxDecoration(
        color: AppTheme.porcelain,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppTheme.parchment,
        ),
      ),
      child: Row(
        children: [
          const Icon(
            Icons.check_circle_outline,
            color: AppTheme.antiqueBrass,
            size: 21,
          ),
          const SizedBox(width: 10),
          Icon(
            icon,
            color: AppTheme.cobalt,
            size: 20,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                color: AppTheme.midnight,
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}