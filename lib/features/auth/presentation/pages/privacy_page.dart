import 'dart:developer';
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled4/core/constants/app_colors.dart';
import 'package:untitled4/core/services/device_service.dart';
import 'package:untitled4/features/home/presentation/pages/homepage.dart';
import 'package:untitled4/l10n/app_localizations.dart';
import 'package:untitled4/core/widgets/rtl_text.dart';
import 'package:untitled4/models/device_info.dart';
import 'package:uuid/uuid.dart';

class PrivacyPage extends StatelessWidget {
  final VoidCallback onAccept;
  PrivacyPage({super.key, required this.onAccept});

  final _deviceService = DeviceService();
  final _uuid = Uuid();

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
    final isArabic = Localizations.localeOf(context).languageCode == 'ar';
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      body: SafeArea(
        child: Directionality(
          textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
          child: _buildContent(context, l10n, isArabic),
        ),
      ),
    );
  }

  Widget _buildContent(
      BuildContext context, AppLocalizations l10n, bool isArabic) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          _buildHeader(l10n, isArabic),
          const SizedBox(height: 20),
          Expanded(
            child: SingleChildScrollView(
              child: _buildPrivacyText(l10n, isArabic),
            ),
          ),
          const SizedBox(height: 20),
          _buildButtons(context, l10n, isArabic),
        ],
      ),
    );
  }

  Widget _buildHeader(AppLocalizations l10n, bool isArabic) {
    return Column(
      children: [
        const SizedBox(height: 20),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.primary.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: const Icon(
            Icons.privacy_tip_rounded,
            size: 50,
            color: AppColors.primary,
          ),
        ),
        const SizedBox(height: 20),
        isArabic
            ? RTLText(
                text: l10n.privacyPolicy,
                style: const TextStyle(
                  fontSize: 28,
                  color: AppColors.primary,
                  fontWeight: FontWeight.bold,
                ),
              )
            : Text(
                l10n.privacyPolicy,
                style: const TextStyle(
                  fontSize: 28,
                  color: AppColors.primary,
                  fontWeight: FontWeight.bold,
                ),
              ),
      ],
    );
  }

  Widget _buildPrivacyText(AppLocalizations l10n, bool isArabic) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildPrivacySection(
            title: isArabic ? 'جمع المعلومات' : 'Information Collection',
            content: isArabic
                ? 'نقوم بجمع المعلومات الضرورية لتقديم خدماتنا، بما في ذلك معلومات الموقع والتفضيلات. نحن نضمن حماية بياناتك الشخصية وعدم مشاركتها مع أطراف ثالثة.'
                : 'We collect necessary information to provide our services, including location data and preferences. We ensure the protection of your personal data and do not share it with third parties.',
          ),
          const SizedBox(height: 20),
          _buildPrivacySection(
            title: isArabic ? 'استخدام البيانات' : 'Data Usage',
            content: isArabic
                ? 'نستخدم البيانات لتحسين تجربة المستخدم وتقديم محتوى مخصص. يمكنك التحكم في إعدادات الخصوصية في أي وقت.'
                : 'We use data to improve user experience and provide personalized content. You can control privacy settings at any time.',
          ),
          const SizedBox(height: 20),
          _buildPrivacySection(
            title: isArabic ? 'الأمان' : 'Security',
            content: isArabic
                ? 'نحن نستخدم أحدث تقنيات الأمان لحماية بياناتك. يتم تشفير جميع المعلومات الحساسة.'
                : 'We use the latest security technologies to protect your data. All sensitive information is encrypted.',
          ),
          const SizedBox(height: 20),
          _buildPrivacySection(
            title: isArabic ? 'حقوق المستخدم' : 'User Rights',
            content: isArabic
                ? 'لديك الحق في الوصول إلى بياناتك وتعديلها أو حذفها في أي وقت. يمكنك أيضًا طلب تصدير بياناتك.'
                : 'You have the right to access, modify, or delete your data at any time. You can also request to export your data.',
          ),
        ],
      ),
    );
  }

  Widget _buildPrivacySection(
      {required String title, required String content}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: AppColors.primary,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          content,
          style: const TextStyle(
            fontSize: 16,
            height: 1.5,
            color: Colors.black87,
          ),
          textAlign: TextAlign.justify,
        ),
      ],
    );
  }

  Widget _buildButtons(
      BuildContext context, AppLocalizations l10n, bool isArabic) {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton(
            onPressed: () => _handleDecline(context),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.grey[200],
              foregroundColor: Colors.black87,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            child: Text(l10n.decline),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: ElevatedButton(
            onPressed: () async {
              onAccept();
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
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            child: Text(l10n.accept),
          ),
        ),
      ],
    );
  }

  Future<void> _handleAcceptPrivacy(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('accepted_privacy', true);
    if (context.mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const Homepage()),
      );
    }
  }

  void _handleDecline(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(AppLocalizations.of(context)!.privacyPolicy),
        content: Text(AppLocalizations.of(context)!.decline),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(AppLocalizations.of(context)!.cancel),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context);
            },
            child: Text(AppLocalizations.of(context)!.decline),
          ),
        ],
      ),
    );
  }
}
