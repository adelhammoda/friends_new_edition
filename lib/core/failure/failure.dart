import 'package:equatable/equatable.dart';
import 'package:friends/core/manager/status_code_manager.dart';
import 'package:friends/core/manager/string_manager.dart';

abstract class Failure extends Equatable {
  final int statusCode;
  final String message;

  const Failure({required this.message, required this.statusCode});

  @override
  List<Object> get props => [message, statusCode];
}

class FirebaseFailure extends Failure {
  const FirebaseFailure(
      {super.message = StringManager.unknownErrorMessage,
      super.statusCode = StatusCode.firebase});
}

class CashFailure extends Failure {
  const CashFailure(
      {super.message = StringManager.cashErrorMessage,
      super.statusCode = StatusCode.cash});
}

class UnKnownFailure extends Failure {
  const UnKnownFailure(
      {super.message = StringManager.unknownErrorMessage,
      super.statusCode = StatusCode.unknown});
}

class NavigationFailure extends Failure {
  const NavigationFailure(
      {super.message = StringManager.navigatorErrorMessage,
      super.statusCode = StatusCode.navigation});
}

class NetworkFailure extends Failure {
  const NetworkFailure(
      {super.message = StringManager.networkErrorMessage,
      super.statusCode = StatusCode.network});
}

class DeviceInfoFailure extends Failure {
  const DeviceInfoFailure(
      {super.message = StringManager.deviceInfoErrorMessage,
      super.statusCode = StatusCode.deviceInfo});
}

class CreateUserFailure extends Failure {
  const CreateUserFailure({required super.message, required super.statusCode});
}

class BadFormatFailure extends Failure {
  const BadFormatFailure(
      {required super.message, super.statusCode = StatusCode.badFormat});
}

class NoDataFailure extends Failure {
  const NoDataFailure(
      {super.message = StringManager.noDataErrorMessage,
      super.statusCode = StatusCode.noData});
}

class LocalStoringFailure extends Failure {
  const LocalStoringFailure(
      {super.message = StringManager.localStoringErrorMessage,
      super.statusCode = StatusCode.localStorage});
}

class AutoLoginFailure extends Failure {
  const AutoLoginFailure({required super.message, required super.statusCode});
}

class UserNotFoundInLocalStorageFailure extends Failure {
  const UserNotFoundInLocalStorageFailure(
      {required super.message, required super.statusCode});
}

class ThisUserIsNotStudentFailure extends Failure {
  const ThisUserIsNotStudentFailure(
      {super.message = StringManager.thisUserIsNotStudent,
        super.statusCode = StatusCode.userIsNotStudent});
}
class PermissionDeniedFailure extends Failure {
  const PermissionDeniedFailure(
      {required super.message ,
        super.statusCode = StatusCode.permissions});
}

class NoAuthenticationFoundFailure extends Failure{
  const NoAuthenticationFoundFailure(
      {required super.message ,
        super.statusCode = StatusCode.authentication}
      );
}


///enum class of failure type : warning or error.
enum FailureType{
  warning , error
}


