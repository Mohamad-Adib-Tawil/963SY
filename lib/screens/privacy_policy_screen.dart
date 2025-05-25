import 'dart:developer';
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled4/core/constants/app_colors.dart';
import 'package:untitled4/core/services/device_service.dart';
import 'package:untitled4/core/widgets/rtl_text.dart';
import 'package:untitled4/models/device_info.dart';
import 'package:untitled4/navigation/navigation_service.dart';
import 'package:untitled4/l10n/app_localizations.dart';
import 'package:uuid/uuid.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  PrivacyPolicyScreen({super.key});

  final _deviceService = DeviceService();
  final _uuid = const Uuid();

  Future<void> _registerDevice() async {
    final deviceInfoPlugin = DeviceInfoPlugin();
    String deviceId =
        await _getDeviceId(); // Implement platform-specific ID retrieval

    if (Platform.isAndroid) {
      AndroidDeviceInfo androidInfo = await deviceInfoPlugin.androidInfo;
      var deviceInfo = DeviceInfo(
        deviceId: deviceId,
        name: androidInfo.model,
        os: 'Android',
        version: androidInfo.version.release,
        model: androidInfo.model,
        manufacturer: androidInfo.manufacturer,
      );
      await DeviceService.registerDevice(deviceInfo);
    } else if (Platform.isIOS) {
      IosDeviceInfo iosInfo = await deviceInfoPlugin.iosInfo;
      var deviceInfo = DeviceInfo(
        deviceId: deviceId,
        name: iosInfo.name,
        os: 'iOS',
        version: iosInfo.systemVersion,
        model: iosInfo.model,
        manufacturer: 'Apple',
      );
      await DeviceService.registerDevice(deviceInfo);
    }
  }

  Future<String> _getDeviceId() async {
    final prefs = await SharedPreferences.getInstance();
    final deviceInfo = DeviceInfoPlugin();

    String? deviceId;

    try {
      if (Platform.isAndroid) {
        final androidInfo = await deviceInfo.androidInfo;
        deviceId = androidInfo.id; // May vary across devices/OS versions
      } else if (Platform.isIOS) {
        final iosInfo = await deviceInfo.iosInfo;
        deviceId = iosInfo.identifierForVendor; // Unique per vendor
      }
    } catch (e) {
      // Log or handle platform exception
      log('Error getting native device ID: $e');
    }

    // If deviceId is null or unreliable, fallback to stored/generated UUID
    if (deviceId == null || deviceId.isEmpty) {
      deviceId = prefs.getString('device_id');
      if (deviceId == null) {
        deviceId = _uuid.v4();
        await prefs.setString('device_id', deviceId);
      }
    }

    return deviceId;
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      appBar: AppBar(
        title: RTLText(
          text: l10n.privacyPolicy,
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: AppColors.primary,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RTLText(
                        text: l10n.privacyPolicy,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primary,
                        ),
                      ),
                      const SizedBox(height: 16),
                      RTLText(
                        text: l10n.privacyPolicyLastUpdated,
                        style: const TextStyle(),
                      ),
                      const SizedBox(height: 24),
                      _buildSection(
                        context,
                        l10n.privacyPolicyInfoCollection,
                        l10n.privacyPolicyInfoCollectionContent,
                      ),
                      _buildSection(
                        context,
                        l10n.privacyPolicyInfoUsage,
                        l10n.privacyPolicyInfoUsageContent,
                      ),
                      _buildSection(
                        context,
                        l10n.privacyPolicyInfoSharing,
                        l10n.privacyPolicyInfoSharingContent,
                      ),
                      _buildSection(
                        context,
                        l10n.privacyPolicyYourRights,
                        l10n.privacyPolicyYourRightsContent,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => _acceptPrivacy(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: RTLText(
                    text: l10n.accept,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSection(BuildContext context, String title, String content) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RTLText(
            text: title,
            style: const TextStyle(
              fontSize: 18,
            ),
          ),
          const SizedBox(height: 8),
          RTLText(
            text: content,
            style: const TextStyle(
              fontSize: 16,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _acceptPrivacy(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('has_seen_privacy', true);
    if (context.mounted) {
      NavigationService.navigateTo('/welcome');
    }
    try {
      await _registerDevice();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Device registered successfully')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }
}
