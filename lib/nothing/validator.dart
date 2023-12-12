// String? Function(String?)? validator

String? doubleValidator(String? value) {
  if (value == null || value.isEmpty) {
    return "Datatype: Double";
  } else {
    var toCheckDouble = double.tryParse(value);

    return toCheckDouble == null ? "Invalid value" : null;
  }
}
