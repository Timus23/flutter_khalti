class CustomException implements Exception {
  CustomException([this._message, this._prefix]);

  final dynamic _message;
  final dynamic _prefix;

  dynamic get message => _message;
  String toString() {
    return "$_prefix$_message";
  }
}

class KhaltiException extends CustomException {
  KhaltiException([String? message]) : super(message, "Something went wrong!!");
}
