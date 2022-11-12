
import 'package:friends/features/QRGenerator/presentation/widgets/qr_image.dart';
import 'package:qr_flutter/qr_flutter.dart';

abstract class QrGeneratorLocalDataSource {
  ///generate qr code from string
  QrImage generateQrCode({required String data}) ;
}

class QrGeneratorLocalDataSourceImpl extends QrGeneratorLocalDataSource {
  @override
  QrImage generateQrCode({required String data}) => qrImage(data);
}
