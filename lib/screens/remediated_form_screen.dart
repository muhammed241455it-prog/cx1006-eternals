import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';

import '../models/field_error.dart';
import '../speech_helper.dart';
import '../utils/reference_generator.dart';
import 'success_screen.dart';

const Color midnight = Color(0xFF0F1E33);
const Color cobalt = Color(0xFF2E4A67);
const Color antiqueBrass = Color(0xFFB89458);
const Color parchment = Color(0xFFD8CEBE);
const Color porcelain = Color(0xFFF4F0E8);
const Color errorRed = Color(0xFFB42318);
const Color successGreen = Color(0xFF16794A);
const Color white = Color(0xFFFFFFFF);

class GrievanceValidators {
  static String? fullName(String? value) {
    final name = value?.trim() ?? '';

    if (name.isEmpty) {
      return 'Full name is required.';
    }

    if (name.length < 2) {
      return 'Please enter your full name.';
    }

    if (name.length > 100) {
      return 'Full name is too long.';
    }

    final nameRegex = RegExp(r'^[A-Za-z]+(?: [A-Za-z]+)*$');

    if (!nameRegex.hasMatch(name)) {
      return 'Please enter a valid name using letters and spaces only.';
    }

    return null;
  }

  static String? email(String? value) {
    final email = value?.trim() ?? '';

    if (email.isEmpty) {
      return 'Email address is required.';
    }

    final emailRegex = RegExp(
      r"^[A-Za-z0-9.!#$%&'*+/=?^_`{|}~-]+"
      r"@[A-Za-z0-9]"
      r"(?:[A-Za-z0-9-]{0,61}[A-Za-z0-9])?"
      r"(?:\.[A-Za-z0-9]"
      r"(?:[A-Za-z0-9-]{0,61}[A-Za-z0-9])?)+$",
    );

    if (!emailRegex.hasMatch(email)) {
      return 'Please enter a valid email address.';
    }

    if (email.length > 254) {
      return 'Email address is too long.';
    }

    return null;
  }

  static String? mobileNumber(String? value) {
    final mobile = value?.trim() ?? '';

    if (mobile.isEmpty) {
      return 'Mobile number is required.';
    }

    if (!RegExp(r'^[0-9]+$').hasMatch(mobile)) {
      return 'Mobile number must contain digits only.';
    }

    if (mobile.length != 10) {
      return 'Please enter a valid 10 digit mobile number.';
    }

    if (!RegExp(r'^[6-9][0-9]{9}$').hasMatch(mobile)) {
      return 'Please enter a valid Indian mobile number.';
    }

    return null;
  }

  static String? category(String? value) {
    final category = value?.trim() ?? '';

    if (category.isEmpty) {
      return 'Please select a grievance category.';
    }

    return null;
  }

  static String? description(String? value) {
    final description = value?.trim() ?? '';

    if (description.isEmpty) {
      return 'Grievance description is required.';
    }

    if (description.length < 10) {
      return 'Description must contain at least 10 characters.';
    }

    if (description.length > 5000) {
      return 'Description is too long.';
    }

    return null;
  }
}

class RemediatedFormScreen extends StatefulWidget {
  const RemediatedFormScreen({super.key});

  static const routeName = '/remediated';

  @override
  State<RemediatedFormScreen> createState() =>
      _RemediatedFormScreenState();
}

class _RemediatedFormScreenState extends State<RemediatedFormScreen> {
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _mobileController = TextEditingController();
  final _descriptionController = TextEditingController();

  final _nameFocus = FocusNode(
    debugLabel: 'Full Name',
  );

  final _emailFocus = FocusNode(
    debugLabel: 'Email Address',
  );

  final _mobileFocus = FocusNode(
    debugLabel: 'Mobile Number',
  );

  final _categoryFocus = FocusNode(
    debugLabel: 'Grievance Category',
  );

  final _descriptionFocus = FocusNode(
    debugLabel: 'Grievance Description',
  );

  String? _category;

  bool _autovalidate = false;

  String? _errorSummary;

  static const List<String> _categories = [
    'Water Supply',
    'Electricity',
    'Sanitation',
    'Roads',
    'Other',
  ];

  @override
  void initState() {
    super.initState();

    _nameFocus.addListener(() {
      if (_nameFocus.hasFocus) {
        _speak('Please enter your full name.');
      }
    });

    _emailFocus.addListener(() {
      if (_emailFocus.hasFocus) {
        _speak('Please enter your email address.');
      }
    });

    _mobileFocus.addListener(() {
      if (_mobileFocus.hasFocus) {
        _speak('Please enter your 10 digit mobile number.');
      }
    });

    _categoryFocus.addListener(() {
      if (_categoryFocus.hasFocus) {
        _speak('Please select your grievance category.');
      }
    });

    _descriptionFocus.addListener(() {
      if (_descriptionFocus.hasFocus) {
        _speak('Please enter a description of your grievance.');
      }
    });
  }

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

  void _speak(String text) {
    SpeechHelper.speak(text);
  }

  FieldError? _firstInvalidField() {
    final nameError = GrievanceValidators.fullName(
      _nameController.text,
    );

    if (nameError != null) {
      return FieldError(
        focusNode: _nameFocus,
        summary: 'Full Name: $nameError',
      );
    }

    final emailError = GrievanceValidators.email(
      _emailController.text,
    );

    if (emailError != null) {
      return FieldError(
        focusNode: _emailFocus,
        summary: 'Email Address: $emailError',
      );
    }

    final mobileError = GrievanceValidators.mobileNumber(
      _mobileController.text,
    );

    if (mobileError != null) {
      return FieldError(
        focusNode: _mobileFocus,
        summary: 'Mobile Number: $mobileError',
      );
    }

    final categoryError = GrievanceValidators.category(
      _category,
    );

    if (categoryError != null) {
      return FieldError(
        focusNode: _categoryFocus,
        summary: 'Grievance Category: $categoryError',
      );
    }

    final descriptionError = GrievanceValidators.description(
      _descriptionController.text,
    );

    if (descriptionError != null) {
      return FieldError(
        focusNode: _descriptionFocus,
        summary: 'Grievance Description: $descriptionError',
      );
    }

    return null;
  }

  void _handleSubmit() {
    FocusScope.of(context).unfocus();

    setState(() {
      _autovalidate = true;
    });

    _formKey.currentState?.validate();

    final firstInvalid = _firstInvalidField();

    if (firstInvalid != null) {
      setState(() {
        _errorSummary =
            'This form has an error. ${firstInvalid.summary}.';
      });

      _speak(
        'There is an error in the form. '
        '${firstInvalid.summary}.',
      );

      Future.delayed(
        const Duration(milliseconds: 100),
        () {
          if (!mounted) {
            return;
          }

          FocusScope.of(context).requestFocus(
            firstInvalid.focusNode,
          );
        },
      );

      return;
    }

    setState(() {
      _errorSummary = null;
    });

    _speak('Your grievance is being submitted.');

    final referenceNumber = ReferenceGenerator.generate();

    Navigator.of(context).pushReplacementNamed(
      SuccessScreen.routeName,
      arguments: referenceNumber,
    );
  }

  void _openIslVideo({
    required String title,
    required String videoPath,
  }) {
    showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return _IslVideoDialog(
          title: title,
          videoPath: videoPath,
        );
      },
    );
  }

  Widget _islButton({
    required String label,
    required String videoPath,
  }) {
    return _KeyboardIslButton(
      label: label,
      videoPath: videoPath,
      onActivate: () {
        _openIslVideo(
          title: '$label - ISL Guidance',
          videoPath: videoPath,
        );
      },
    );
  }

  InputDecoration _fieldDecoration({
    required String label,
  }) {
    return InputDecoration(
      labelText: label,
      filled: true,
      fillColor: white,
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 16,
      ),
      labelStyle: const TextStyle(
        color: cobalt,
        fontSize: 16,
        fontWeight: FontWeight.w500,
      ),
      floatingLabelStyle: const TextStyle(
        color: midnight,
        fontSize: 15,
        fontWeight: FontWeight.w700,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(
          color: parchment,
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(
          color: parchment,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(
          color: antiqueBrass,
          width: 2,
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(
          color: errorRed,
          width: 2,
        ),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(
          color: errorRed,
          width: 2,
        ),
      ),
      errorStyle: const TextStyle(
        color: errorRed,
        fontSize: 13,
        fontWeight: FontWeight.w600,
      ),
    );
  }

  Widget _accessibleTextField({
    required String label,
    required String hint,
    required TextEditingController controller,
    required FocusNode focusNode,
    required String videoPath,
    TextInputType? keyboardType,
    TextInputAction? textInputAction,
    List<TextInputFormatter>? inputFormatters,
    int? maxLength,
    int minLines = 1,
    int maxLines = 1,
    String? Function(String?)? validator,
    FocusNode? nextFocus,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: TextFormField(
            controller: controller,
            focusNode: focusNode,
            keyboardType: keyboardType,
            textInputAction: textInputAction,
            inputFormatters: inputFormatters,
            maxLength: maxLength,
            minLines: minLines,
            maxLines: maxLines,
            autovalidateMode: _autovalidate
                ? AutovalidateMode.onUserInteraction
                : AutovalidateMode.disabled,
            style: const TextStyle(
              color: midnight,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
            decoration: _fieldDecoration(
              label: label,
            ).copyWith(
              hintText: hint,
              hintStyle: const TextStyle(
                color: cobalt,
                fontSize: 14,
              ),
            ),
            validator: validator,
            onChanged: (_) {
              if (_errorSummary != null) {
                setState(() {
                  _errorSummary = null;
                });
              }
            },
            onFieldSubmitted: maxLines > 1
                ? null
                : (_) {
                    if (nextFocus != null) {
                      FocusScope.of(context).requestFocus(
                        nextFocus,
                      );
                    }
                  },
          ),
        ),
        const SizedBox(width: 10),
        Padding(
          padding: const EdgeInsets.only(top: 4),
          child: _islButton(
            label: label,
            videoPath: videoPath,
          ),
        ),
      ],
    );
  }

  Widget _sectionCard({
    required String title,
    required String subtitle,
    required IconData icon,
    required Widget child,
  }) {
    return Card(
      margin: EdgeInsets.zero,
      elevation: 0,
      color: porcelain,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
        side: const BorderSide(
          color: parchment,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(22),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: midnight,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    icon,
                    color: antiqueBrass,
                    size: 22,
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,
                    children: [
                      Semantics(
                        header: true,
                        child: Text(
                          title,
                          style: const TextStyle(
                            color: midnight,
                            fontSize: 20,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        subtitle,
                        style: const TextStyle(
                          color: cobalt,
                          fontSize: 14,
                          height: 1.4,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 22),
            child,
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: porcelain,
      appBar: AppBar(
        backgroundColor: midnight,
        foregroundColor: white,
        elevation: 0,
        titleSpacing: 20,
        title: Row(
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: antiqueBrass,
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(
                Icons.accessibility_new,
                color: midnight,
                size: 21,
              ),
            ),
            const SizedBox(width: 12),
            const Text(
              'CX1006',
              style: TextStyle(
                color: white,
                fontSize: 18,
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(width: 8),
            Container(
              width: 1,
              height: 20,
              color: parchment,
            ),
            const SizedBox(width: 8),
            const Flexible(
              child: Text(
                'Accessible Grievance Portal',
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: parchment,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: ListView(
            padding: const EdgeInsets.fromLTRB(
              20,
              24,
              20,
              40,
            ),
            children: [
              Semantics(
                header: true,
                child: Text(
                  'Submit Your Grievance',
                  style: Theme.of(context)
                      .textTheme
                      .headlineSmall
                      ?.copyWith(
                        color: midnight,
                        fontWeight: FontWeight.w800,
                      ),
                ),
              ),
              const SizedBox(height: 6),
              const Text(
                'This remediated form provides logical keyboard navigation, screen-reader semantics, error focus management and Indian Sign Language guidance.',
                style: TextStyle(
                  color: cobalt,
                  fontSize: 15,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 20),

              if (_errorSummary != null)
                Semantics(
                  liveRegion: true,
                  container: true,
                  label: 'Form error: $_errorSummary',
                  child: Container(
                    width: double.infinity,
                    margin: const EdgeInsets.only(
                      bottom: 20,
                    ),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: errorRed.withValues(
                        alpha: 0.08,
                      ),
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(
                        color: errorRed.withValues(
                          alpha: 0.35,
                        ),
                      ),
                    ),
                    child: Row(
                      crossAxisAlignment:
                          CrossAxisAlignment.start,
                      children: [
                        const Icon(
                          Icons.error_outline,
                          color: errorRed,
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            _errorSummary!,
                            style: const TextStyle(
                              color: midnight,
                              fontSize: 14,
                              height: 1.4,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

              Semantics(
                container: true,
                label: 'Personal details section',
                child: _sectionCard(
                  title: 'Personal Details',
                  subtitle:
                      'Tell us how we can contact you.',
                  icon: Icons.person_outline,
                  child: Column(
                    children: [
                      _accessibleTextField(
                        label: 'Full Name',
                        hint: 'e.g. Priya Sharma',
                        controller: _nameController,
                        focusNode: _nameFocus,
                        videoPath:
                            'assets/videos/full_name.mp4',
                        textInputAction:
                            TextInputAction.next,
                        inputFormatters: const [
                          _StrictFullNameFormatter(),
                        ],
                        validator:
                            GrievanceValidators.fullName,
                        nextFocus: _emailFocus,
                      ),
                      const SizedBox(height: 18),
                      _accessibleTextField(
                        label: 'Email Address',
                        hint: 'e.g. priya@gmail.com',
                        controller: _emailController,
                        focusNode: _emailFocus,
                        videoPath:
                            'assets/videos/email.mp4',
                        keyboardType:
                            TextInputType.emailAddress,
                        textInputAction:
                            TextInputAction.next,
                        inputFormatters: const [
                          _EmailCharactersFormatter(),
                        ],
                        validator:
                            GrievanceValidators.email,
                        nextFocus: _mobileFocus,
                      ),
                      const SizedBox(height: 18),
                      _accessibleTextField(
                        label: 'Mobile Number',
                        hint: 'e.g. 9876543210',
                        controller: _mobileController,
                        focusNode: _mobileFocus,
                        videoPath:
                            'assets/videos/mobile_no.mp4',
                        keyboardType: TextInputType.phone,
                        textInputAction:
                            TextInputAction.next,
                        maxLength: 10,
                        inputFormatters: const [
                          _StrictMobileFormatter(),
                        ],
                        validator:
                            GrievanceValidators.mobileNumber,
                        nextFocus: _categoryFocus,
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 20),

              Semantics(
                container: true,
                label: 'Grievance details section',
                child: _sectionCard(
                  title: 'Grievance Details',
                  subtitle:
                      'Describe the issue and select the relevant category.',
                  icon: Icons.assignment_outlined,
                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.stretch,
                    children: [
                      Semantics(
                        label:
                            'Grievance Category. Use arrow keys to choose a category.',
                        child: DropdownButtonFormField<String>(
                          initialValue: _category,
                          focusNode: _categoryFocus,
                          decoration: _fieldDecoration(
                            label: 'Grievance Category',
                          ),
                          items: _categories.map(
                            (category) {
                              return DropdownMenuItem<String>(
                                value: category,
                                child: Text(category),
                              );
                            },
                          ).toList(),
                          onChanged: (value) {
                            setState(() {
                              _category = value;
                              _errorSummary = null;
                            });

                            if (value != null) {
                              _speak(
                                'Grievance category selected: $value.',
                              );
                            }
                          },
                          validator:
                              GrievanceValidators.category,
                        ),
                      ),
                      const SizedBox(height: 18),
                      _accessibleTextField(
                        label: 'Grievance Description',
                        hint:
                            'Describe your grievance in at least 10 characters.',
                        controller:
                            _descriptionController,
                        focusNode: _descriptionFocus,
                        videoPath:
                            'assets/videos/description.mp4',
                        textInputAction:
                            TextInputAction.newline,
                        minLines: 5,
                        maxLines: 8,
                        validator:
                            GrievanceValidators.description,
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 22),

              Semantics(
                button: true,
                label: 'Submit grievance',
                hint:
                    'Press Enter or Space to submit the grievance.',
                child: ElevatedButton.icon(
                  onPressed: _handleSubmit,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: midnight,
                    foregroundColor: white,
                    minimumSize:
                        const Size.fromHeight(54),
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(14),
                    ),
                  ),
                  icon: const Icon(Icons.send),
                  label: const Text(
                    'Submit Grievance',
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 24),

              Semantics(
                header: true,
                child: const Text(
                  'Accessibility Guidance',
                  style: TextStyle(
                    color: midnight,
                    fontSize: 19,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),

              const SizedBox(height: 10),

              Card(
                margin: EdgeInsets.zero,
                elevation: 0,
                color: midnight,
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(16),
                  side: const BorderSide(
                    color: antiqueBrass,
                  ),
                ),
                child: const Padding(
                  padding: EdgeInsets.all(16),
                  child: Row(
                    children: [
                      Icon(
                        Icons.sign_language,
                        color: antiqueBrass,
                        size: 32,
                      ),
                      SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          'Use Tab to move through the form. When the hand-sign button receives keyboard focus, press Enter or Space to open its ISL guidance video.',
                          style: TextStyle(
                            color: porcelain,
                            fontSize: 14,
                            height: 1.45,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 24),

              const _WhatChangedPanel(),
            ],
          ),
        ),
      ),
    );
  }
}

class _KeyboardIslButton extends StatefulWidget {
  const _KeyboardIslButton({
    required this.label,
    required this.videoPath,
    required this.onActivate,
  });

  final String label;
  final String videoPath;
  final VoidCallback onActivate;

  @override
  State<_KeyboardIslButton> createState() =>
      _KeyboardIslButtonState();
}

class _KeyboardIslButtonState
    extends State<_KeyboardIslButton> {
  late final FocusNode _focusNode;

  bool _focused = false;
  bool _hovered = false;

  @override
  void initState() {
    super.initState();

    _focusNode = FocusNode(
      debugLabel:
          'ISL video for ${widget.label}',
    );
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  KeyEventResult _handleKeyEvent(
    FocusNode node,
    KeyEvent event,
  ) {
    if (event is KeyDownEvent &&
        (event.logicalKey ==
                LogicalKeyboardKey.enter ||
            event.logicalKey ==
                LogicalKeyboardKey.numpadEnter ||
            event.logicalKey ==
                LogicalKeyboardKey.space)) {
      widget.onActivate();

      return KeyEventResult.handled;
    }

    return KeyEventResult.ignored;
  }

  @override
  Widget build(BuildContext context) {
    final active = _focused || _hovered;

    return Semantics(
      button: true,
      focusable: true,
      label:
          'Indian Sign Language video for ${widget.label}',
      hint:
          'Press Enter or Space to watch the ISL video.',
      onTap: widget.onActivate,
      child: Focus(
        focusNode: _focusNode,
        canRequestFocus: true,
        skipTraversal: false,
        onFocusChange: (value) {
          setState(() {
            _focused = value;
          });
        },
        onKeyEvent: _handleKeyEvent,
        child: MouseRegion(
          cursor: SystemMouseCursors.click,
          onEnter: (_) {
            setState(() {
              _hovered = true;
            });
          },
          onExit: (_) {
            setState(() {
              _hovered = false;
            });
          },
          child: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: widget.onActivate,
            child: AnimatedContainer(
              duration:
                  const Duration(milliseconds: 120),
              width: 52,
              height: 52,
              decoration: BoxDecoration(
                color:
                    active ? midnight : porcelain,
                borderRadius:
                    BorderRadius.circular(13),
                border: Border.all(
                  color: active
                      ? antiqueBrass
                      : cobalt,
                  width: active ? 2 : 1,
                ),
                boxShadow: active
                    ? [
                        BoxShadow(
                          color:
                              antiqueBrass.withValues(
                            alpha: 0.28,
                          ),
                          blurRadius: 8,
                          spreadRadius: 1,
                        ),
                      ]
                    : null,
              ),
              child: Icon(
                Icons.sign_language,
                color: active
                    ? antiqueBrass
                    : cobalt,
                size: 28,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _StrictFullNameFormatter
    extends TextInputFormatter {
  const _StrictFullNameFormatter();

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    var value = newValue.text.replaceAll(
      RegExp(r'[^A-Za-z ]'),
      '',
    );

    value = value.replaceAll(
      RegExp(r' {2,}'),
      ' ',
    );

    if (value.startsWith(' ')) {
      value = value.substring(1);
    }

    return TextEditingValue(
      text: value,
      selection: TextSelection.collapsed(
        offset: value.length,
      ),
    );
  }
}

class _StrictMobileFormatter
    extends TextInputFormatter {
  const _StrictMobileFormatter();

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    var value = newValue.text.replaceAll(
      RegExp(r'[^0-9]'),
      '',
    );

    if (value.length > 10) {
      value = value.substring(0, 10);
    }

    return TextEditingValue(
      text: value,
      selection: TextSelection.collapsed(
        offset: value.length,
      ),
    );
  }
}

class _EmailCharactersFormatter
    extends TextInputFormatter {
  const _EmailCharactersFormatter();

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    String value = newValue.text;

    value = value.replaceAll(
      RegExp(r'\s'),
      '',
    );

    value = value.replaceAll(
      RegExp(r'[^A-Za-z0-9@._%+\-]'),
      '',
    );

    final firstAt = value.indexOf('@');

    if (firstAt != -1) {
      final beforeAt =
          value.substring(0, firstAt);

      var afterAt =
          value.substring(firstAt + 1);

      afterAt = afterAt.replaceAll('@', '');

      value = '$beforeAt@$afterAt';
    }

    if (value.startsWith('@')) {
      value = value.substring(1);
    }

    if (value.startsWith('.')) {
      value = value.substring(1);
    }

    return TextEditingValue(
      text: value,
      selection: TextSelection.collapsed(
        offset: value.length,
      ),
    );
  }
}

class _IslVideoDialog extends StatefulWidget {
  const _IslVideoDialog({
    required this.title,
    required this.videoPath,
  });

  final String title;
  final String videoPath;

  @override
  State<_IslVideoDialog> createState() =>
      _IslVideoDialogState();
}

class _IslVideoDialogState
    extends State<_IslVideoDialog> {
  late final VideoPlayerController _controller;

  String? _error;

  @override
  void initState() {
    super.initState();

    _controller =
        VideoPlayerController.asset(
      widget.videoPath,
    );

    _initializeVideo();
  }

  Future<void> _initializeVideo() async {
    try {
      await _controller.initialize();

      if (!mounted) {
        return;
      }

      setState(() {});

      try {
        await _controller.play();
      } catch (_) {
        // Browser autoplay restrictions
        // may prevent automatic playback.
      }
    } catch (_) {
      if (!mounted) {
        return;
      }

      setState(() {
        _error =
            'The ISL video could not be loaded.';
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _togglePlayback() {
    if (!_controller.value.isInitialized) {
      return;
    }

    setState(() {
      if (_controller.value.isPlaying) {
        _controller.pause();
      } else {
        _controller.play();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: porcelain,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
      ),
      child: ConstrainedBox(
        constraints:
            const BoxConstraints(maxWidth: 680),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment:
                CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 42,
                    height: 42,
                    decoration: BoxDecoration(
                      color: midnight,
                      borderRadius:
                          BorderRadius.circular(12),
                    ),
                    child: const Icon(
                      Icons.sign_language,
                      color: antiqueBrass,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      widget.title,
                      style: const TextStyle(
                        color: midnight,
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                  IconButton(
                    tooltip: 'Close',
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: const Icon(
                      Icons.close,
                      color: cobalt,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 18),

              if (_error != null)
                Container(
                  width: double.infinity,
                  padding:
                      const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: errorRed.withValues(
                      alpha: 0.08,
                    ),
                    borderRadius:
                        BorderRadius.circular(12),
                    border: Border.all(
                      color: errorRed.withValues(
                        alpha: 0.3,
                      ),
                    ),
                  ),
                  child: Text(
                    _error!,
                    style: const TextStyle(
                      color: errorRed,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                )
              else if (_controller.value.isInitialized)
                ClipRRect(
                  borderRadius:
                      BorderRadius.circular(14),
                  child: AspectRatio(
                    aspectRatio:
                        _controller.value.aspectRatio ==
                                0
                            ? 16 / 9
                            : _controller
                                .value
                                .aspectRatio,
                    child: VideoPlayer(_controller),
                  ),
                )
              else
                const SizedBox(
                  height: 260,
                  child: Center(
                    child:
                        CircularProgressIndicator(
                      color: antiqueBrass,
                    ),
                  ),
                ),

              const SizedBox(height: 14),

              Row(
                mainAxisAlignment:
                    MainAxisAlignment.end,
                children: [
                  TextButton.icon(
                    onPressed:
                        _controller.value.isInitialized
                            ? _togglePlayback
                            : null,
                    icon: Icon(
                      _controller.value.isPlaying
                          ? Icons.pause
                          : Icons.play_arrow,
                    ),
                    label: Text(
                      _controller.value.isPlaying
                          ? 'Pause'
                          : 'Play',
                    ),
                  ),
                  const SizedBox(width: 8),
                  FilledButton(
                    style: FilledButton.styleFrom(
                      backgroundColor: midnight,
                      foregroundColor: white,
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('Close'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _WhatChangedPanel
    extends StatelessWidget {
  const _WhatChangedPanel();

  @override
  Widget build(BuildContext context) {
    const items = [
      'Logical reading order for assistive technology.',
      'Clear labels, hints and semantic descriptions.',
      'Automatic focus on the first invalid field.',
      'Keyboard Tab navigation through interactive controls.',
      'Enter or Space activates the focused ISL hand-sign button.',
      'Indian Sign Language guidance beside relevant fields.',
      'Accessible validation and error announcements.',
      'Automatic spoken guidance when form fields receive focus.',
      'Spoken confirmation when a grievance category is selected.',
      'Strict input filtering for name, email and mobile number.',
    ];

    return Card(
      margin: EdgeInsets.zero,
      elevation: 0,
      color: midnight,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
        side: const BorderSide(
          color: antiqueBrass,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,
          children: [
            const Text(
              'What Changed',
              style: TextStyle(
                color: white,
                fontSize: 20,
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 12),
            for (final item in items)
              Padding(
                padding: const EdgeInsets.only(
                  bottom: 10,
                ),
                child: Row(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(top: 2),
                      child: Icon(
                        Icons.check_circle_outline,
                        color: antiqueBrass,
                        size: 19,
                      ),
                    ),
                    const SizedBox(width: 9),
                    Expanded(
                      child: Text(
                        item,
                        style: const TextStyle(
                          color: porcelain,
                          fontSize: 14,
                          height: 1.4,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
gi