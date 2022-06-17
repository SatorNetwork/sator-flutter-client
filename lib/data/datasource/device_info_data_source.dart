abstract class DeviceInfoDataSource {
  Future<void> init();

  Future<String> getDeviceId();
}
