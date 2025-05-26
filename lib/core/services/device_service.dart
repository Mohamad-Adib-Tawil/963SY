import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:untitled4/models/device_info.dart';

class DeviceService {
  static const String _baseUrl = 'https://963sy.net/api/user';

  static Future<void> registerDevice(DeviceInfo deviceInfo) async {
    final url = Uri.parse('$_baseUrl/device/store');
    log('---------Device info: requested with data : ${deviceInfo.toJson()}-------');

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode(deviceInfo.toJson()),
      );

      if (response.statusCode == 201) {
        log('---------Device info: ${response.body}-------');
      } else {
        throw Exception('Failed to register device: ${response.body}');
      }
    } catch (e) {
      throw Exception('Error registering device: $e');
    }
  }
}
