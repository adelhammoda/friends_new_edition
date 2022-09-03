import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  String statusCode;
  String message;

  Failure({required this.message, required this.statusCode});

  @override
  List<Object> get props => [message, statusCode];
}
