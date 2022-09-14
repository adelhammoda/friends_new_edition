



import 'package:device_info_plus/device_info_plus.dart';

abstract class DeviceInfo{
  final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
  Future<String> getDeviceId();
}


