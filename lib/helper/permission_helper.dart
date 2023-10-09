import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionHelper {
  static Future<int> getStoragePermission() async {
    AndroidDeviceInfo androidInfo = await DeviceInfoPlugin().androidInfo;
    int sdkInt = androidInfo.version.sdkInt;

    PermissionStatus status ;//= await Permission.photos.request();
    if (sdkInt > 30) {
       status = await Permission.photos.request();
    }else{
      status = await Permission.storage.request();
    }

    if (status.isDenied) {
      return 1;
    }

    if (status.isPermanentlyDenied) {
      return 2;
    }
    return 3;
  }
  /*static Future<int> getManageStoragePermission() async {
    var status = await Permission.manageExternalStorage.request();
    if (status.isDenied) {
      return 1;
    }

    if (status.isPermanentlyDenied) {
      return 2;
    }

    return 3;
  }*/

  static Future<int> getCameraPermission() async {
    var status = await Permission.camera.request();
    if (status.isDenied) {
      return 1;
    }

    if (status.isPermanentlyDenied) {
      return 2;
    }

    return 3;
  }

  static Future<int> getLocationPermission() async {
    var status = await Permission.location.request();

    if (status.isDenied) {
      return 1;
    }

    if (status.isPermanentlyDenied) {
      return 2;
    }

    return 3;
  }


}
