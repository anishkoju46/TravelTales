String? validate(String? value) {
  if (value != null && value.isNotEmpty) return null;
  return "Field Cannot be empty";
}

String? fullNameValidator(String? value) {
  // Check if the value is null or empty
  if (value == null || value.trim().isEmpty) {
    return "Full name cannot be empty";
  }

  // Check if the full name consists of at least two separate names
  // List<String> names = value.split(' ');
  // if (names.length < 2) {
  //   return "Full name should consist of at least two separate names";
  // }
  // Return null if the full name is valid
  if (value.length >= 30) {
    return "Please enter your name again";
  }
  return null;
}

String? emailValidator(String? value) {
  // Checking if the value is null or empty
  if (value == null || value.trim().isEmpty) {
    return "Email cannot be empty";
  }

  // Regular expression to validate email format
  final emailRegex = RegExp(
    r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
    caseSensitive: false,
    multiLine: false,
  );

  // Check if the value matches the email format
  if (!emailRegex.hasMatch(value)) {
    return "Invalid email format";
  }

  // Return null if the email is valid
  return null;
}

String? phoneNumberValidator(String? value) {
  // Check if the value is null or empty
  if (value == null || value.trim().isEmpty) {
    return "Phone number cannot be empty";
  }

  // Regular expression to validate phone number format
  final phoneRegex = RegExp(
    r'^98\d{8}$', // Assuming a 10-digit numeric wala phone number
    caseSensitive: false,
    multiLine: false,
  );

  // Check if the value matches the phone number format
  if (!phoneRegex.hasMatch(value)) {
    return "Invalid phone number format";
  }

  // Return null if the phone number is valid
  return null;
}

String? passwordValidator(String? value) {
  // Check if the value is null or empty
  if (value == null || value.trim().isEmpty) {
    return "Password cannot be empty";
  }

  // Check if the password meets the minimum length requirement
  if (value.length < 8 || value.length > 11) {
    return "Password must be at least 8 characters long";
  }

  // Check if the password contains at least one uppercase letter
  if (!value.contains(RegExp(r'[A-Z]'))) {
    return "Password must contain at least one uppercase letter";
  }

  // if (!value.contains(RegExp(r'[0-9]'))) {
  //   return "Password must contain at least one numeric character";
  // }
  // Check if the password contains at least one special character
  if (!value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
    return "Password must contain at least one special character";
  }

  // Return null if the password is valid
  return null;
}

//==============================================================================
// For destination ko

String? longitudeValidate(String? value) {
  // Check if the value is null or empty
  if (value == null || value.trim().isEmpty) {
    return "Longitude cannot be empty";
  }

  // Regular expression to validate longitude format (decimal)
  // final regex = RegExp(r'^-?([1-8]?[1-9]|[1-9]0)\.\d{1,20}$');
  final regex =
      RegExp(r'^-?((([1-9]|[1-9]\d|1[0-7]\d)(\.\d{1,20})?)|180(\.0{1,20})?)$');

  // Check if the value matches the longitude format
  if (!regex.hasMatch(value)) {
    return "Incorrect Longtitude Coordinates";
  }

  // Parse the value as a double to further validate its range
  final doubleValue = double.tryParse(value);

  // Check if the parsed value is within the valid range
  if (doubleValue == null || doubleValue < -180 || doubleValue > 180) {
    return "Longitude must be between -180 and 180 degrees.";
  }

  // Return null if the longitude is valid
  return null;
}

String? latitudeValidate(String? value) {
  // Check if the value is null or empty
  if (value == null || value.trim().isEmpty) {
    return "Latitude cannot be empty";
  }

  // Regular expression to validate latitude format (decimal)
  final regex = RegExp(r'^-?([1-8]?[1-9]|[1-9]0)\.\d{1,20}$');

  //final regex = RegExp(r'^-?([1-8]?[1-9]|[1-9]0)\.\d{1,20}$');
  // final regex = RegExp(r'^-?([0-8]?[0-9]|90)\.\d{1,20}$');

  // Check if the value matches the latitude format
  if (!regex.hasMatch(value)) {
    return "Incorrect Latitude Coordinates";
  }

  // Parse the value as a double to further validate its range
  final doubleValue = double.tryParse(value);

  // Check if the parsed value is within the valid range
  if (doubleValue == null || doubleValue < -90 || doubleValue > 90) {
    return "Latitude must be between -90 and 90 degrees.";
  }

  // Return null if the latitude is valid
  return null;
}

String? descriptionValidate(String? value) {
  // Check if the value is null or empty
  if (value == null || value.trim().isEmpty) {
    return "Description cannot be empty";
  }

  // Split the description into words
  List<String> words = value.trim().split(' ');

  // Count the number of words
  int wordCount = words.length;

  // Check if the description contains more than 30 words
  if (wordCount <= 2) {
    return "Description must contain more than 2 words.";
  }

  // Return null if the description is valid
  return null;
}

String? destinationNameValidator(String? value) {
  // Check if the value is null or empty
  if (value == null || value.trim().isEmpty) {
    return "Destination Name cannot be empty";
  }

  if (value.length > 40) {
    return "Shorten the destination name";
  }

  // Return null if the description is valid
  return null;
}

String? imageValidator(String? value) {
  if (value == null || value.isEmpty) {
    return "Please enter an image URL";
  }
  return null;
}

String? regionValidator(String? value) {
  if (value == null || value.trim().isEmpty) {
    return "Please enter a region";
  }
  // Add more validation logic if needed
  return null;
}

String? durationValidator(String? value) {
  if (value == null || value.trim().isEmpty) {
    return "Please enter duration";
  }
  // Add more validation logic if needed
  return null;
}

String? maxHeightValidator(String? value) {
  if (value == null || value.trim().isEmpty) {
    return "Please enter height";
  }
  // Add more validation logic if needed
  return null;
}

String? bestSeasonValidator(String? value) {
  if (value == null || value.trim().isEmpty) {
    return "Please enter best season";
  }
  // Add more validation logic if needed
  return null;
}

String? itineraryValidator(String? value) {
  if (value == null || value.trim().isEmpty) {
    return "Please enter itinerary";
  }
  // Add more validation logic if needed
  return null;
}

//===================================
//Review validator

String? reviewValidator(String? value) {
  if (value == null || value.trim().isEmpty) {
    return "Please enter a review";
  }
  List<String> words = value.trim().split(' ');

  // Count the number of words
  int wordCount = words.length;

  if (wordCount > 100) {
    return "Very long review";
  }

  // Return null if the description is valid
  return null;
}

 // validator: (value) {
//   if (value == null || value.isEmpty) {
//     return 'Please enter an email';
//   } else if (!RegExp(
//           r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$')
//       .hasMatch(value)) {
//     return 'Invalid Email';
//   }
//   return null;
// },