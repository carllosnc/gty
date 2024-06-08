class GtyException implements Exception {
  final String message;
  final int statusCode;
  final dynamic description;

  GtyException({
    required this.message,
    required this.statusCode,
    required this.description,
  });
}
