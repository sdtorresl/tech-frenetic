class TokenInvalidException implements Exception {
  String errMsg() => 'Invalid token';
}

class UserNotFound implements Exception {
  String errMsg() => 'User not found';
}
