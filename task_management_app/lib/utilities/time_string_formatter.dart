String trimIso8601String(String iso8601String) {
  if (iso8601String == "") {
    return iso8601String;
  }
  return iso8601String.substring(0, 10);
}
