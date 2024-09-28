import 'dart:convert';
import 'dart:io';
import 'package:crypto/crypto.dart';
import 'package:device_info_plus/device_info_plus.dart';

Future<String> getUniqueUserId() async {
  String? deviceId;
  final deviceInfo = DeviceInfoPlugin();

  if (Platform.isIOS) {
    final iosDeviceInfo = await deviceInfo.iosInfo;
    deviceId = iosDeviceInfo.identifierForVendor;
  }
  if (Platform.isAndroid) {
    final androidDeviceInfo = await deviceInfo.androidInfo;
    deviceId = androidDeviceInfo.id;
  }

  if (deviceId != null && deviceId.length < 4) {
    if (Platform.isIOS) {
      deviceId += "__ios__";
    }
    if (Platform.isAndroid) {
      deviceId += "__android__";
    }
  }
  if (Platform.isAndroid) {
    deviceId ??= "fltter_user_id_android";
  } else if (Platform.isIOS) {
    deviceId ??= "fltter_user_id_ios";
  }
  final userId = md5
      .convert(utf8.encode(deviceId!))
      .toString()
      .replaceAll(RegExp(r'[^0-9]'), "");

  return userId.substring(userId.length - 6);
}
