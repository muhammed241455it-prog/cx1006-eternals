import 'package:flutter/widgets.dart';

/// Represents a single invalid form field and the message
/// used to explain the problem accessibly.
class FieldError {
  const FieldError({
    required this.focusNode,
    required this.summary,
  });

  final FocusNode focusNode;
  final String summary;
}