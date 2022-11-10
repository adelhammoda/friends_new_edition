
import 'package:qr_flutter/qr_flutter.dart';

abstract class QrGeneratorLocalDataSource {
  ///generate qr code from string
  QrImage generateQrCode({required String data}) {
    return QrImage(
      data: data,
    );
  }
}
