import 'package:flutter/material.dart';

import '../theme/app_theme.dart';
import 'home_screen.dart';

class SuccessScreen extends StatelessWidget {
  const SuccessScreen({
    super.key,
    this.referenceNumber,
  });

  static const routeName = '/success';

  final String? referenceNumber;

  @override
  Widget build(BuildContext context) {
    final routeArguments = ModalRoute.of(context)?.settings.arguments;

    final String reference =
        referenceNumber ??
        (routeArguments is String
            ? routeArguments
            : 'CX1006-DEMO-REFERENCE');

    return Scaffold(
      backgroundColor: AppTheme.porcelain,
      appBar: AppBar(
        backgroundColor: AppTheme.midnight,
        foregroundColor: AppTheme.white,
        title: const Text('Grievance Submitted'),
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: ConstrainedBox(
              constraints: const BoxConstraints(
                maxWidth: 700,
              ),
              child: Column(
                children: [
                  // ======================================================
                  // SUCCESS HERO
                  // ======================================================

                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.fromLTRB(
                      30,
                      40,
                      30,
                      34,
                    ),
                    decoration: BoxDecoration(
                      color: AppTheme.midnight,
                      borderRadius: BorderRadius.circular(22),
                      border: Border.all(
                        color: AppTheme.antiqueBrass,
                        width: 1.5,
                      ),
                    ),
                    child: Column(
                      children: [
                        Container(
                          width: 88,
                          height: 88,
                          decoration: BoxDecoration(
                            color: AppTheme.successGreen,
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: AppTheme.antiqueBrass,
                              width: 3,
                            ),
                          ),
                          child: const Icon(
                            Icons.check_rounded,
                            color: AppTheme.white,
                            size: 52,
                          ),
                        ),

                        const SizedBox(height: 22),

                        Semantics(
                          liveRegion: true,
                          header: true,
                          label:
                              'Your grievance has been successfully submitted.',
                          child: const Text(
                            'Grievance Submitted',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: AppTheme.white,
                              fontSize: 32,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ),

                        const SizedBox(height: 10),

                        const Text(
                          'Your grievance has been successfully submitted.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: AppTheme.parchment,
                            fontSize: 16,
                            height: 1.5,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  // ======================================================
                  // REFERENCE CARD
                  // ======================================================

                  Container(
                    width: double.infinity,
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
                        const Text(
                          'Reference Number',
                          style: TextStyle(
                            color: AppTheme.secondaryText,
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(18),
                          decoration: BoxDecoration(
                            color: AppTheme.porcelain,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: AppTheme.antiqueBrass,
                              width: 1.5,
                            ),
                          ),
                          child: SelectableText(
                            reference,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: AppTheme.midnight,
                              fontSize: 20,
                              fontWeight: FontWeight.w800,
                              letterSpacing: .7,
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),
                        const Text(
                          'Please keep this reference number for future correspondence.',
                          style: TextStyle(
                            color: AppTheme.secondaryText,
                            fontSize: 13,
                            height: 1.45,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 18),

                  // ======================================================
                  // ACCESSIBILITY MESSAGE
                  // ======================================================

                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: AppTheme.white,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: AppTheme.parchment,
                      ),
                    ),
                    child: const Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.accessibility_new,
                          color: AppTheme.cobalt,
                          size: 28,
                        ),
                        SizedBox(width: 13),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Accessible completion',
                                style: TextStyle(
                                  color: AppTheme.midnight,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                              SizedBox(height: 5),
                              Text(
                                'The remediated workflow provides clear semantics, validation feedback, focus management, voice guidance and ISL assistance.',
                                style: TextStyle(
                                  color: AppTheme.secondaryText,
                                  fontSize: 13,
                                  height: 1.5,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 24),

                  // ======================================================
                  // HOME BUTTON
                  // ======================================================

                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        Navigator.of(context).pushNamedAndRemoveUntil(
                          HomeScreen.routeName,
                          (route) => false,
                        );
                      },
                      icon: const Icon(
                        Icons.home_outlined,
                      ),
                      label: const Text(
                        'Back to Home',
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