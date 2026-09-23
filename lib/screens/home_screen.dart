import 'package:flutter/material.dart';

import '../theme/app_theme.dart';
import 'broken_form_screen.dart';
import 'remediated_form_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static const routeName = '/';

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Container(
              width: 38,
              height: 38,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.14),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(
                Icons.accessibility_new,
                size: 23,
              ),
            ),
            const SizedBox(width: 12),
            const Text('CX1006 · Eternals'),
          ],
        ),
      ),

      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(
              maxWidth: 1180,
            ),
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // ==================================================
                  // HERO
                  // ==================================================

                  Container(
                    padding: const EdgeInsets.all(32),
                    decoration: BoxDecoration(
                      color: AppTheme.navy,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        final isSmall = constraints.maxWidth < 700;

                        return Flex(
                          direction: isSmall
                              ? Axis.vertical
                              : Axis.horizontal,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              flex: isSmall ? 0 : 3,
                              child: Column(
                                crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 12,
                                      vertical: 7,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.white.withValues(alpha: 0.10),
                                      borderRadius:
                                          BorderRadius.circular(30),
                                      border: Border.all(
                                        color:
                                            Colors.white.withValues(alpha: 0.18),
                                      ),
                                    ),
                                    child: const Text(
                                      'ACCESSIBILITY REMEDIATION',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w800,
                                        letterSpacing: 1,
                                      ),
                                    ),
                                  ),

                                  const SizedBox(height: 20),

                                  Semantics(
                                    header: true,
                                    child: Text(
                                      'The Disability\nthe App Forgot',
                                      style: theme
                                          .textTheme
                                          .displaySmall
                                          ?.copyWith(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),

                                  const SizedBox(height: 16),

                                  Text(
                                    'Making inaccessible government '
                                    'services more usable for everyone.',
                                    style: theme.textTheme.bodyLarge?.copyWith(
                                      color: Colors.white.withValues(alpha: 0.82),
                                      fontSize: 17,
                                    ),
                                  ),

                                  const SizedBox(height: 24),

                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.check_circle,
                                        color: Color(0xFF93C5FD),
                                        size: 20,
                                      ),
                                      const SizedBox(width: 8),
                                      Flexible(
                                        child: Text(
                                          'Built around accessible interaction',
                                          style: theme.textTheme.bodyMedium
                                              ?.copyWith(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),

                            if (!isSmall) const SizedBox(width: 50),

                            if (isSmall)
                              const SizedBox(height: 32),

                            Container(
                              width: isSmall ? 150 : 190,
                              height: isSmall ? 150 : 190,
                              decoration: BoxDecoration(
                                color: Colors.white.withValues(alpha: 0.08),
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: Colors.white.withValues(alpha: 0.18),
                                  width: 2,
                                ),
                              ),
                              child: const Icon(
                                Icons.accessibility_new,
                                size: 90,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),

                  const SizedBox(height: 24),

                  // ==================================================
                  // PROBLEM / SOLUTION
                  // ==================================================

                  LayoutBuilder(
                    builder: (context, constraints) {
                      final isSmall = constraints.maxWidth < 750;

                      return Flex(
                        direction:
                            isSmall ? Axis.vertical : Axis.horizontal,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: _InfoCard(
                              icon: Icons.warning_amber_rounded,
                              iconBackground: const Color(0xFFFEE2E2),
                              iconColor: AppTheme.error,
                              title: 'The Problem',
                              text:
                                  'Many e-governance portals may have '
                                  'visible labels but still create barriers '
                                  'for people using assistive technologies. '
                                  'Reading order, error feedback and focus '
                                  'management can make a form difficult to use.',
                            ),
                          ),

                          if (isSmall)
                            const SizedBox(height: 16)
                          else
                            const SizedBox(width: 16),

                          Expanded(
                            child: _InfoCard(
                              icon: Icons.auto_awesome,
                              iconBackground: AppTheme.lightBlue,
                              iconColor: AppTheme.primaryBlue,
                              title: 'Our Solution',
                              text:
                                  'CX1006 demonstrates a remediation layer '
                                  'that reconstructs logical reading order, '
                                  'improves semantics, manages validation '
                                  'focus and provides Indian Sign Language '
                                  'guidance.',
                            ),
                          ),
                        ],
                      );
                    },
                  ),

                  const SizedBox(height: 24),

                  // ==================================================
                  // FEATURES
                  // ==================================================

                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Semantics(
                            header: true,
                            child: Text(
                              'Accessibility Demonstration',
                              style: theme.textTheme.titleLarge,
                            ),
                          ),

                          const SizedBox(height: 6),

                          Text(
                            'Explore the difference between an inaccessible '
                            'experience and a remediated one.',
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color: colors.onSurfaceVariant,
                            ),
                          ),

                          const SizedBox(height: 20),

                          LayoutBuilder(
                            builder: (context, constraints) {
                              final width = constraints.maxWidth;

                              int columns = 1;

                              if (width >= 900) {
                                columns = 3;
                              } else if (width >= 550) {
                                columns = 2;
                              }

                              final itemWidth =
                                  (width - ((columns - 1) * 12)) /
                                      columns;

                              return Wrap(
                                spacing: 12,
                                runSpacing: 12,
                                children: const [
                                  _FeatureTile(
                                    icon: Icons.low_priority,
                                    title: 'Logical Reading Order',
                                    description:
                                        'Content is presented in a '
                                        'meaningful sequence.',
                                  ),
                                  _FeatureTile(
                                    icon: Icons.record_voice_over,
                                    title: 'Screen Reader Semantics',
                                    description:
                                        'Controls expose useful labels '
                                        'and relationships.',
                                  ),
                                  _FeatureTile(
                                    icon: Icons.fact_check,
                                    title: 'Accessible Validation',
                                    description:
                                        'Errors provide clear field-level '
                                        'feedback.',
                                  ),
                                  _FeatureTile(
                                    icon: Icons.center_focus_strong,
                                    title: 'Error Focus',
                                    description:
                                        'Focus moves directly to the '
                                        'first invalid field.',
                                  ),
                                  _FeatureTile(
                                    icon: Icons.sign_language,
                                    title: 'Indian Sign Language',
                                    description:
                                        'Field-specific ISL guidance is '
                                        'available.',
                                  ),
                                  _FeatureTile(
                                    icon: Icons.record_voice_over_outlined,
                                    title: 'Voice Guidance',
                                    description:
                                        'Important interactions can be '
                                        'announced automatically.',
                                  ),
                                ].map((child) {
                                  return SizedBox(
                                    width: itemWidth,
                                    child: child,
                                  );
                                }).toList(),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 24),

                  // ==================================================
                  // DEMO ACTIONS
                  // ==================================================

                  Card(
                    color: AppTheme.lightBlue,
                    child: Padding(
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            'Try the Demonstration',
                            style: theme.textTheme.titleLarge,
                          ),

                          const SizedBox(height: 6),

                          Text(
                            'Experience the same grievance workflow in '
                            'two different accessibility states.',
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color: colors.onSurfaceVariant,
                            ),
                          ),

                          const SizedBox(height: 20),

                          LayoutBuilder(
                            builder: (context, constraints) {
                              final isSmall = constraints.maxWidth < 650;

                              if (isSmall) {
                                return Column(
                                  children: [
                                    _DemoButton(
                                      title: 'View Broken Form',
                                      subtitle:
                                          'See common accessibility problems',
                                      icon: Icons.error_outline,
                                      filled: false,
                                      onPressed: () {
                                        Navigator.of(context).pushNamed(
                                          BrokenFormScreen.routeName,
                                        );
                                      },
                                    ),
                                    const SizedBox(height: 12),
                                    _DemoButton(
                                      title: 'View Remediated Form',
                                      subtitle:
                                          'Experience the accessible version',
                                      icon: Icons.check_circle_outline,
                                      filled: true,
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
                                    child: _DemoButton(
                                      title: 'View Broken Form',
                                      subtitle:
                                          'See common accessibility problems',
                                      icon: Icons.error_outline,
                                      filled: false,
                                      onPressed: () {
                                        Navigator.of(context).pushNamed(
                                          BrokenFormScreen.routeName,
                                        );
                                      },
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: _DemoButton(
                                      title: 'View Remediated Form',
                                      subtitle:
                                          'Experience the accessible version',
                                      icon: Icons.check_circle_outline,
                                      filled: true,
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
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 24),

                  Center(
                    child: Text(
                      'CX1006 · ETERNALS',
                      style: theme.textTheme.labelMedium?.copyWith(
                        letterSpacing: 1.5,
                      ),
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
}

class _InfoCard extends StatelessWidget {
  const _InfoCard({
    required this.icon,
    required this.iconBackground,
    required this.iconColor,
    required this.title,
    required this.text,
  });

  final IconData icon;
  final Color iconBackground;
  final Color iconColor;
  final String title;
  final String text;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(22),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 46,
              height: 46,
              decoration: BoxDecoration(
                color: iconBackground,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                icon,
                color: iconColor,
                size: 25,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              title,
              style: theme.textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            Text(
              text,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _FeatureTile extends StatelessWidget {
  const _FeatureTile({
    required this.icon,
    required this.title,
    required this.description,
  });

  final IconData icon;
  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.background,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppTheme.border,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ExcludeSemantics(
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: AppTheme.lightBlue,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(
                icon,
                color: AppTheme.primaryBlue,
                size: 21,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: theme.textTheme.titleSmall,
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: theme.textTheme.bodySmall,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _DemoButton extends StatelessWidget {
  const _DemoButton({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.filled,
    required this.onPressed,
  });

  final String title;
  final String subtitle;
  final IconData icon;
  final bool filled;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Material(
      color: filled ? AppTheme.primaryBlue : Colors.white,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          constraints: const BoxConstraints(
            minHeight: 78,
          ),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: filled
                  ? AppTheme.primaryBlue
                  : AppTheme.border,
            ),
          ),
          child: Row(
            children: [
              Icon(
                icon,
                color: filled
                    ? Colors.white
                    : AppTheme.primaryBlue,
                size: 26,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: theme.textTheme.titleSmall?.copyWith(
                        color: filled
                            ? Colors.white
                            : AppTheme.primaryText,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      subtitle,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: filled
                            ? Colors.white.withValues(alpha: 0.82)
                            : AppTheme.secondaryText,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.arrow_forward,
                color: filled
                    ? Colors.white
                    : AppTheme.primaryBlue,
              ),
            ],
          ),
        ),
      ),
    );
  }
}