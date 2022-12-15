part of 'camera_bloc.dart';

abstract class CameraEvent extends Equatable {
  const CameraEvent();
}

class OpenCameraEvent extends CameraEvent{


  const OpenCameraEvent();
  @override
  List<Object?> get props => [];
}

class CloseCameraEvent extends CameraEvent{


  const CloseCameraEvent();
  @override
  List<Object?> get props => [];
}

class NavigateToUserDetailsEvent extends CameraEvent{
  final BuildContext context;
  final String? userId;

  const NavigateToUserDetailsEvent( {required this.context,required this.userId,});
  @override
  List<Object?> get props => [context];
}
