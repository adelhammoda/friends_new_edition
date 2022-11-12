part of 'qr_generator_bloc.dart';

abstract class QrGeneratorState extends Equatable {
  const QrGeneratorState();
}

class QrGeneratorInitial extends QrGeneratorState {
  @override
  List<Object> get props => [];
}

class LoadingQrGeneratorState extends QrGeneratorState{
  @override
  List<Object?> get props => [];
}

class LoadedQrGeneratorState extends QrGeneratorState{
  final QrImage qrImage;

  const LoadedQrGeneratorState({required this.qrImage});
  @override
  List<Object?> get props => [qrImage];
}

class ErrorQrGeneratorState extends QrGeneratorState{
  final Failure failure;

  const ErrorQrGeneratorState(this.failure);
  @override
  List<Object?> get props => [failure];
}

