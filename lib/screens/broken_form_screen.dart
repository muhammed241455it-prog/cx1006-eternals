import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

class BrokenFormScreen extends StatefulWidget {
  const BrokenFormScreen({super.key});

  static const routeName = '/broken';

  @override
  State<BrokenFormScreen> createState() => _BrokenFormScreenState();
}

class _BrokenFormScreenState extends State<BrokenFormScreen> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _mobileController = TextEditingController();
  final _descriptionController = TextEditingController();

  String? _selectedCategory;
  bool _showColorOnlyErrors = false;

  static const _categories = [
    'Water Supply',
    'Electricity',
    'Sanitation',
    'Roads',
    'Other',
  ];

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _mobileController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  bool get _isNameEmpty => _nameController.text.trim().isEmpty;
  bool get _isEmailEmpty => _emailController.text.trim().isEmpty;
  bool get _isMobileEmpty => _mobileController.text.trim().isEmpty;
  bool get _isCategoryEmpty => _selectedCategory == null;
  bool get _isDescriptionEmpty =>
      _descriptionController.text.trim().isEmpty;

  void _handleSubmit() {
    final hasEmptyField =
        _isNameEmpty ||
        _isEmailEmpty ||
        _isMobileEmpty ||
        _isCategoryEmpty ||
        _isDescriptionEmpty;

    setState(() {
      _showColorOnlyErrors = hasEmptyField;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          hasEmptyField
              ? 'Error'
              : 'Submitted (demo only)',
        ),
      ),
    );
  }

  InputDecoration _brokenDecoration({
    String? hint,
  }) {
    return InputDecoration(
      hintText: hint,
      filled: true,
      fillColor: Colors.white,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(
          color: _showColorOnlyErrors
              ? AppTheme.error
              : AppTheme.border,
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(
          color: _showColorOnlyErrors
              ? AppTheme.error
              : AppTheme.border,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Broken Government Grievance Form',
        ),
      ),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(
              maxWidth: 900,
            ),
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.stretch,
                children: [
                  // ==================================================
                  // WARNING HEADER
                  // ==================================================

                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFEF2F2),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: const Color(0xFFFECACA),
                      ),
                    ),
                    child: Row(
                      crossAxisAlignment:
                          CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 44,
                          height: 44,
                          decoration: BoxDecoration(
                            color: const Color(0xFFFEE2E2),
                            borderRadius:
                                BorderRadius.circular(12),
                          ),
                          child: const Icon(
                            Icons.warning_amber_rounded,
                            color: AppTheme.error,
                          ),
                        ),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Column(
                            crossAxisAlignment:
                                CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Accessibility issues demonstrated',
                                style: theme
                                    .textTheme
                                    .titleMedium
                                    ?.copyWith(
                                  color: const Color(0xFF7F1D1D),
                                ),
                              ),
                              const SizedBox(height: 6),
                              Text(
                                'This screen intentionally demonstrates '
                                'common accessibility failures.',
                                style: theme.textTheme.bodyMedium,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 16),

                  // ==================================================
                  // ISSUES
                  // ==================================================

                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment:
                            CrossAxisAlignment.start,
                        children: [
                          Text(
                            'What is wrong here?',
                            style: theme.textTheme.titleMedium,
                          ),
                          const SizedBox(height: 14),
                          const _IssueRow(
                            icon: Icons.label_off,
                            text:
                                'Visual labels are not linked to their fields',
                          ),
                          const _IssueRow(
                            icon: Icons.volume_off,
                            text:
                                'Decorative icons may be announced as noise',
                          ),
                          const _IssueRow(
                            icon: Icons.account_tree_outlined,
                            text:
                                'Related fields are not grouped semantically',
                          ),
                          const _IssueRow(
                            icon: Icons.touch_app,
                            text:
                                'Submit control is not exposed as a real button',
                          ),
                          const _IssueRow(
                            icon: Icons.palette_outlined,
                            text:
                                'Errors are communicated using colour only',
                          ),
                          const _IssueRow(
                            icon: Icons.center_focus_weak,
                            text:
                                'Focus never moves to the problem field',
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 24),

                  // ==================================================
                  // FORM
                  // ==================================================

                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        crossAxisAlignment:
                            CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            'Citizen Grievance',
                            style: theme.textTheme.titleLarge,
                          ),

                          const SizedBox(height: 6),

                          Text(
                            'This is the unremediated form.',
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color:
                                  theme.colorScheme.onSurfaceVariant,
                            ),
                          ),

                          const SizedBox(height: 24),

                          const Row(
                            children: [
                              Icon(
                                Icons.star,
                                size: 16,
                                color: Colors.amber,
                              ),
                              SizedBox(width: 6),
                              Text('Full Name'),
                            ],
                          ),

                          const SizedBox(height: 6),

                          TextField(
                            controller: _nameController,
                            decoration: _brokenDecoration(),
                          ),

                          const SizedBox(height: 18),

                          const Text('Email'),

                          const SizedBox(height: 6),

                          TextField(
                            controller: _emailController,
                            decoration:
                                _brokenDecoration(
                              hint: 'Enter here',
                            ),
                          ),

                          const SizedBox(height: 18),

                          const Text('Mobile'),

                          const SizedBox(height: 6),

                          TextField(
                            controller: _mobileController,
                            decoration:
                                _brokenDecoration(),
                          ),

                          const SizedBox(height: 18),

                          const Text('Category'),

                          const SizedBox(height: 6),

                          DropdownButtonFormField<String>(
                            initialValue:
                                _selectedCategory,
                            decoration:
                                _brokenDecoration(
                              hint: 'Select',
                            ),
                            items: _categories
                                .map(
                                  (category) =>
                                      DropdownMenuItem(
                                    value: category,
                                    child:
                                        Text(category),
                                  ),
                                )
                                .toList(),
                            onChanged: (value) {
                              setState(() {
                                _selectedCategory =
                                    value;
                              });
                            },
                          ),

                          const SizedBox(height: 18),

                          const Text('Description'),

                          const SizedBox(height: 6),

                          TextField(
                            controller:
                                _descriptionController,
                            maxLines: 5,
                            decoration:
                                _brokenDecoration(),
                          ),

                          const SizedBox(height: 24),

                          // Intentionally NOT a real button.
                          GestureDetector(
                            onTap: _handleSubmit,
                            child: Container(
                              height: 52,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color:
                                    AppTheme.primaryBlue,
                                borderRadius:
                                    BorderRadius.circular(10),
                              ),
                              child: const Text(
                                'Submit',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight:
                                      FontWeight.w700,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: AppTheme.lightBlue,
                      borderRadius:
                          BorderRadius.circular(12),
                    ),
                    child: const Row(
                      children: [
                        Icon(
                          Icons.info_outline,
                          color: AppTheme.primaryBlue,
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            'Next: compare this experience with '
                            'the remediated form.',
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
}

class _IssueRow extends StatelessWidget {
  const _IssueRow({
    required this.icon,
    required this.text,
  });

  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 5,
      ),
      child: Row(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [
          Icon(
            icon,
            size: 19,
            color: AppTheme.error,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(text),
          ),
        ],
      ),
    );
  }
}