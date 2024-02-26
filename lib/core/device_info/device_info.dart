



import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:friends/core/exception/exception.dart';
import 'package:friends/core/manager/string_manager.dart';

abstract class DeviceInfo{
  final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
  Future<String> getDeviceId();
}

class DeviceInfoImpl extends DeviceInfo{
  @override
  Future<String> getDeviceId() async{

    if(Platform.isAndroid){
      AndroidDeviceInfo  deviceInfo;
       deviceInfo = await deviceInfoPlugin.androidInfo;
       if(deviceInfo.id == null){
         throw DeviceInfoException();
       }
       //TODO:add device id validator class where validate device id.
       return deviceInfo.id!.replaceAll('.', '');
    }else if(Platform.isIOS){
      IosDeviceInfo  deviceInfo;
       deviceInfo = await deviceInfoPlugin.iosInfo;
      if(deviceInfo.model == null){
        throw DeviceInfoException();
      }
      return deviceInfo.model!;
    }else{
      throw DeviceInfoException(
        message: StringManager.unsupportedPlatformError
      );
    }
  }

}


