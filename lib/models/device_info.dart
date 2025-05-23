class DeviceInfo {
  final String deviceId;
  final String name;
  final String os;
  final String version;
  final String? model;
  final String? manufacturer;

  DeviceInfo({
    required this.deviceId,
    required this.name,
    required this.os,
    required this.version,
    this.model,
    this.manufacturer,
  });

  Map<String, dynamic> toJson() => {
        'device_name': name,
        'platform': os,
        'device_token': deviceId,
        'app_version': version,
      };
}
