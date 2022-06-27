class TokenInvalidException implements Exception {
  String errMsg() => 'Invalid token';
}

class UserNotFoundException implements Exception {
  String errMsg() => 'User not found';
}
