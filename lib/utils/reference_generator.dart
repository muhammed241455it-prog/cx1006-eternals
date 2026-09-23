class ReferenceGenerator {
  ReferenceGenerator._();

  /// Generates a simple, locally-created reference number.
  /// No backend is required for this proof-of-concept.
  static String generate() {
    final now = DateTime.now();
    final datePart = '${now.year}${_pad(now.month)}${_pad(now.day)}';
    final timePart =
        '${_pad(now.hour)}${_pad(now.minute)}${_pad(now.second)}';
    return 'CX1006-$datePart-$timePart';
  }

  static String _pad(int value) => value.toString().padLeft(2, '0');
}