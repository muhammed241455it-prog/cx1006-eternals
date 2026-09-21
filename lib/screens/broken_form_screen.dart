import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

class BrokenFormScreen extends StatefulWidget {
  const BrokenFormScreen({super.key});

  static const routeName = '/broken';

  @override
  State<BrokenFormScreen> createState() => _BrokenFormScreenState();
}

class _BrokenFormScreenState extends State<BrokenFormScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _descriptionController =
      TextEditingController();

  String? _category;

  final List<String> _categories = const [
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.porcelain,
      appBar: AppBar(
        backgroundColor: AppTheme.midnight,
        foregroundColor: AppTheme.white,
        title: const Text('Broken Experience'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(24, 24, 24, 48),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(
                maxWidth: 900,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // ======================================================
                  // WARNING BANNER
                  // ======================================================

                  Container(
                    padding: const EdgeInsets.all(18),
                    decoration: BoxDecoration(
                      color: AppTheme.midnight,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: AppTheme.antiqueBrass,
                        width: 1.5,
                      ),
                    ),
                    child: const Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.warning_amber_rounded,
                          color: AppTheme.antiqueBrass,
                          size: 30,
                        ),
                        SizedBox(width: 14),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Broken Accessibility Experience',
                                style: TextStyle(
                                  color: AppTheme.white,
                                  fontSize: 19,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                              SizedBox(height: 6),
                              Text(
                                'This screen intentionally demonstrates the original inaccessible experience before remediation.',
                                style: TextStyle(
                                  color: AppTheme.parchment,
                                  fontSize: 13,
                                  height: 1.45,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 18),

                  // ======================================================
                  // FORM CARD
                  // ======================================================

                  Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: AppTheme.white,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: AppTheme.parchment,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const Text(
                          'Government Grievance Form',
                          style: TextStyle(
                            color: AppTheme.midnight,
                            fontSize: 24,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        const SizedBox(height: 6),
                        const Text(
                          'This mock form represents the legacy experience.',
                          style: TextStyle(
                            color: AppTheme.secondaryText,
                            fontSize: 14,
                          ),
                        ),

                        const SizedBox(height: 24),

                        // Intentionally basic fields.
                        TextField(
                          controller: _nameController,
                          decoration: const InputDecoration(
                            labelText: 'Full Name',
                            hintText: 'Enter your name',
                          ),
                        ),

                        const SizedBox(height: 16),

                        TextField(
                          controller: _emailController,
                          keyboardType: TextInputType.emailAddress,
                          decoration: const InputDecoration(
                            labelText: 'Email Address',
                            hintText: 'Enter your email',
                          ),
                        ),

                        const SizedBox(height: 16),

                        TextField(
                          controller: _mobileController,
                          keyboardType: TextInputType.phone,
                          decoration: const InputDecoration(
                            labelText: 'Mobile Number',
                            hintText: 'Enter mobile number',
                          ),
                        ),

                        const SizedBox(height: 16),

                        DropdownButtonFormField<String>(
                          initialValue: _category,
                          decoration: const InputDecoration(
                            labelText: 'Grievance Category',
                          ),
                          items: _categories
                              .map(
                                (category) => DropdownMenuItem<String>(
                                  value: category,
                                  child: Text(category),
                                ),
                              )
                              .toList(),
                          onChanged: (value) {
                            setState(() {
                              _category = value;
                            });
                          },
                        ),

                        const SizedBox(height: 16),

                        TextField(
                          controller: _descriptionController,
                          minLines: 4,
                          maxLines: 6,
                          decoration: const InputDecoration(
                            labelText: 'Description',
                            hintText: 'Describe your grievance',
                            alignLabelWithHint: true,
                          ),
                        ),

                        const SizedBox(height: 22),

                        ElevatedButton.icon(
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                  'This is the intentionally broken demo form.',
                                ),
                              ),
                            );
                          },
                          icon: const Icon(Icons.send),
                          label: const Text('Submit Grievance'),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  // ======================================================
                  // PROBLEM EXPLANATION
                  // ======================================================

                  Container(
                    padding: const EdgeInsets.all(22),
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
                          'What is wrong here?',
                          style: TextStyle(
                            color: AppTheme.midnight,
                            fontSize: 20,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        const SizedBox(height: 14),
                        _problem(
                          Icons.record_voice_over_outlined,
                          'Limited semantic guidance',
                        ),
                        _problem(
                          Icons.format_list_numbered,
                          'Reading order is not demonstrated as a corrected semantic flow',
                        ),
                        _problem(
                          Icons.error_outline,
                          'No accessible error-summary and focus workflow',
                        ),
                        _problem(
                          Icons.sign_language,
                          'No field-level ISL guidance',
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

  Widget _problem(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            icon,
            color: AppTheme.antiqueBrass,
            size: 21,
          ),
          const SizedBox(width: 11),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                color: AppTheme.secondaryText,
                fontSize: 14,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }
}