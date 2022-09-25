import 'package:friends/core/manager/status_code_manager.dart';
import 'package:friends/core/manager/string_manager.dart';

abstract class ExceptionBase implements Exception {
  String message;
  int code;

  ExceptionBase(this.message, this.code);
}

class CashException extends ExceptionBase {
  //TODO: pass const string from string manager with error message.
  CashException({
    String message = StringManager.cashErrorMessage,
    int code = StatusCode.cash,
  }) : super(message, code);
}

class NetworkException extends ExceptionBase {
  NetworkException(
      {String message =
          StringManager.networkErrorMessage,
      int code = StatusCode.network})
      : super(message, code);
}

class CreateUserException extends ExceptionBase{
  CreateUserException({
    String message = StringManager.createUserErrorMessage,
    int code = StatusCode.createUser
}):super(message,code);
}


class DeviceInfoException extends ExceptionBase{
  DeviceInfoException({
    String message = StringManager.deviceInfoErrorMessage,
    int code = StatusCode.deviceInfo
  }):super(message,code);
}

class BadFormatException extends ExceptionBase{
  BadFormatException({
    String message = StringManager.badFormatErrorMessage,
    int code = StatusCode.badFormat
  }):super(message,code);

}


class NoDataException extends ExceptionBase{
  NoDataException({
    String message = StringManager.noDataErrorMessage,
    int code = StatusCode.noData
  }):super(message,code);

}