import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';

import '../models/field_error.dart';
import '../speech_helper.dart';
import '../utils/reference_generator.dart';
import '../utils/validators.dart';
import 'success_screen.dart';

// ================================================================
// GLOBAL DESIGN COLORS
// These are also used by helper widgets below the main screen.
// ================================================================

const Color navy = Color(0xFF172554);
const Color primaryBlue = Color(0xFF2563EB);
const Color lightBlue = Color(0xFFEFF6FF);
const Color background = Color(0xFFF8FAFC);
const Color white = Color(0xFFFFFFFF);
const Color primaryText = Color(0xFF0F172A);
const Color secondaryText = Color(0xFF475569);
const Color border = Color(0xFFCBD5E1);
const Color errorRed = Color(0xFFDC2626);
const Color successGreen = Color(0xFF15803D);


class RemediatedFormScreen extends StatefulWidget {
  const RemediatedFormScreen({super.key});

  static const routeName = '/remediated';

  @override
  State<RemediatedFormScreen> createState() =>
      _RemediatedFormScreenState();
}

class _RemediatedFormScreenState
    extends State<RemediatedFormScreen> {
  // ============================================================
  // DESIGN COLORS
  // ============================================================

  static const Color navy = Color(0xFF172554);
  static const Color primaryBlue = Color(0xFF2563EB);
  static const Color lightBlue = Color(0xFFEFF6FF);
  static const Color background = Color(0xFFF8FAFC);
  static const Color white = Color(0xFFFFFFFF);
  static const Color primaryText = Color(0xFF0F172A);
  static const Color secondaryText = Color(0xFF475569);
  static const Color border = Color(0xFFCBD5E1);
  static const Color errorRed = Color(0xFFDC2626);
  static const Color successGreen = Color(0xFF15803D);

  // ============================================================
  // FORM
  // ============================================================

  final _formKey = GlobalKey<FormState>();

  // ============================================================
  // CONTROLLERS
  // ============================================================

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _mobileController = TextEditingController();
  final _descriptionController = TextEditingController();

  // ============================================================
  // FOCUS NODES
  // ============================================================

  final _nameFocus =
      FocusNode(debugLabel: 'Full Name');

  final _emailFocus =
      FocusNode(debugLabel: 'Email Address');

  final _mobileFocus =
      FocusNode(debugLabel: 'Mobile Number');

  final _categoryFocus =
      FocusNode(debugLabel: 'Grievance Category');

  final _descriptionFocus =
      FocusNode(debugLabel: 'Grievance Description');

  // ============================================================
  // STATE
  // ============================================================

  String? _category;

  bool _autovalidate = false;

  String? _errorSummary;

  // ============================================================
  // CATEGORY LIST
  // ============================================================

  static const List<String> _categories = [
    'Water Supply',
    'Electricity',
    'Sanitation',
    'Roads',
    'Other',
  ];

  // ============================================================
  // INITIALIZE
  // ============================================================

  @override
  void initState() {
    super.initState();

    _nameFocus.addListener(() {
      if (_nameFocus.hasFocus) {
        _speak(
          'Please enter your full name.',
        );
      }
    });

    _emailFocus.addListener(() {
      if (_emailFocus.hasFocus) {
        _speak(
          'Please enter your email address.',
        );
      }
    });

    _mobileFocus.addListener(() {
      if (_mobileFocus.hasFocus) {
        _speak(
          'Please enter your 10 digit mobile number.',
        );
      }
    });

    _categoryFocus.addListener(() {
      if (_categoryFocus.hasFocus) {
        _speak(
          'Please select your grievance category.',
        );
      }
    });

    _descriptionFocus.addListener(() {
      if (_descriptionFocus.hasFocus) {
        _speak(
          'Please enter a description of your grievance.',
        );
      }
    });
  }

  // ============================================================
  // TEXT TO SPEECH
  // ============================================================

  void _speak(String text) {
    SpeechHelper.speak(text);
  }

  // ============================================================
  // FIND FIRST INVALID FIELD
  // ============================================================

  FieldError? _firstInvalidField() {
    final nameError =
        GrievanceValidators.fullName(
      _nameController.text,
    );

    if (nameError != null) {
      return FieldError(
        focusNode: _nameFocus,
        summary: 'Full Name: $nameError',
      );
    }

    final emailError =
        GrievanceValidators.email(
      _emailController.text,
    );

    if (emailError != null) {
      return FieldError(
        focusNode: _emailFocus,
        summary: 'Email: $emailError',
      );
    }

    final mobileError =
        GrievanceValidators.mobileNumber(
      _mobileController.text,
    );

    if (mobileError != null) {
      return FieldError(
        focusNode: _mobileFocus,
        summary:
            'Mobile Number: $mobileError',
      );
    }

    final categoryError =
        GrievanceValidators.category(
      _category,
    );

    if (categoryError != null) {
      return FieldError(
        focusNode: _categoryFocus,
        summary:
            'Grievance Category: $categoryError',
      );
    }

    final descriptionError =
        GrievanceValidators.description(
      _descriptionController.text,
    );

    if (descriptionError != null) {
      return FieldError(
        focusNode: _descriptionFocus,
        summary:
            'Grievance Description: $descriptionError',
      );
    }

    return null;
  }

  // ============================================================
  // SUBMIT
  // ============================================================

  void _handleSubmit() {
    setState(() {
      _autovalidate = true;
    });

    _formKey.currentState?.validate();

    final firstInvalid =
        _firstInvalidField();

    if (firstInvalid != null) {
      setState(() {
        _errorSummary =
            'This form has an error. '
            '${firstInvalid.summary}.';
      });

      _speak(
        'There is an error in the form. '
        '${firstInvalid.summary}.',
      );

      FocusScope.of(context).requestFocus(
        firstInvalid.focusNode,
      );

      return;
    }

    setState(() {
      _errorSummary = null;
    });

    _speak(
      'Your grievance is being submitted.',
    );

    final referenceNumber =
        ReferenceGenerator.generate();

    Navigator.of(context).pushReplacementNamed(
      SuccessScreen.routeName,
      arguments: referenceNumber,
    );
  }

  // ============================================================
  // FIELD DECORATION
  // ============================================================

  InputDecoration _fieldDecoration({
    required String label,
    required String hint,
    bool multiline = false,
  }) {
    return InputDecoration(
      label: _RequiredLabel(
        text: label,
      ),
      hintText: hint,
      alignLabelWithHint: multiline,

      filled: true,
      fillColor: white,

      contentPadding:
          const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 16,
      ),

      hintStyle: const TextStyle(
        color: secondaryText,
        fontSize: 15,
      ),

      labelStyle: const TextStyle(
        color: secondaryText,
        fontSize: 16,
        fontWeight: FontWeight.w500,
      ),

      floatingLabelStyle:
          const TextStyle(
        color: primaryBlue,
        fontSize: 15,
        fontWeight: FontWeight.w700,
      ),

      border: OutlineInputBorder(
        borderRadius:
            BorderRadius.circular(12),
        borderSide: const BorderSide(
          color: border,
          width: 1,
        ),
      ),

      enabledBorder: OutlineInputBorder(
        borderRadius:
            BorderRadius.circular(12),
        borderSide: const BorderSide(
          color: border,
          width: 1,
        ),
      ),

      focusedBorder: OutlineInputBorder(
        borderRadius:
            BorderRadius.circular(12),
        borderSide: const BorderSide(
          color: primaryBlue,
          width: 2,
        ),
      ),

      errorBorder: OutlineInputBorder(
        borderRadius:
            BorderRadius.circular(12),
        borderSide: const BorderSide(
          color: errorRed,
          width: 2,
        ),
      ),

      focusedErrorBorder:
          OutlineInputBorder(
        borderRadius:
            BorderRadius.circular(12),
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

      prefixIconConstraints:
          const BoxConstraints(
        minWidth: 48,
      ),
    );
  }

  // ============================================================
  // ISL BUTTON
  // ============================================================

  Widget _islButton({
    required String label,
    required String videoPath,
  }) {
    return Semantics(
      button: true,
      label:
          'Indian Sign Language video for $label',
      hint:
          'Double tap to watch the ISL video',
      child: Container(
        width: 48,
        height: 48,

        decoration: BoxDecoration(
          color: lightBlue,
          borderRadius:
              BorderRadius.circular(12),
          border: Border.all(
            color:
                primaryBlue.withValues(
              alpha: 0.25,
            ),
          ),
        ),

        child: IconButton(
          tooltip:
              'Watch ISL video for $label',

          icon: const Icon(
            Icons.sign_language,
            size: 24,
            color: primaryBlue,
          ),

          onPressed: () {
            _openIslVideo(
              title:
                  '$label - ISL Guidance',
              videoPath: videoPath,
            );
          },
        ),
      ),
    );
  }

  // ============================================================
  // OPEN ISL VIDEO
  // ============================================================

  void _openIslVideo({
    required String title,
    required String videoPath,
  }) {
    showDialog(
      context: context,
      builder: (context) {
        return _IslVideoDialog(
          title: title,
          videoPath: videoPath,
        );
      },
    );
  }

  // ============================================================
  // ACCESSIBLE TEXT FIELD
  // ============================================================

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
  }) {
    return Row(
      crossAxisAlignment:
          CrossAxisAlignment.start,

      children: [
        Expanded(
          child: TextFormField(
            controller: controller,
            focusNode: focusNode,

            keyboardType: keyboardType,
            textInputAction: textInputAction,

            inputFormatters:
                inputFormatters,

            maxLength: maxLength,

            minLines: minLines,
            maxLines: maxLines,

            autovalidateMode:
                _autovalidate
                    ? AutovalidateMode
                        .onUserInteraction
                    : AutovalidateMode
                        .disabled,

            style: const TextStyle(
              color: primaryText,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),

            decoration:
                _fieldDecoration(
              label: label,
              hint: hint,
              multiline: minLines > 1,
            ).copyWith(
              counterText:
                  maxLength != null
                      ? ''
                      : null,
            ),

            validator: validator,
          ),
        ),

        const SizedBox(
          width: 12,
        ),

        Padding(
          padding:
              const EdgeInsets.only(
            top: 1,
          ),
          child: _islButton(
            label: label,
            videoPath: videoPath,
          ),
        ),
      ],
    );
  }

  // ============================================================
  // SECTION CARD
  // ============================================================

  Widget _sectionCard({
    required String title,
    required String subtitle,
    required IconData icon,
    required Widget child,
  }) {
    return Container(
      width: double.infinity,

      decoration: BoxDecoration(
        color: white,

        borderRadius:
            BorderRadius.circular(16),

        border: Border.all(
          color: border,
          width: 1,
        ),

        boxShadow: const [
          BoxShadow(
            color: Color(0x0A0F172A),
            blurRadius: 16,
            offset: Offset(0, 4),
          ),
        ],
      ),

      child: Padding(
        padding:
            const EdgeInsets.all(24),

        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,

          children: [
            Row(
              crossAxisAlignment:
                  CrossAxisAlignment.start,

              children: [
                Container(
                  width: 44,
                  height: 44,

                  decoration: BoxDecoration(
                    color: lightBlue,
                    borderRadius:
                        BorderRadius.circular(
                      12,
                    ),
                  ),

                  child: Icon(
                    icon,
                    color: primaryBlue,
                    size: 22,
                  ),
                ),

                const SizedBox(
                  width: 14,
                ),

                Expanded(
                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,

                    children: [
                      Semantics(
                        header: true,

                        child: Text(
                          title,
                          style:
                              const TextStyle(
                            color:
                                primaryText,
                            fontSize: 20,
                            fontWeight:
                                FontWeight.w700,
                          ),
                        ),
                      ),

                      const SizedBox(
                        height: 4,
                      ),

                      Text(
                        subtitle,
                        style:
                            const TextStyle(
                          color:
                              secondaryText,
                          fontSize: 14,
                          height: 1.4,
                        ),
                      ),
                    ],
                  ),
                ),
              ],

            ),

            const SizedBox(
              height: 24,
            ),

            child,
          ],
        ),
      ),
    );
  }

  // ============================================================
  // BUILD
  // ============================================================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,

      appBar: AppBar(
        backgroundColor: white,
        foregroundColor: primaryText,

        elevation: 0,

        surfaceTintColor:
            Colors.transparent,

        centerTitle: false,

        titleSpacing: 24,

        title: Row(
          children: [
            Container(
              width: 36,
              height: 36,

              decoration: BoxDecoration(
                color: navy,
                borderRadius:
                    BorderRadius.circular(10),
              ),

              child: const Icon(
                Icons.accessibility_new,
                color: white,
                size: 21,
              ),
            ),

            const SizedBox(
              width: 12,
            ),

            const Text(
              'CX1006',
              style: TextStyle(
                color: navy,
                fontSize: 18,
                fontWeight:
                    FontWeight.w800,
              ),
            ),

            const SizedBox(
              width: 8,
            ),

            Container(
              width: 1,
              height: 20,
              color: border,
            ),

            const SizedBox(
              width: 8,
            ),

            const Text(
              'Accessible Grievance Portal',
              style: TextStyle(
                color: secondaryText,
                fontSize: 14,
                fontWeight:
                    FontWeight.w500,
              ),
            ),
          ],
        ),
      ),

      body: SafeArea(
        child: Form(
          key: _formKey,

          child: SingleChildScrollView(
            padding:
                const EdgeInsets.fromLTRB(
              24,
              32,
              24,
              48,
            ),

            child: Center(
              child: ConstrainedBox(
                constraints:
                    const BoxConstraints(
                  maxWidth: 1000,
                ),

                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment
                          .stretch,

                  children: [
                    // ==================================================
                    // PAGE HEADER
                    // ==================================================

                    Container(
                      padding:
                          const EdgeInsets.all(
                        24,
                      ),

                      decoration:
                          BoxDecoration(
                        color: navy,

                        borderRadius:
                            BorderRadius.circular(
                          18,
                        ),
                      ),

                      child: Row(
                        crossAxisAlignment:
                            CrossAxisAlignment
                                .start,

                        children: [
                          Container(
                            width: 52,
                            height: 52,

                            decoration:
                                BoxDecoration(
                              color:
                                  Colors.white
                                      .withValues(
                                alpha: 0.12,
                              ),
                              borderRadius:
                                  BorderRadius
                                      .circular(
                                14,
                              ),
                            ),

                            child:
                                const Icon(
                              Icons
                                  .accessibility_new,
                              color: white,
                              size: 28,
                            ),
                          ),

                          const SizedBox(
                            width: 16,
                          ),

                          Expanded(
                            child: Column(
                              crossAxisAlignment:
                                  CrossAxisAlignment
                                      .start,

                              children: [
                                Container(
                                  padding:
                                      const EdgeInsets
                                          .symmetric(
                                    horizontal: 10,
                                    vertical: 5,
                                  ),

                                  decoration:
                                      BoxDecoration(
                                    color:
                                        primaryBlue,
                                    borderRadius:
                                        BorderRadius
                                            .circular(
                                      20,
                                    ),
                                  ),

                                  child:
                                      const Text(
                                    'ACCESSIBILITY REMEDIATION',
                                    style:
                                        TextStyle(
                                      color: white,
                                      fontSize: 11,
                                      fontWeight:
                                          FontWeight
                                              .w800,
                                      letterSpacing:
                                          0.5,
                                    ),
                                  ),
                                ),

                                const SizedBox(
                                  height: 10,
                                ),

                                Semantics(
                                  header: true,

                                  child: const Text(
                                    'File a Grievance',
                                    style:
                                        TextStyle(
                                      color: white,
                                      fontSize: 30,
                                      fontWeight:
                                          FontWeight
                                              .w800,
                                      height: 1.15,
                                    ),
                                  ),
                                ),

                                const SizedBox(
                                  height: 8,
                                ),

                                const Text(
                                  'An accessible version of the government grievance form, designed with clear structure, readable labels, error guidance, voice assistance and Indian Sign Language support.',
                                  style:
                                      TextStyle(
                                    color:
                                        Color(
                                      0xFFE2E8F0,
                                    ),
                                    fontSize: 15,
                                    height: 1.5,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(
                      height: 18,
                    ),

                    // ==================================================
                    // REQUIRED INFORMATION BANNER
                    // ==================================================

                    Container(
                      padding:
                          const EdgeInsets
                              .symmetric(
                        horizontal: 16,
                        vertical: 14,
                      ),

                      decoration:
                          BoxDecoration(
                        color: lightBlue,

                        borderRadius:
                            BorderRadius.circular(
                          12,
                        ),

                        border: Border.all(
                          color:
                              primaryBlue
                                  .withValues(
                            alpha: 0.20,
                          ),
                        ),
                      ),

                      child: Row(
                        crossAxisAlignment:
                            CrossAxisAlignment
                                .start,

                        children: [
                          const Icon(
                            Icons.info_outline,
                            color:
                                primaryBlue,
                            size: 22,
                          ),

                          const SizedBox(
                            width: 12,
                          ),

                          const Expanded(
                            child: Text(
                              'All fields marked with a red dot are required. If something is missing, we will tell you exactly what to fix and move you there directly.',
                              style:
                                  TextStyle(
                                color:
                                    primaryText,
                                fontSize: 14,
                                height: 1.45,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(
                      height: 20,
                    ),

                    // ==================================================
                    // ERROR SUMMARY
                    // ==================================================

                    if (_errorSummary != null)
                      Semantics(
                        liveRegion: true,

                        child: Container(
                          width:
                              double.infinity,

                          padding:
                              const EdgeInsets
                                  .all(16),

                          margin:
                              const EdgeInsets
                                  .only(
                            bottom: 20,
                          ),

                          decoration:
                              BoxDecoration(
                            color: const Color(
                              0xFFFEF2F2,
                            ),

                            borderRadius:
                                BorderRadius
                                    .circular(
                              12,
                            ),

                            border: Border.all(
                              color:
                                  errorRed,
                              width: 1.5,
                            ),
                          ),

                          child: Row(
                            crossAxisAlignment:
                                CrossAxisAlignment
                                    .start,

                            children: [
                              const Icon(
                                Icons
                                    .error_outline,
                                color:
                                    errorRed,
                                size: 24,
                              ),

                              const SizedBox(
                                width: 12,
                              ),

                              Expanded(
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment
                                          .start,

                                  children: [
                                    const Text(
                                      'Please fix the following issue',
                                      style:
                                          TextStyle(
                                        color:
                                            errorRed,
                                        fontSize:
                                            15,
                                        fontWeight:
                                            FontWeight
                                                .w700,
                                      ),
                                    ),

                                    const SizedBox(
                                      height: 4,
                                    ),

                                    Text(
                                      _errorSummary!,
                                      style:
                                          const TextStyle(
                                        color:
                                            primaryText,
                                        fontSize:
                                            14,
                                        height:
                                            1.4,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                    // ==================================================
                    // PERSONAL DETAILS
                    // ==================================================

                    Semantics(
                      container: true,

                      label:
                          'Personal details section',

                      child: _sectionCard(
                        title:
                            'Personal Details',
                        subtitle:
                            'Tell us how we can contact you.',
                        icon:
                            Icons.person_outline,

                        child: Column(
                          children: [
                            // FULL NAME
                            _accessibleTextField(
                              label:
                                  'Full Name',
                              hint:
                                  'e.g. Priya Sharma',

                              controller:
                                  _nameController,

                              focusNode:
                                  _nameFocus,

                              videoPath:
                                  'assets/videos/full_name.mp4',

                              textInputAction:
                                  TextInputAction
                                      .next,

                              inputFormatters: [
                                _StrictFullNameFormatter(),
                              ],

                              validator:
                                  GrievanceValidators
                                      .fullName,
                            ),

                            const SizedBox(
                              height: 18,
                            ),

                            // EMAIL
                            _accessibleTextField(
                              label:
                                  'Email Address',
                              hint:
                                  'e.g. priya@gmail.com',

                              controller:
                                  _emailController,

                              focusNode:
                                  _emailFocus,

                              videoPath:
                                  'assets/videos/email.mp4',

                              keyboardType:
                                  TextInputType
                                      .emailAddress,

                              textInputAction:
                                  TextInputAction
                                      .next,

                              inputFormatters: [
                                _EmailCharactersFormatter(),
                              ],

                              validator:
                                  GrievanceValidators
                                      .email,
                            ),

                            const SizedBox(
                              height: 18,
                            ),

                            // MOBILE
                            _accessibleTextField(
                              label:
                                  'Mobile Number',
                              hint:
                                  'e.g. 9876543210',

                              controller:
                                  _mobileController,

                              focusNode:
                                  _mobileFocus,

                              videoPath:
                                  'assets/videos/mobile_no.mp4',

                              keyboardType:
                                  TextInputType
                                      .phone,

                              textInputAction:
                                  TextInputAction
                                      .next,

                              maxLength: 10,

                              inputFormatters: [
                                _StrictMobileFormatter(),
                              ],

                              validator:
                                  GrievanceValidators
                                      .mobileNumber,
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(
                      height: 20,
                    ),

                    // ==================================================
                    // GRIEVANCE DETAILS
                    // ==================================================

                    Semantics(
                      container: true,

                      label:
                          'Grievance details section',

                      child: _sectionCard(
                        title:
                            'Grievance Details',
                        subtitle:
                            'Describe the issue and select the relevant category.',
                        icon:
                            Icons.assignment_outlined,

                        child: Column(
                          children: [
                            // CATEGORY
                            Row(
                              crossAxisAlignment:
                                  CrossAxisAlignment
                                      .start,

                              children: [
                                Expanded(
                                  child:
                                      DropdownButtonFormField<
                                          String>(
                                    initialValue:
                                        _category,

                                    focusNode:
                                        _categoryFocus,

                                    autovalidateMode:
                                        _autovalidate
                                            ? AutovalidateMode
                                                .onUserInteraction
                                            : AutovalidateMode
                                                .disabled,

                                    style:
                                        const TextStyle(
                                      color:
                                          primaryText,
                                      fontSize:
                                          16,
                                      fontWeight:
                                          FontWeight
                                              .w500,
                                    ),

                                    dropdownColor:
                                        white,

                                    icon:
                                        const Icon(
                                      Icons
                                          .keyboard_arrow_down,
                                      color:
                                          secondaryText,
                                    ),

                                    decoration:
                                        _fieldDecoration(
                                      label:
                                          'Grievance Category',
                                      hint:
                                          'Select a category',
                                    ),

                                    items:
                                        _categories
                                            .map(
                                              (
                                                category,
                                              ) =>
                                                  DropdownMenuItem<
                                                      String>(
                                                value:
                                                    category,
                                                child:
                                                    Text(
                                                  category,
                                                ),
                                              ),
                                            )
                                            .toList(),

                                    onChanged:
                                        (value) {
                                      setState(() {
                                        _category =
                                            value;
                                      });

                                      if (value !=
                                          null) {
                                        _speak(
                                          'Grievance category selected: $value.',
                                        );
                                      }
                                    },

                                    validator:
                                        GrievanceValidators
                                            .category,
                                  ),
                                ),

                                const SizedBox(
                                  width: 12,
                                ),

                                Padding(
                                  padding:
                                      const EdgeInsets
                                          .only(
                                    top: 1,
                                  ),
                                  child:
                                      _islButton(
                                    label:
                                        'Grievance Category',
                                    videoPath:
                                        'assets/videos/category.mp4',
                                  ),
                                ),
                              ],
                            ),

                            const SizedBox(
                              height: 18,
                            ),

                            // DESCRIPTION
                            _accessibleTextField(
                              label:
                                  'Grievance Description',
                              hint:
                                  'Describe the issue, location, and any reference numbers.',

                              controller:
                                  _descriptionController,

                              focusNode:
                                  _descriptionFocus,

                              videoPath:
                                  'assets/videos/description.mp4',

                              minLines: 5,
                              maxLines: 7,

                              textInputAction:
                                  TextInputAction
                                      .newline,

                              validator:
                                  GrievanceValidators
                                      .description,
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(
                      height: 24,
                    ),

                    // ==================================================
                    // SUBMIT AREA
                    // ==================================================

                    Container(
                      padding:
                          const EdgeInsets
                              .all(20),

                      decoration:
                          BoxDecoration(
                        color: white,

                        borderRadius:
                            BorderRadius.circular(
                          16,
                        ),

                        border: Border.all(
                          color: border,
                        ),
                      ),

                      child: Row(
                        children: [
                          Container(
                            width: 44,
                            height: 44,

                            decoration:
                                BoxDecoration(
                              color:
                                  const Color(
                                0xFFF0FDF4,
                              ),
                              borderRadius:
                                  BorderRadius
                                      .circular(
                                12,
                              ),
                            ),

                            child:
                                const Icon(
                              Icons.verified_user_outlined,
                              color:
                                  successGreen,
                              size: 23,
                            ),
                          ),

                          const SizedBox(
                            width: 14,
                          ),

                          const Expanded(
                            child: Column(
                              crossAxisAlignment:
                                  CrossAxisAlignment
                                      .start,

                              children: [
                                Text(
                                  'Ready to submit?',
                                  style:
                                      TextStyle(
                                    color:
                                        primaryText,
                                    fontSize: 16,
                                    fontWeight:
                                        FontWeight
                                            .w700,
                                  ),
                                ),

                                SizedBox(
                                  height: 3,
                                ),

                                Text(
                                  'We will validate every required field before submission.',
                                  style:
                                      TextStyle(
                                    color:
                                        secondaryText,
                                    fontSize: 13,
                                    height:
                                        1.4,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(
                            width: 16,
                          ),

                          Semantics(
                            button: true,

                            label:
                                'Submit grievance',

                            hint:
                                'Submits the form. If information is missing, focus moves to the first field that needs attention.',

                            child:
                                ElevatedButton.icon(
                              onPressed:
                                  _handleSubmit,

                              style:
                                  ElevatedButton
                                      .styleFrom(
                                backgroundColor:
                                    primaryBlue,

                                foregroundColor:
                                    white,

                                elevation: 0,

                                minimumSize:
                                    const Size(
                                  190,
                                  52,
                                ),

                                padding:
                                    const EdgeInsets
                                        .symmetric(
                                  horizontal: 20,
                                  vertical: 14,
                                ),

                                shape:
                                    RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius
                                          .circular(
                                    10,
                                  ),
                                ),
                              ),

                              icon:
                                  const Icon(
                                Icons.send_outlined,
                                size: 19,
                              ),

                              label:
                                  const Text(
                                'Submit Grievance',
                                style:
                                    TextStyle(
                                  fontSize: 14,
                                  fontWeight:
                                      FontWeight
                                          .w700,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(
                      height: 24,
                    ),

                    // ==================================================
                    // ACCESSIBILITY GUIDANCE
                    // ==================================================

                    Semantics(
                      header: true,

                      child: const Text(
                        'Accessibility Guidance',
                        style:
                            TextStyle(
                          color: primaryText,
                          fontSize: 20,
                          fontWeight:
                              FontWeight.w700,
                        ),
                      ),
                    ),

                    const SizedBox(
                      height: 10,
                    ),

                    Container(
                      padding:
                          const EdgeInsets
                              .all(18),

                      decoration:
                          BoxDecoration(
                        color: lightBlue,

                        borderRadius:
                            BorderRadius.circular(
                          14,
                        ),

                        border: Border.all(
                          color:
                              primaryBlue
                                  .withValues(
                            alpha: 0.20,
                          ),
                        ),
                      ),

                      child: Row(
                        crossAxisAlignment:
                            CrossAxisAlignment
                                .start,

                        children: [
                          Container(
                            width: 44,
                            height: 44,

                            decoration:
                                BoxDecoration(
                              color: white,
                              borderRadius:
                                  BorderRadius
                                      .circular(
                                12,
                              ),
                            ),

                            child:
                                const Icon(
                              Icons.sign_language,
                              color:
                                  primaryBlue,
                              size: 24,
                            ),
                          ),

                          const SizedBox(
                            width: 14,
                          ),

                          const Expanded(
                            child: Column(
                              crossAxisAlignment:
                                  CrossAxisAlignment
                                      .start,

                              children: [
                                Text(
                                  'Indian Sign Language support',
                                  style:
                                      TextStyle(
                                    color:
                                        primaryText,
                                    fontSize: 15,
                                    fontWeight:
                                        FontWeight
                                            .w700,
                                  ),
                                ),

                                SizedBox(
                                  height: 4,
                                ),

                                Text(
                                  'Tap the hand icon beside a field to watch its Indian Sign Language (ISL) guidance video.',
                                  style:
                                      TextStyle(
                                    color:
                                        secondaryText,
                                    fontSize: 14,
                                    height:
                                        1.45,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(
                      height: 24,
                    ),

                    // ==================================================
                    // WHAT CHANGED
                    // ==================================================

                    _WhatChangedPanel(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // ============================================================
  // DISPOSE
  // ============================================================

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

    SpeechHelper.stop();

    super.dispose();
  }
}

// ================================================================
// REQUIRED LABEL
// ================================================================

class _RequiredLabel extends StatelessWidget {
  const _RequiredLabel({
    required this.text,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: text,
            style: const TextStyle(
              color: secondaryText,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),

          const TextSpan(
            text: ' ',
          ),

          const TextSpan(
            text: '•',
            style: TextStyle(
              color: errorRed,
              fontSize: 19,
              fontWeight: FontWeight.w900,
            ),
          ),
        ],
      ),
    );
  }
}

// ================================================================
// STRICT FULL NAME FORMATTER
// ================================================================

class _StrictFullNameFormatter
    extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    String filtered = newValue.text.replaceAll(
      RegExp(r'[^A-Za-z ]'),
      '',
    );

    filtered = filtered.replaceAll(
      RegExp(r' {2,}'),
      ' ',
    );

    if (filtered.startsWith(' ')) {
      filtered = filtered.substring(1);
    }

    return TextEditingValue(
      text: filtered,
      selection: TextSelection.collapsed(
        offset: filtered.length,
      ),
    );
  }
}

// ================================================================
// STRICT MOBILE FORMATTER
// ================================================================

class _StrictMobileFormatter
    extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    String filtered = newValue.text.replaceAll(
      RegExp(r'[^0-9]'),
      '',
    );

    if (filtered.length > 10) {
      filtered = filtered.substring(
        0,
        10,
      );
    }

    return TextEditingValue(
      text: filtered,
      selection: TextSelection.collapsed(
        offset: filtered.length,
      ),
    );
  }
}

// ================================================================
// EMAIL CHARACTER FORMATTER
// ================================================================

class _EmailCharactersFormatter
    extends TextInputFormatter {
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

    final atIndex = value.indexOf('@');

    if (atIndex != -1) {
      final beforeAt =
          value.substring(0, atIndex);

      String afterAt =
          value.substring(atIndex + 1);

      afterAt = afterAt.replaceAll(
        '@',
        '',
      );

      value =
          '$beforeAt@$afterAt';
    }

    return TextEditingValue(
      text: value,
      selection: TextSelection.collapsed(
        offset: value.length,
      ),
    );
  }
}

// ================================================================
// ISL VIDEO DIALOG
// ================================================================

class _IslVideoDialog
    extends StatefulWidget {
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
  late final VideoPlayerController
      _controller;

  @override
  void initState() {
    super.initState();

    _controller =
        VideoPlayerController.asset(
      widget.videoPath,
    )
          ..initialize().then((_) {
            if (mounted) {
              setState(() {});

              _controller.play();
            }
          });
  }

  @override
  void dispose() {
    _controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: white,

      shape: RoundedRectangleBorder(
        borderRadius:
            BorderRadius.circular(18),
      ),

      child: ConstrainedBox(
        constraints:
            const BoxConstraints(
          maxWidth: 650,
        ),

        child: Padding(
          padding:
              const EdgeInsets.all(20),

          child: Column(
            mainAxisSize:
                MainAxisSize.min,

            crossAxisAlignment:
                CrossAxisAlignment.start,

            children: [
              Row(
                children: [
                  Container(
                    width: 42,
                    height: 42,

                    decoration:
                        BoxDecoration(
                      color: lightBlue,
                      borderRadius:
                          BorderRadius.circular(
                        12,
                      ),
                    ),

                    child:
                        const Icon(
                      Icons.sign_language,
                      color:
                          primaryBlue,
                    ),
                  ),

                  const SizedBox(
                    width: 12,
                  ),

                  Expanded(
                    child: Text(
                      widget.title,
                      style:
                          const TextStyle(
                        color: primaryText,
                        fontSize: 18,
                        fontWeight:
                            FontWeight.w700,
                      ),
                    ),
                  ),

                  IconButton(
                    tooltip: 'Close',
                    onPressed: () {
                      Navigator.of(
                        context,
                      ).pop();
                    },
                    icon:
                        const Icon(
                      Icons.close,
                      color:
                          secondaryText,
                    ),
                  ),
                ],
              ),

              const SizedBox(
                height: 18,
              ),

              ClipRRect(
                borderRadius:
                    BorderRadius.circular(
                  12,
                ),

                child:
                    _controller.value
                            .isInitialized
                        ? AspectRatio(
                            aspectRatio:
                                _controller
                                    .value
                                    .aspectRatio,

                            child:
                                VideoPlayer(
                              _controller,
                            ),
                          )
                        : const SizedBox(
                            height: 280,

                            child:
                                Center(
                              child:
                                  CircularProgressIndicator(
                                color:
                                    primaryBlue,
                              ),
                            ),
                          ),
              ),

              const SizedBox(
                height: 16,
              ),

              Row(
                mainAxisAlignment:
                    MainAxisAlignment.end,

                children: [
                  OutlinedButton.icon(
                    onPressed: () {
                      setState(() {
                        if (_controller
                            .value
                            .isPlaying) {
                          _controller
                              .pause();
                        } else {
                          _controller
                              .play();
                        }
                      });
                    },

                    style:
                        OutlinedButton
                            .styleFrom(
                      foregroundColor:
                          primaryBlue,

                      side:
                          const BorderSide(
                        color:
                            primaryBlue,
                      ),

                      minimumSize:
                          const Size(
                        100,
                        44,
                      ),
                    ),

                    icon: Icon(
                      _controller
                              .value
                              .isPlaying
                          ? Icons.pause
                          : Icons.play_arrow,
                    ),

                    label: Text(
                      _controller
                              .value
                              .isPlaying
                          ? 'Pause'
                          : 'Play',
                    ),
                  ),

                  const SizedBox(
                    width: 10,
                  ),

                  FilledButton(
                    onPressed: () {
                      Navigator.of(
                        context,
                      ).pop();
                    },

                    style:
                        FilledButton
                            .styleFrom(
                      backgroundColor:
                          navy,

                      foregroundColor:
                          white,

                      minimumSize:
                          const Size(
                        90,
                        44,
                      ),
                    ),

                    child:
                        const Text(
                      'Close',
                    ),
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

// ================================================================
// WHAT CHANGED PANEL
// ================================================================

class _WhatChangedPanel
    extends StatelessWidget {
  const _WhatChangedPanel();

  static const List<String>
      changes = [
    'Semantic structure reconstructed',
    'Logical reading order restored',
    'Form errors made accessible',
    'Focus moved to invalid fields',
    'Screen-reader labels improved',
    'ISL video guidance added',
    'Automatic voice instructions added',
    'Category selection announced by voice',
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
          const EdgeInsets.all(22),

      decoration: BoxDecoration(
        color: white,

        borderRadius:
            BorderRadius.circular(16),

        border: Border.all(
          color: border,
        ),
      ),

      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,

        children: [
          Row(
            children: [
              Container(
                width: 42,
                height: 42,

                decoration:
                    BoxDecoration(
                  color:
                      const Color(
                    0xFFF0FDF4,
                  ),
                  borderRadius:
                      BorderRadius.circular(
                    12,
                  ),
                ),

                child: const Icon(
                  Icons.auto_awesome,
                  color: successGreen,
                  size: 22,
                ),
              ),

              const SizedBox(
                width: 12,
              ),

              const Expanded(
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment
                          .start,

                  children: [
                    Text(
                      'What changed?',
                      style:
                          TextStyle(
                        color:
                            primaryText,
                        fontSize: 18,
                        fontWeight:
                            FontWeight.w700,
                      ),
                    ),

                    SizedBox(
                      height: 3,
                    ),

                    Text(
                      'Accessibility improvements demonstrated by this prototype.',
                      style:
                          TextStyle(
                        color:
                            secondaryText,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(
            height: 18,
          ),

          Wrap(
            spacing: 10,
            runSpacing: 10,

            children:
                changes.map(
              (text) {
                return Container(
                  padding:
                      const EdgeInsets
                          .symmetric(
                    horizontal: 12,
                    vertical: 9,
                  ),

                  decoration:
                      BoxDecoration(
                    color: background,

                    borderRadius:
                        BorderRadius.circular(
                      10,
                    ),

                    border: Border.all(
                      color: border,
                    ),
                  ),

                  child: Row(
                    mainAxisSize:
                        MainAxisSize.min,

                    children: [
                      const Icon(
                        Icons.check_circle,
                        color:
                            successGreen,
                        size: 17,
                      ),

                      const SizedBox(
                        width: 7,
                      ),

                      Text(
                        text,
                        style:
                            const TextStyle(
                          color:
                              primaryText,
                          fontSize: 13,
                          fontWeight:
                              FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ).toList(),
          ),
        ],
      ),
    );
  }
}