


import 'package:friends/core/exception/exception.dart';
import 'package:friends/core/manager/string_manager.dart';
import 'package:permission_handler/permission_handler.dart';

abstract class PermissionManagerBase{

  ///request camera permission.
  Future<void> requestCameraPermission();

}




class PermissionManager implements PermissionManagerBase{
  @override
  Future<void> requestCameraPermission()async {
    bool isGranted = await Permission.camera.isGranted;
    if(isGranted){
      return;
    }
   await Permission.camera.request();
   bool isDenied = await Permission.camera.isDenied;
   if(isDenied){
     throw PermissionDeniedException(
       message: StringManager.permissionToCameraIdDeniedErrorMessage
     );
   }
  }

}