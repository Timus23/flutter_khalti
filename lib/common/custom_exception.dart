class KhaltiCustomException implements Exception {
  KhaltiCustomException([this._message, this._prefix]);

  final dynamic _message;
  final dynamic _prefix;

  dynamic get message => _message;
  String toString() {
    return "$_prefix$_message";
  }
}

class KhaltiException extends KhaltiCustomException {
  KhaltiException([String? message]) : super(message, "Something went wrong!!");
}
