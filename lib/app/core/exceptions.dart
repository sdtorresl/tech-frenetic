class TokenInvalidException implements Exception {
  String errMsg() => 'Invalid token';
}

class UserNotFoundException implements Exception {
  String errMsg() => 'User not found';
}

class UserExistsException implements Exception {
  String errMsg() => 'User already exists';
}

class BadRequestException implements Exception {
  String errMsg() => 'Invalid data';
}

class InvalidCodeException implements Exception {
  String errMsg() => 'Invalid code';
}

class ServerException implements Exception {
  String errMsg() => 'Server exception';
}
