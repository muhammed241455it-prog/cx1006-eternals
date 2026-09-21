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

    final nameRegex = RegExp(
      r'^[A-Za-z]+(?: [A-Za-z]+)*$',
    );

    if (!nameRegex.hasMatch(text)) {
      return 'Full Name can contain only letters and spaces.';
    }

    return null;
  }

  // ============================================================
  // EMAIL ADDRESS
  // ============================================================

  static String? email(String? value) {
    final text = value?.trim() ?? '';

    // Required
    if (text.isEmpty) {
      return 'Email Address is required.';
    }

    // No spaces
    if (text.contains(RegExp(r'\s'))) {
      return 'Email Address cannot contain spaces.';
    }

    // Maximum standard email length
    if (text.length > 254) {
      return 'Email Address is too long.';
    }

    // Exactly one @ symbol
    final atCount = '@'.allMatches(text).length;

    if (atCount == 0) {
      return 'Email Address must contain @.';
    }

    if (atCount > 1) {
      return 'Email Address can contain only one @ symbol.';
    }

    // Split username and domain
    final parts = text.split('@');

    if (parts.length != 2) {
      return 'Enter a valid email address.';
    }

    final username = parts[0];
    final domain = parts[1].toLowerCase();

    // ==========================================================
    // USERNAME
    // ==========================================================

    if (username.isEmpty) {
      return 'Enter the email username before @.';
    }

    if (username.length > 64) {
      return 'Email username is too long.';
    }

    if (username.startsWith('.')) {
      return 'Email username cannot start with a dot.';
    }

    if (username.endsWith('.')) {
      return 'Email username cannot end with a dot.';
    }

    if (username.contains('..')) {
      return 'Email username cannot contain consecutive dots.';
    }

    // General allowed email username characters.
    final usernameRegex = RegExp(
      r'^[A-Za-z0-9](?:[A-Za-z0-9._%+\-]*[A-Za-z0-9])?$',
    );

    if (!usernameRegex.hasMatch(username)) {
      return 'Enter a valid email username.';
    }

    // ==========================================================
    // DOMAIN
    // ==========================================================

    if (domain.isEmpty) {
      return 'Enter the email domain after @.';
    }

    if (domain.startsWith('.')) {
      return 'Email domain cannot start with a dot.';
    }

    if (domain.endsWith('.')) {
      return 'Email domain cannot end with a dot.';
    }

    if (domain.contains('..')) {
      return 'Email domain cannot contain consecutive dots.';
    }

    // Only letters, numbers, dots and hyphens.
    final domainRegex = RegExp(
      r'^[A-Za-z0-9](?:[A-Za-z0-9.-]*[A-Za-z0-9])?$',
    );

    if (!domainRegex.hasMatch(domain)) {
      return 'Enter a valid email domain.';
    }

    // ==========================================================
    // ONLY ALLOWED DOMAINS
    // ==========================================================

    const allowedDomains = <String>{
      'gmail.com',
      'yahoo.com',
      'mhssce.ac.in',
    };

    if (!allowedDomains.contains(domain)) {
      return 'Use only @gmail.com, @yahoo.com, or @mhssce.ac.in.';
    }

    // ==========================================================
    // GMAIL
    // ==========================================================

    if (domain == 'gmail.com') {
      final gmailRegex = RegExp(
        r'^[A-Za-z0-9]+(?:\.[A-Za-z0-9]+)*$',
      );

      if (!gmailRegex.hasMatch(username)) {
        return 'Enter a valid Gmail address.';
      }

      return null;
    }

    // ==========================================================
    // YAHOO
    // ==========================================================

    if (domain == 'yahoo.com') {
      final yahooRegex = RegExp(
        r'^[A-Za-z0-9]+(?:[._-][A-Za-z0-9]+)*$',
      );

      if (!yahooRegex.hasMatch(username)) {
        return 'Enter a valid Yahoo email address.';
      }

      return null;
    }

    // ==========================================================
    // MHSSCE COLLEGE EMAIL
    // ==========================================================

    if (domain == 'mhssce.ac.in') {
      final collegeRegex = RegExp(
        r'^[A-Za-z0-9]+(?:[._+-][A-Za-z0-9]+)*$',
      );

      if (!collegeRegex.hasMatch(username)) {
        return 'Enter a valid college email address.';
      }

      return null;
    }

    return 'Enter a valid email address.';
  }

  // ============================================================
  // MOBILE NUMBER
  // ============================================================

  static String? mobileNumber(String? value) {
    final text = value?.trim() ?? '';

    if (text.isEmpty) {
      return 'Mobile Number is required.';
    }

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