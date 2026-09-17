import 'package:flutter/material.dart';

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
  bool get _isDescriptionEmpty => _descriptionController.text.trim().isEmpty;

  void _handleSubmit() {
    final hasEmptyField = _isNameEmpty ||
        _isEmailEmpty ||
        _isMobileEmpty ||
        _isCategoryEmpty ||
        _isDescriptionEmpty;

    // Demonstration only: errors are communicated with a colour change and
    // a vague message — no field-specific text, no accessibility focus
    // movement, and no screen-reader announcement of what went wrong.
    setState(() => _showColorOnlyErrors = hasEmptyField);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(hasEmptyField ? 'Error' : 'Submitted (demo only)'),
      ),
    );
  }

  InputDecoration _brokenDecoration({String? hint}) {
    return InputDecoration(
      hintText: hint,
      filled: true,
      fillColor: Colors.white,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(
          color: _showColorOnlyErrors ? Colors.red : Colors.grey,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Broken Government Grievance Form')),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Card(
                color: Colors.red.shade50,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'Accessibility issues demonstrated',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 8),
                      Text('• Visual labels not linked to their fields'),
                      Text('• Decorative icons announced as noise'),
                      Text('• No grouping between related fields'),
                      Text('• Submit control not exposed as a real button'),
                      Text('• Errors shown using colour only, no text'),
                      Text('• Focus never moves to the problem field'),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                children: const [
                  Icon(Icons.star, size: 16, color: Colors.amber),
                  SizedBox(width: 6),
                  Text('Full Name'),
                ],
              ),
              const SizedBox(height: 6),
              TextField(
                controller: _nameController,
                decoration: _brokenDecoration(),
              ),
              const SizedBox(height: 16),
              const Text('Email'),
              const SizedBox(height: 6),
              TextField(
                controller: _emailController,
                decoration: _brokenDecoration(hint: 'Enter here'),
              ),
              const SizedBox(height: 16),
              const Text('Mobile'),
              const SizedBox(height: 6),
              TextField(
                controller: _mobileController,
                decoration: _brokenDecoration(),
              ),
              const SizedBox(height: 16),
              const Text('Category'),
              const SizedBox(height: 6),
              DropdownButtonFormField<String>(
                initialValue: _selectedCategory,
                decoration: _brokenDecoration(hint: 'Select'),
                items: _categories
                    .map((c) => DropdownMenuItem(value: c, child: Text(c)))
                    .toList(),
                onChanged: (value) =>
                    setState(() => _selectedCategory = value),
              ),
              const SizedBox(height: 16),
              const Text('Description'),
              const SizedBox(height: 6),
              TextField(
                controller: _descriptionController,
                maxLines: 4,
                decoration: _brokenDecoration(),
              ),
              const SizedBox(height: 24),
              GestureDetector(
                onTap: _handleSubmit,
                child: Container(
                  height: 50,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Text(
                    'Submit',
                    style: TextStyle(color: Colors.white, fontSize: 16),
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