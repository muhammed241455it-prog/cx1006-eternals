import 'package:flutter/material.dart';

import '../models/field_error.dart';
import '../utils/reference_generator.dart';
import '../utils/validators.dart';
import '../widgets/isl_guidance_card.dart';
import 'success_screen.dart';

class RemediatedFormScreen extends StatefulWidget {
  const RemediatedFormScreen({super.key});

  static const routeName = '/remediated';

  @override
  State<RemediatedFormScreen> createState() => _RemediatedFormScreenState();
}

class _RemediatedFormScreenState extends State<RemediatedFormScreen> {
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _mobileController = TextEditingController();
  final _descriptionController = TextEditingController();

  final _nameFocus = FocusNode(debugLabel: 'Full Name');
  final _emailFocus = FocusNode(debugLabel: 'Email');
  final _mobileFocus = FocusNode(debugLabel: 'Mobile Number');
  final _categoryFocus = FocusNode(debugLabel: 'Grievance Category');
  final _descriptionFocus = FocusNode(debugLabel: 'Grievance Description');

  String? _category;
  bool _autovalidate = false;
  String? _errorSummary;

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
    _nameFocus.dispose();
    _emailFocus.dispose();
    _mobileFocus.dispose();
    _categoryFocus.dispose();
    _descriptionFocus.dispose();
    super.dispose();
  }

  FieldError? _firstInvalidField() {
    final nameError = GrievanceValidators.fullName(_nameController.text);
    if (nameError != null) {
      return FieldError(focusNode: _nameFocus, summary: 'Full Name: $nameError');
    }
    final emailError = GrievanceValidators.email(_emailController.text);
    if (emailError != null) {
      return FieldError(focusNode: _emailFocus, summary: 'Email: $emailError');
    }
    final mobileError =
        GrievanceValidators.mobileNumber(_mobileController.text);
    if (mobileError != null) {
      return FieldError(
        focusNode: _mobileFocus,
        summary: 'Mobile Number: $mobileError',
      );
    }
    final categoryError = GrievanceValidators.category(_category);
    if (categoryError != null) {
      return FieldError(
        focusNode: _categoryFocus,
        summary: 'Grievance Category: $categoryError',
      );
    }
    final descriptionError =
        GrievanceValidators.description(_descriptionController.text);
    if (descriptionError != null) {
      return FieldError(
        focusNode: _descriptionFocus,
        summary: 'Grievance Description: $descriptionError',
      );
    }
    return null;
  }

  void _handleSubmit() {
    setState(() => _autovalidate = true);
    _formKey.currentState?.validate();

    final firstInvalid = _firstInvalidField();

    if (firstInvalid != null) {
      setState(() {
        _errorSummary = 'This form has an error. ${firstInvalid.summary}.';
      });
      FocusScope.of(context).requestFocus(firstInvalid.focusNode);
      return;
    }

    setState(() => _errorSummary = null);
    final referenceNumber = ReferenceGenerator.generate();
    Navigator.of(context).pushReplacementNamed(
      SuccessScreen.routeName,
      arguments: referenceNumber,
    );
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(title: const Text('Remediated Accessible Form')),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Semantics(
                  header: true,
                  child: Text(
                    'File a Grievance',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ),
                const SizedBox(height: 6),
                const Text(
                  'All fields marked with an asterisk are required. If '
                  'something is missing, we will tell you exactly what to '
                  'fix and move you there directly.',
                ),
                const SizedBox(height: 16),
                if (_errorSummary != null)
                  Semantics(
                    liveRegion: true,
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(14),
                      margin: const EdgeInsets.only(bottom: 16),
                      decoration: BoxDecoration(
                        color: colorScheme.errorContainer,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: colorScheme.error),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(Icons.error, color: colorScheme.error),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              _errorSummary!,
                              style:
                                  TextStyle(color: colorScheme.onErrorContainer),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                Semantics(
                  container: true,
                  label: 'Personal details section',
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Semantics(
                            header: true,
                            child: Text(
                              'Personal Details',
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                          ),
                          const SizedBox(height: 12),
                          TextFormField(
                            controller: _nameController,
                            focusNode: _nameFocus,
                            textInputAction: TextInputAction.next,
                            autovalidateMode: _autovalidate
                                ? AutovalidateMode.onUserInteraction
                                : AutovalidateMode.disabled,
                            decoration: const InputDecoration(
                              labelText: 'Full Name *',
                              hintText: 'e.g., Priya Sharma',
                            ),
                            validator: GrievanceValidators.fullName,
                          ),
                          const SizedBox(height: 14),
                          TextFormField(
                            controller: _emailController,
                            focusNode: _emailFocus,
                            keyboardType: TextInputType.emailAddress,
                            textInputAction: TextInputAction.next,
                            autovalidateMode: _autovalidate
                                ? AutovalidateMode.onUserInteraction
                                : AutovalidateMode.disabled,
                            decoration: const InputDecoration(
                              labelText: 'Email Address *',
                              hintText: 'e.g., priya@example.com',
                            ),
                            validator: GrievanceValidators.email,
                          ),
                          const SizedBox(height: 14),
                          TextFormField(
                            controller: _mobileController,
                            focusNode: _mobileFocus,
                            keyboardType: TextInputType.phone,
                            textInputAction: TextInputAction.next,
                            maxLength: 10,
                            autovalidateMode: _autovalidate
                                ? AutovalidateMode.onUserInteraction
                                : AutovalidateMode.disabled,
                            decoration: const InputDecoration(
                              labelText: 'Mobile Number *',
                              hintText: 'e.g., 9876543210',
                              counterText: '',
                            ),
                            validator: GrievanceValidators.mobileNumber,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Semantics(
                  container: true,
                  label: 'Grievance details section',
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Semantics(
                            header: true,
                            child: Text(
                              'Grievance Details',
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                          ),
                          const SizedBox(height: 12),
                          DropdownButtonFormField<String>(
                            initialValue: _category,
                            focusNode: _categoryFocus,
                            autovalidateMode: _autovalidate
                                ? AutovalidateMode.onUserInteraction
                                : AutovalidateMode.disabled,
                            decoration: const InputDecoration(
                              labelText: 'Grievance Category *',
                            ),
                            items: _categories
                                .map(
                                  (c) => DropdownMenuItem(
                                    value: c,
                                    child: Text(c),
                                  ),
                                )
                                .toList(),
                            onChanged: (value) =>
                                setState(() => _category = value),
                            validator: GrievanceValidators.category,
                          ),
                          const SizedBox(height: 14),
                          TextFormField(
                            controller: _descriptionController,
                            focusNode: _descriptionFocus,
                            minLines: 4,
                            maxLines: 6,
                            textInputAction: TextInputAction.newline,
                            autovalidateMode: _autovalidate
                                ? AutovalidateMode.onUserInteraction
                                : AutovalidateMode.disabled,
                            decoration: const InputDecoration(
                              labelText: 'Grievance Description *',
                              hintText: 'Describe the issue, location, and '
                                  'any reference numbers.',
                              alignLabelWithHint: true,
                            ),
                            validator: GrievanceValidators.description,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 22),
                Semantics(
                  button: true,
                  label: 'Submit grievance',
                  hint: 'Submits the form. If information is missing, focus '
                      'moves to the first field that needs attention.',
                  child: ExcludeSemantics(
                    child: ElevatedButton.icon(
                      onPressed: _handleSubmit,
                      icon: const Icon(Icons.send),
                      label: const Text('Submit Grievance'),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                Semantics(
                  header: true,
                  child: Text(
                    'Accessibility Guidance',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
                const SizedBox(height: 10),
                const IslGuidanceCard(),
                const SizedBox(height: 24),
                _WhatChangedPanel(colorScheme: colorScheme),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _WhatChangedPanel extends StatelessWidget {
  const _WhatChangedPanel({required this.colorScheme});

  final ColorScheme colorScheme;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: colorScheme.surfaceContainerHighest,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Semantics(
              header: true,
              child: Text(
                'What changed?',
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
            const SizedBox(height: 10),
            const _ChangeRow(text: 'Semantic structure reconstructed'),
            const _ChangeRow(text: 'Logical reading order restored'),
            const _ChangeRow(text: 'Form errors made accessible'),
            const _ChangeRow(text: 'Focus moved to invalid fields'),
            const _ChangeRow(text: 'Screen-reader labels improved'),
            const _ChangeRow(text: 'ISL guidance added'),
          ],
        ),
      ),
    );
  }
}

class _ChangeRow extends StatelessWidget {
  const _ChangeRow({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: MergeSemantics(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ExcludeSemantics(
              child: Icon(
                Icons.check_circle,
                size: 18,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            const SizedBox(width: 8),
            Expanded(child: Text(text)),
          ],
        ),
      ),
    );
  }
}