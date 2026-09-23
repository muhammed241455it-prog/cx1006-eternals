import 'package:flutter/material.dart';

import '../speech_helper.dart';
import '../theme/app_theme.dart';
import 'home_screen.dart';

class SuccessScreen extends StatefulWidget {
  const SuccessScreen({
    super.key,
    required this.referenceNumber,
  });

  static const routeName = '/success';

  final String referenceNumber;

  @override
  State<SuccessScreen> createState() =>
      _SuccessScreenState();
}

class _SuccessScreenState extends State<SuccessScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _entranceController;
  late final Animation<double> _fadeAnimation;
  late final Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();

    _entranceController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 550),
    );
    _fadeAnimation = CurvedAnimation(
      parent: _entranceController,
      curve: Curves.easeOut,
    );
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.035),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _entranceController,
        curve: Curves.easeOutCubic,
      ),
    );
    _entranceController.forward();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      SpeechHelper.speak(
        'Your grievance has been successfully submitted.',
      );
    });
  }

  @override
  void dispose() {
    _entranceController.dispose();
    SpeechHelper.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Grievance Submitted'),
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(4),
          child: ColoredBox(color: AppTheme.antiqueBrass),
        ),
      ),
      body: SafeArea(
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: SlideTransition(
            position: _slideAnimation,
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 720),
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    final horizontalPadding = constraints.maxWidth < 520
                        ? 20.0
                        : 32.0;

                    return SingleChildScrollView(
                      padding: EdgeInsets.fromLTRB(
                        horizontalPadding,
                        24,
                        horizontalPadding,
                        32,
                      ),
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.fromLTRB(20, 18, 20, 20),
                    decoration: BoxDecoration(
                      color: AppTheme.midnight,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: AppTheme.antiqueBrass,
                        width: 1.5,
                      ),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(
                          Icons.verified_outlined,
                          color: AppTheme.antiqueBrass,
                          size: 28,
                        ),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Submission status',
                                style: theme.textTheme.labelLarge?.copyWith(
                                  color: AppTheme.white,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'Received and recorded',
                                style: theme.textTheme.bodyMedium?.copyWith(
                                  color: AppTheme.white.withValues(alpha: 0.84),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 28),

                  // ==================================================
                  // SUCCESS ICON
                  // ==================================================

                  Semantics(
                    label:
                        'Success. Your grievance has been submitted.',
                    child: ExcludeSemantics(
                      child: Container(
                        width: 108,
                        height: 108,
                        decoration: BoxDecoration(
                          color: const Color(0xFFDCFCE7),
                          shape: BoxShape.circle,
                          border: Border.all(
                            color:
                                const Color(0xFFBBF7D0),
                            width: 2,
                          ),
                        ),
                        child: const Icon(
                          Icons.check_rounded,
                          size: 64,
                          color: AppTheme.success,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 28),

                  // ==================================================
                  // TITLE
                  // ==================================================

                  Semantics(
                    header: true,
                    child: Text(
                      'Grievance Submitted',
                      textAlign: TextAlign.center,
                      style: theme
                          .textTheme
                          .headlineSmall,
                    ),
                  ),

                  const SizedBox(height: 10),

                  Text(
                    'Your grievance has been submitted successfully.',
                    textAlign: TextAlign.center,
                    style: theme.textTheme.bodyLarge?.copyWith(
                      color:
                          theme.colorScheme.onSurfaceVariant,
                    ),
                  ),

                  const SizedBox(height: 28),

                  // ==================================================
                  // REFERENCE CARD
                  // ==================================================

                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        children: [
                          Container(
                            width: 48,
                            height: 48,
                            decoration: BoxDecoration(
                              color: AppTheme.lightBlue,
                              borderRadius:
                                  BorderRadius.circular(12),
                            ),
                            child: const Icon(
                              Icons.confirmation_number_outlined,
                              color:
                                  AppTheme.primaryBlue,
                            ),
                          ),

                          const SizedBox(height: 14),

                          Text(
                            'Reference number',
                            style: theme.textTheme.titleMedium,
                          ),

                          const SizedBox(height: 8),

                          Semantics(
                            label:
                                'Reference number ${widget.referenceNumber}',
                            child: ExcludeSemantics(
                              child: Container(
                                width: double.infinity,
                                padding:
                                    const EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  color:
                                      AppTheme.background,
                                  borderRadius:
                                      BorderRadius.circular(
                                    10,
                                  ),
                                  border: Border.all(
                                    color:
                                        AppTheme.border,
                                  ),
                                ),
                                child: SelectableText(
                                  widget.referenceNumber,
                                  textAlign:
                                      TextAlign.center,
                                  style: theme
                                      .textTheme
                                      .titleLarge
                                      ?.copyWith(
                                    color:
                                        AppTheme.primaryBlue,
                                    fontWeight:
                                        FontWeight.w800,
                                    letterSpacing: 0.5,
                                  ),
                                ),
                              ),
                            ),
                          ),

                          const SizedBox(height: 12),

                          Text(
                            'Please keep this number for future reference.',
                            textAlign: TextAlign.center,
                            style:
                                theme.textTheme.bodySmall,
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  // ==================================================
                  // INFORMATION
                  // ==================================================

                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(18),
                    decoration: BoxDecoration(
                      color: AppTheme.lightBlue,
                      borderRadius:
                          BorderRadius.circular(12),
                      border: Border.all(
                        color: const Color(0xFFBFDBFE),
                      ),
                    ),
                    child: Row(
                      crossAxisAlignment:
                          CrossAxisAlignment.start,
                      children: [
                        const Icon(
                          Icons.info_outline,
                          color:
                              AppTheme.primaryBlue,
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            'Your submission is now recorded in '
                            'this accessibility demonstration.',
                            style: theme
                                .textTheme
                                .bodyMedium,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 28),

                  // ==================================================
                  // RETURN HOME
                  // ==================================================

                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        Navigator.of(context)
                            .pushNamedAndRemoveUntil(
                          HomeScreen.routeName,
                          (route) => false,
                        );
                      },
                      icon: const Icon(Icons.home_outlined),
                      label: const Text(
                        'Return to Home',
                      ),
                    ),
                  ),

                  const SizedBox(height: 30),

                  Text(
                    'CX1006 · ETERNALS',
                    style: theme.textTheme.labelMedium?.copyWith(
                      letterSpacing: 1.5,
                    ),
                  ),
                ],
              ),
                    );
                  },
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}