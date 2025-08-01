class Validation {
  static String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Name is required';
    }
    if (value.length < 2) {
      return 'Name must be at least 2 characters';
    }
    return null;
  }

  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }
    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
      return 'Invalid email format';
    }
    return null;
  }

  static String? validatePhone(String? value) {
    if (value == null || value.isEmpty) {
      return 'Phone number is required';
    }
    if (!RegExp(r'^\d{10}$').hasMatch(value)) {
      return 'Phone number must be 10 digits';
    }
    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters';
    }
    return null;
  }

  static String? validateConfirmPassword(String? password, String? confirmPassword) {
    if (confirmPassword == null || confirmPassword.isEmpty) {
      return 'Confirm password is required';
    }
    if (confirmPassword != password) {
      return 'Passwords do not match';
    }
    return null;
  }

  static String? validateRent(String? value) {
    if (value == null || value.isEmpty) {
      return 'Rent is required';
    }
    final rent = double.tryParse(value);
    if (rent == null || rent <= 0) {
      return 'Please enter a valid rent amount';
    }
    return null;
  }

  static String? validateDescription(String? value) {
    if (value == null || value.isEmpty) {
      return 'Description is required';
    }
    if (value.length < 10) {
      return 'Description must be at least 10 characters';
    }
    return null;
  }

  static Map<String, String?> validateHostelForm({
    required String? name,
    String? rent, // Changed to nullable
    required String? contact,
    required String? description,
    required List<String> facilities,
    required bool locationLoaded,
  }) {
    return {
      'name': validateName(name),
      'rent': rent != null ? validateRent(rent) : null, // Only validate if rent is provided
      'contact': validatePhone(contact),
      'description': validateDescription(description),
      'facilities': facilities.isEmpty ? 'At least one facility is required' : null,
      'location': locationLoaded ? null : 'Please select a location',
    };
  }
}