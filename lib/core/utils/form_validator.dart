String? validator(String? value, {String fieldName = "This field"}) {
  if (value == null || value.trim().isEmpty) {
    return "$fieldName cannot be empty";
  }
  return null; 
}