import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String statusCode;
  final String message;

  const Failure({required this.message, required this.statusCode});

  @override
  List<Object> get props => [message, statusCode];
}

class FirebaseFailure extends Failure {
  const FirebaseFailure({required super.message, required super.statusCode});
}

class CashFailure extends Failure{
  const CashFailure({required super.message, required super.statusCode});
}


