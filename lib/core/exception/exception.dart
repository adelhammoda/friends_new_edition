

abstract class ExceptionBase implements Exception{
  String message;
  int code;
  ExceptionBase(this.message,this.code);
}


class CashException extends ExceptionBase{
  //TODO: pass const string from string manager with error message.
  CashException({
    String defaultMessage = 'Cash Error happened',
    int defaultCode = 5,
}):super(defaultMessage,defaultCode);
}


