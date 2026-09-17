class GrievanceValidators {
  GrievanceValidators._();

  static String? fullName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Full name is required.';
    }
    if (value.trim().length < 3) {
      return 'Please enter your full name.';
    }
    return null;
  }

  static String? email(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Email address is required.';
    }
    final emailPattern = RegExp(r'^[\w.\-]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailPattern.hasMatch(value.trim())) {
      return 'Please enter a valid email address.';
    }
    return null;
  }

  static String? mobileNumber(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Mobile number is required.';
    }
    final mobilePattern = RegExp(r'^[6-9]\d{9}$');
    if (!mobilePattern.hasMatch(value.trim())) {
      return 'Please enter a valid 10-digit mobile number.';
    }
    return null;
  }

  static String? category(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please select a grievance category.';
    }
    return null;
  }

  static String? description(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please describe your grievance.';
    }
    if (value.trim().length < 15) {
      return 'Please provide a few more details (at least 15 characters).';
    }
    return null;
  }
}