import 'package:device_info_plus/device_info_plus.dart';
import 'package:satorio/data/datasource/device_info_data_source.dart';
import 'package:satorio/ui/theme/light_theme.dart';

class DeviceInfoDataSourceImpl implements DeviceInfoDataSource {
  final DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

  @override
  Future<void> init() async {}

  @override
  Future<String> getDeviceId() async {
    var _deviceOsInfo;

    if (!isAndroid) {
      _deviceOsInfo = await deviceInfo.iosInfo;
      return _deviceOsInfo.identifierForVendor;
    } else {
      _deviceOsInfo = await deviceInfo.androidInfo;
      return _deviceOsInfo.androidId;
    }
  }
}
