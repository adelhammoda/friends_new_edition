part of 'qr_generator_bloc.dart';

abstract class QrGeneratorEvent extends Equatable {
  const QrGeneratorEvent();
}


class GenerateQREvent extends QrGeneratorEvent{
  final BuildContext context;
  final HomepageBloc bloc;

  const GenerateQREvent({required this.context,required this.bloc});
  @override
  List<Object?> get props => [context,bloc];
}

class HideQrEvent extends QrGeneratorEvent{

  @override
  List<Object?> get props => [];
}