class GrievanceValidators {
  // ============================================================
  // FULL NAME
  // ============================================================

  static String? fullName(String? value) {
    final text = value?.trim() ?? '';

    if (text.isEmpty) {
      return 'Full Name is required.';
    }

    if (text.length < 3) {
      return 'Full Name must contain at least 3 characters.';
    }

    // Letters and single spaces only.
    final validName = RegExp(
      r'^[A-Za-z]+(?: [A-Za-z]+)*$',
    );

    if (!validName.hasMatch(text)) {
      return 'Full Name can contain only letters and spaces.';
    }

    return null;
  }

  // ============================================================
  // EMAIL
  // ============================================================

  static String? email(String? value) {
    final text = value?.trim() ?? '';

    if (text.isEmpty) {
      return 'Email Address is required.';
    }

    // No spaces.
    if (text.contains(RegExp(r'\s'))) {
      return 'Email Address cannot contain spaces.';
    }

    // Exactly one @.
    if ('@'.allMatches(text).length != 1) {
      return 'Enter a valid email address with one @ symbol.';
    }

    final parts = text.split('@');

    if (parts.length != 2) {
      return 'Enter a valid email address.';
    }

    final username = parts[0];
    final domain = parts[1].toLowerCase();

    if (username.isEmpty) {
      return 'Enter the email username before @.';
    }

    if (domain.isEmpty) {
      return 'Enter a valid email domain.';
    }

    // No consecutive dots.
    if (username.contains('..')) {
      return 'Email username cannot contain consecutive dots.';
    }

    if (domain.contains('..')) {
      return 'Email domain cannot contain consecutive dots.';
    }

    // Username cannot start or end with a dot.
    if (username.startsWith('.') || username.endsWith('.')) {
      return 'Email username cannot start or end with a dot.';
    }

    // Allowed username characters.
    final usernameRegex = RegExp(
      r'^[A-Za-z0-9](?:[A-Za-z0-9._%+-]*[A-Za-z0-9])?$',
    );

    if (!usernameRegex.hasMatch(username)) {
      return 'Enter a valid email username.';
    }

    // ------------------------------------------------------------
    // ONLY ALLOWED DOMAINS
    // ------------------------------------------------------------

    const allowedDomains = {
      'gmail.com',
      'yahoo.com',
      'mhssce.ac.in',
    };

    if (!allowedDomains.contains(domain)) {
      return 'Use @gmail.com, @yahoo.com, or @mhssce.ac.in.';
    }

    // ------------------------------------------------------------
    // FINAL EMAIL FORMAT CHECK
    // ------------------------------------------------------------

    final emailRegex = RegExp(
      r'^[A-Za-z0-9](?:[A-Za-z0-9._%+-]*[A-Za-z0-9])?@[A-Za-z0-9-]+(?:\.[A-Za-z0-9-]+)+$',
    );

    if (!emailRegex.hasMatch(text)) {
      return 'Enter a valid email address.';
    }

    return null;
  }

  // ============================================================
  // MOBILE NUMBER
  // ============================================================

  static String? mobileNumber(String? value) {
    final text = value?.trim() ?? '';

    if (text.isEmpty) {
      return 'Mobile Number is required.';
    }

    // Indian 10-digit mobile number.
    // Must start with 6, 7, 8 or 9.
    final mobileRegex = RegExp(
      r'^[6-9][0-9]{9}$',
    );

    if (!mobileRegex.hasMatch(text)) {
      return 'Enter a valid 10 digit mobile number starting with 6, 7, 8, or 9.';
    }

    return null;
  }

  // ============================================================
  // CATEGORY
  // ============================================================

  static String? category(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Grievance Category is required.';
    }

    return null;
  }

  // ============================================================
  // DESCRIPTION
  // ============================================================

  static String? description(String? value) {
    final text = value?.trim() ?? '';

    if (text.isEmpty) {
      return 'Grievance Description is required.';
    }

    if (text.length < 10) {
      return 'Grievance Description must contain at least 10 characters.';
    }

    return null;
  }
}