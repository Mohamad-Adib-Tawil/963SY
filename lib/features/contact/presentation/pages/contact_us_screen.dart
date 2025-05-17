import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled4/core/widgets/base_screen.dart';
import 'package:untitled4/const.dart' as app_const;
import 'package:untitled4/l10n/app_localizations.dart';
import 'package:untitled4/core/widgets/rtl_text.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:untitled4/features/contact/bloc/contact_bloc.dart';

class ContactUsScreen extends BaseScreen {
  const ContactUsScreen({super.key}) : super(navigationIndex: 4);

  @override
  State<BaseScreen> createState() => _ContactUsScreenState();
}

class _ContactUsScreenState extends BaseScreenState<ContactUsScreen> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _subjectController = TextEditingController();
  final _messageController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  bool _isValidEmail(String email) {
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return emailRegex.hasMatch(email);
  }

  @override
  Widget buildBody(BuildContext context) {
    final isArabic = Localizations.localeOf(context).languageCode == 'ar';
    final l10n = AppLocalizations.of(context)!;

    return BlocListener<ContactBloc, ContactState>(
      listener: (context, state) {
        if (state is ContactFormSubmitted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message ?? '')),
          );
        } else if (state is ContactError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        }
      },
      child: Directionality(
        textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
        child: Scaffold(
          backgroundColor: app_const.AppColors.backgroundLight,
          appBar: AppBar(
            centerTitle: true,
            backgroundColor: app_const.AppColors.primary,
            elevation: 0,
            leading: const BackButton(color: Colors.white),
            title: isArabic
                ? RTLText(
                    text: l10n.contactUs,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1,
                    ),
                  )
                : Text(
                    l10n.contactUs,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1,
                    ),
                  ),
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  _buildTextField(
                    label: l10n.name,
                    icon: Icons.person,
                    controller: _nameController,
                    isArabic: isArabic,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'الرجاء إدخال الاسم';
                      }
                      return null;
                    },
                  ).animate().fadeIn(duration: 500.ms),
                  const SizedBox(height: 20),
                  _buildTextField(
                    label: l10n.email,
                    icon: Icons.email,
                    controller: _emailController,
                    isArabic: isArabic,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'الرجاء إدخال البريد الإلكتروني';
                      } else if (!_isValidEmail(value.trim())) {
                        return 'البريد الإلكتروني غير صالح';
                      }
                      return null;
                    },
                  ).animate().fadeIn(delay: 200.ms, duration: 500.ms),
                  const SizedBox(height: 20),
                  _buildTextField(
                    label: l10n.subject,
                    icon: Icons.subject,
                    controller: _subjectController,
                    isArabic: isArabic,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'الرجاء إدخال الموضوع';
                      }
                      return null;
                    },
                  ).animate().fadeIn(delay: 400.ms, duration: 500.ms),
                  const SizedBox(height: 20),
                  _buildTextField(
                    label: l10n.message,
                    icon: Icons.message,
                    maxLines: 5,
                    controller: _messageController,
                    isArabic: isArabic,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'الرجاء إدخال الرسالة';
                      }
                      return null;
                    },
                  ).animate().fadeIn(delay: 600.ms, duration: 500.ms),
                  const SizedBox(height: 30),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState?.validate() ?? false) {
                          context.read<ContactBloc>().add(
                                SubmitContactForm(
                                  name: _nameController.text.trim(),
                                  email: _emailController.text.trim(),
                                  subject: _subjectController.text.trim(),
                                  message: _messageController.text.trim(),
                                ),
                              );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: app_const.AppColors.secondary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        elevation: 5,
                        shadowColor:
                            app_const.AppColors.secondary.withOpacity(0.5),
                      ),
                      child: isArabic
                          ? RTLText(
                              text: l10n.submitInformation,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: app_const.AppColors.backgroundWhite,
                              ),
                            )
                          : Text(
                              l10n.submitInformation,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: app_const.AppColors.backgroundWhite,
                              ),
                            ),
                    ),
                  ).animate().fadeIn(delay: 800.ms, duration: 500.ms),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    IconData? icon,
    int maxLines = 1,
    required TextEditingController controller,
    required bool isArabic,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      maxLines: maxLines,
      validator: validator,
      textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
      style: const TextStyle(
        color: app_const.AppColors.textPrimary,
        fontSize: 16,
      ),
      decoration: InputDecoration(
        prefixIcon: icon != null
            ? Icon(icon, color: app_const.AppColors.primary)
            : null,
        labelText: label,
        labelStyle: TextStyle(
          color: app_const.AppColors.textPrimary.withOpacity(0.7),
          fontSize: 14,
        ),
        filled: true,
        fillColor: app_const.AppColors.backgroundWhite,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 16,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(
            color: app_const.AppColors.primary,
            width: 1.5,
          ),
        ),
        floatingLabelBehavior: FloatingLabelBehavior.auto,
        floatingLabelStyle: const TextStyle(
          color: app_const.AppColors.primary,
          fontSize: 14,
        ),
      ),
    );
  }
}
