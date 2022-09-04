import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final int statusCode;
  final String message;

  const Failure({required this.message, required this.statusCode});

  @override
  List<Object> get props => [message, statusCode];
}

class FirebaseFailure extends Failure {
  const FirebaseFailure({required super.message, required super.statusCode});
}

class CashFailure extends Failure {
  const CashFailure({required super.message, required super.statusCode});
}

class UnKnownFailure extends Failure {
  const UnKnownFailure({required super.message, required super.statusCode});
}

class NavigationFailure extends Failure{
 const NavigationFailure({required super.message, required super.statusCode});

}

class NetworkFailure extends Failure{
 const  NetworkFailure({required super.message, required super.statusCode});


}
