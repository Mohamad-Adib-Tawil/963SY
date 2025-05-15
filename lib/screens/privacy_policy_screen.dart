import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled4/core/constants/app_colors.dart';
import 'package:untitled4/core/widgets/rtl_text.dart';
import 'package:untitled4/navigation/navigation_service.dart';
import 'package:untitled4/l10n/app_localizations.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

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
  }
}
