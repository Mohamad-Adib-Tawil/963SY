import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled4/core/constants/app_colors.dart';
import 'package:untitled4/core/widgets/rtl_text.dart';
import 'package:untitled4/features/home/cubit/language_cubit.dart';
import 'package:untitled4/features/home/models/language_model.dart';
import 'package:untitled4/navigation/navigation_service.dart';

import 'package:untitled4/providers/language_provider.dart';
import 'package:untitled4/l10n/app_localizations.dart';

class LanguageSelectionScreen extends StatefulWidget {
  const LanguageSelectionScreen({super.key});

  @override
  State<LanguageSelectionScreen> createState() =>
      _LanguageSelectionScreenState();
}

class _LanguageSelectionScreenState extends State<LanguageSelectionScreen> {
  // List<Language> languages = [];

  @override
  void initState() {
    context.read<LanguageCubit>().getLanguages();
    super.initState();
  }

  // Future<void> _fetchLanguages() async {
  //   try {
  //     final response = await ApiClient.instance.get(ApiEndpoints.languages);
  //     if (response.statusCode == 200) {
  //       final List<dynamic> data = response.data['data'];
  //       setState(() {
  //         languages = data.map((json) => Language.fromJson(json)).toList();
  //         isLoading = false;
  //       });
  //     }
  //   } catch (e) {
  //     setState(() {
  //       isLoading = false;
  //     });
  //     // Handle error appropriately
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildHeader(l10n),
              const SizedBox(height: 40),
              _buildLanguageOptions(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(AppLocalizations l10n) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.primary.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: const Icon(
            Icons.language,
            size: 50,
            color: AppColors.primary,
          ),
        ),
        const SizedBox(height: 20),
        RTLText(
          text: l10n.language,
          style: const TextStyle(
            fontSize: 28,
            color: AppColors.primary,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildLanguageOptions(BuildContext context) {
    return BlocBuilder<LanguageCubit, LanguageState>(
      builder: (context, state) {
        if (state is LanguageFailuer) {
          return Center(child: Text(state.errorMessage));
        }
        if (state is LanguageSucces) {
          return Column(
            children: state.languages
                .map((language) => Column(
                      children: [
                        _LanguageOption(
                          language: language.name!,
                          onTap: () => _selectLanguage(context, language),
                        ),
                        const SizedBox(height: 16),
                      ],
                    ))
                .toList(),
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  Future<void> _selectLanguage(
      BuildContext context, LanguageModel language) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('selected_language', language.code!);

    // Store language ID based on the selected language // 3 for Arabic, 2 for English
    await prefs.setInt('selected_language_id', language.id!);

    if (context.mounted) {
      await context.read<LanguageProvider>().changeLanguage(language.code!);
      NavigationService.navigateToAndRemoveUntil('/privacy');
    }
  }
}

class _LanguageOption extends StatelessWidget {
  final String language;
  final VoidCallback onTap;

  const _LanguageOption({
    required this.language,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Row(
          children: [
            const SizedBox(width: 16),
            Text(
              language,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            const Spacer(),
            const Icon(
              Icons.arrow_forward_ios,
              color: AppColors.primary,
              size: 16,
            ),
          ],
        ),
      ),
    );
  }
}
