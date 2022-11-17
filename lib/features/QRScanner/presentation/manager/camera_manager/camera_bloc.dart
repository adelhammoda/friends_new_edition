import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:friends/core/extension/string_extension.dart';
import 'package:friends/core/failure/failure.dart';
import 'package:friends/features/QRScanner/data/data_sources/qr_scanner_local_data_source.dart';
import 'package:friends/features/QRScanner/domain/use_cases/close_camera_use_case.dart';
import 'package:friends/features/QRScanner/domain/use_cases/navigate_to_user_details_page_use_case.dart';
import 'package:friends/features/QRScanner/domain/use_cases/open_camera_use_case.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:friends/injection_container.dart' as dl;

part 'camera_event.dart';

part 'camera_state.dart';

class CameraBloc extends Bloc<CameraEvent, CameraState> {
  final OpenCameraUseCase openCameraUseCase;
  final CloseCameraUseCase closeCameraUseCase;
  final NavigateToUserDetailsPageUseCase navigateToUserDetailsPageUseCase;

  CameraBloc(
      {required this.openCameraUseCase,
      required this.closeCameraUseCase,
      required this.navigateToUserDetailsPageUseCase})
      : super(CameraInitial()) {
    on<CameraEvent>((event, emit) async {
      switch (event.runtimeType) {
        case OpenCameraEvent:
          {
            final Either<Failure, void> res = await openCameraUseCase();
            res.fold((failure) => emit(CameraErrorState(failure: failure)),
                (r) =>
                    emit(CameraOpened())
            );
            break;
          }
        case CloseCameraEvent:
          {
            final Either<Failure, void> res = await closeCameraUseCase();
            res.fold((failure) => emit(CameraErrorState(failure: failure)),
                (r) => emit(CameraClosed()));
            break;
          }
        case NavigateToUserDetailsEvent:
          {
            if((event as NavigateToUserDetailsEvent).userId.isNullOrEmpty()){
              emit(const CameraErrorState(failure: NavigationFailure()));
            }
            final Either<Failure, void> res = navigateToUserDetailsPageUseCase(
              context: event.context,
              userId: event.userId!
            );
            res.fold((failure) => emit(CameraErrorState(failure: failure)),
                (r) => emit(CameraInitial()));
            break;
          }
        default:
          emit(CameraInitial());
          break;
      }
    });
  }

  QRViewController? get getController => dl.sl<QrScannerLocalDataSource>().qrViewController;
   set setController(QRViewController controller) => dl.sl<QrScannerLocalDataSource>().qrViewController = controller;
}
