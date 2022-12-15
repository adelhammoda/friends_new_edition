import 'package:friends/core/manager/status_code_manager.dart';
import 'package:friends/core/manager/string_manager.dart';

abstract class ExceptionBase implements Exception {
  String message;
  int code;

  ExceptionBase(this.message, this.code);
}

class CashException extends ExceptionBase {
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


class NoDataException extends ExceptionBase {
  NoDataException({
    String message = StringManager.noDataErrorMessage,
    int code = StatusCode.noData
  }) :super(message, code);
}

class AutoLoginException extends ExceptionBase{
  AutoLoginException({
    String message = StringManager.autoLoginErrorMessage,
    int code = StatusCode.autoLogin
  }):super(message,code);

}


class UserNotFoundException extends ExceptionBase{
  UserNotFoundException({
    String message = StringManager.userNotFoundErrorMessage,
    int code = StatusCode.userNotFound
  }):super(message,code);
}

class UserNotFoundInLocalStorageException extends ExceptionBase{
  UserNotFoundInLocalStorageException({
    String message = StringManager.noUserInLocalStorage,
    int code = StatusCode.localStorage
  }):super(message,code);
}


class FetchSubscriptionException extends ExceptionBase{
  FetchSubscriptionException({
    String message = StringManager.fetchSubscriptionException,
    int code = StatusCode.firebase
  }):super(message,code);
}


class ThisUserIsNotStudentException extends ExceptionBase{
  ThisUserIsNotStudentException({
    String message = StringManager.thisUserIsNotStudent,
    int code = StatusCode.firebase
  }):super(message,code);
}


class PermissionDeniedException extends ExceptionBase{
  PermissionDeniedException({
    String message = StringManager.dontHavePermissions,
    int code = StatusCode.permissions
  }):super(message,code);
}

class CloseCameraException extends ExceptionBase{
  CloseCameraException({
    String message = StringManager.cannotOpenCameraErrorMessage,
    int code = StatusCode.camera
  }):super(message,code);
}
class OpenCameraException extends ExceptionBase{
  OpenCameraException({
    String message = StringManager.cannotCloseCameraErrorMessage,
    int code = StatusCode.camera
  }):super(message,code);
}
