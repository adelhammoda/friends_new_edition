abstract class ExceptionBase implements Exception {
  String message;
  int code;

  ExceptionBase(this.message, this.code);
}

class CashException extends ExceptionBase {
  //TODO: pass const string from string manager with error message.
  CashException({
    String message = 'Cash Error happened',
    int code = 5,
  }) : super(message, code);
}

class NetworkException extends ExceptionBase {
  NetworkException(
      {String message =
          'There is some problem in your network. check that you are online then try again',
      int code = 10})
      : super(message, code);
}
