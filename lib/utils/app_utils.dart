import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';

class AppUtils {
  AppUtils._();

  static Future<String> getDeviceName() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

    if (Platform.isAndroid) {
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      return androidInfo.model; // Lấy tên thiết bị Android
    } else if (Platform.isIOS) {
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      return iosInfo.utsname.machine; // Lấy tên thiết bị iOS
    } else if (Platform.isWindows) {
      // Retrieve Windows device information
      WindowsDeviceInfo windowsInfo = await deviceInfo.windowsInfo;
      return windowsInfo.computerName ?? 'Unknown Windows device';
    }

    return "Unknown Device";
  }
}
