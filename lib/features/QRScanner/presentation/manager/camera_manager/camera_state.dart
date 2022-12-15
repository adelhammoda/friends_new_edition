part of 'camera_bloc.dart';

abstract class CameraState extends Equatable {
  const CameraState();
}

class CameraInitial extends CameraState {
  @override
  List<Object> get props => [];
}


class CameraOpened extends CameraState{
  @override
  List<Object?> get props => [];
}

class CameraClosed extends CameraState{
  @override
  List<Object?> get props => [];
}


class CameraLoadingState extends CameraState{
  @override
  List<Object?> get props => [];
}
class CameraErrorState extends CameraState{
  final Failure failure;

  const CameraErrorState({required this.failure});
  @override
  List<Object?> get props => [];
}