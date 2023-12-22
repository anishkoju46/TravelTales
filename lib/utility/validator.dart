String? validate(String? value) {
  if (value != null && value.isNotEmpty) return null;
  return "Field Cannot be empty";
}
