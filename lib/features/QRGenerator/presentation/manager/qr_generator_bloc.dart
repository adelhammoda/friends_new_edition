import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:friends/core/failure/failure.dart';
import 'package:friends/features/QRGenerator/domain/use_cases/generate_qr_code.dart';
import 'package:friends/features/home_page/presentation/manager/homepage_bloc.dart';
import 'package:qr_flutter/qr_flutter.dart';

part 'qr_generator_event.dart';

part 'qr_generator_state.dart';

class QrGeneratorBloc extends Bloc<QrGeneratorEvent, QrGeneratorState> {
  final GenerateQRCodeUseCase generateQrCode;


  QrGeneratorBloc(
      {required this.generateQrCode,})
      : super(QrGeneratorInitial()) {
    on<QrGeneratorEvent>((event, emit) async {
      switch (event.runtimeType) {
        case GenerateQREvent:
          {
            final generateEvent = event as GenerateQREvent;
            emit(LoadingQrGeneratorState());
            final Either<Failure, QrImage> generateRes = await generateQrCode(
                context: generateEvent.context,
                homeBlocProvider: generateEvent.bloc);
            generateRes.fold((failure) {
              emit(ErrorQrGeneratorState(failure));
            }, (qrImage) =>
                emit(LoadedQrGeneratorState(qrImage: qrImage)));
            break;
          }case HideQrEvent:
            emit(QrGeneratorInitial());
            break;
            default:
            emit(QrGeneratorInitial());
      }
    });
  }
}
