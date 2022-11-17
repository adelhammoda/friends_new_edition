

import 'package:friends/core/exception/exception.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

abstract class QrScannerLocalDataSource{
   QRViewController? qrViewController;
  ///open camera
  Future<void> openCamera();
  ///clos camera
  Future<void> closeCamera();


}


class QrScannerLocalDataSourceImpl extends QrScannerLocalDataSource{
  @override
  Future<void> closeCamera() async {
    if (qrViewController == null) {
      throw CloseCameraException();
    } else {
      await qrViewController!.stopCamera();
    }
  }

  @override
  Future<void> openCamera() async {
    if(qrViewController==null){
      throw OpenCameraException();
    }else {
      return await qrViewController!.resumeCamera();
    }
  }



}