import 'package:flutter/material.dart';
import 'package:untitled4/const.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:untitled4/l10n/app_localizations.dart';
import 'package:untitled4/core/widgets/rtl_text.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled4/features/services/bloc/services_bloc.dart';

class RedesignedServiceScreen extends StatefulWidget {
  const RedesignedServiceScreen({super.key});

  @override
  State<RedesignedServiceScreen> createState() =>
      _RedesignedServiceScreenState();
}

class _RedesignedServiceScreenState extends State<RedesignedServiceScreen> {
  final Map<String, String> categoryIcons = {
    'Restaurants': '🍽️',
    'Cafes': '☕',
    'Hotels': '🏨',
    'Tour Services': '🚌',
    'Public Services': '🏛️',
    'Hospitals': '🏥',
  };

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final isRTL = Localizations.localeOf(context).languageCode == 'ar';

    return BlocBuilder<ServicesBloc, ServicesState>(
      builder: (context, state) {
        if (state is ServicesLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is ServicesError) {
          return Center(child: Text(state.message));
        }

        if (state is ServicesLoaded) {
          return Scaffold(
            backgroundColor: AppColors.backgroundLight,
            appBar: AppBar(
              title: RTLText(
                text: l10n.services,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1,
                ),
              ),
              backgroundColor: AppColors.primary,
              elevation: 0,
              centerTitle: true,
            ),
            body: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header Section
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RTLText(
                        text: l10n.findPlaces,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textPrimary,
                        ),
                      ).animate().fadeIn(duration: 500.ms),
                      const SizedBox(height: 5),
                      RTLText(
                        text: l10n.searchHint,
                        style: const TextStyle(
                          fontSize: 10,
                          color: Colors.grey,
                          height: 1.5,
                        ),
                      ).animate().fadeIn(delay: 200.ms, duration: 500.ms),
                    ],
                  ),
                  const SizedBox(height: 15),

                  // Filter Card
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    elevation: 4,
                    shadowColor: AppColors.primary.withOpacity(0.1),
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        children: [
                          _buildDropdownRow(
                            icon: Icons.location_on,
                            value: state.selectedGovernorate,
                            items: state.governorates,
                            onChanged: (val) => context
                                .read<ServicesBloc>()
                                .add(ChangeGovernorate(
                                  governorate: val!,
                                  context: context,
                                )),
                            hint: l10n.selectGovernorate,
                          ),
                          const SizedBox(height: 14),
                          _buildDropdownRow(
                            icon: Icons.category,
                            value: state.selectedCategory,
                            items: state.categories,
                            onChanged: (val) =>
                                context.read<ServicesBloc>().add(ChangeCategory(
                                      category: val!,
                                      context: context,
                                    )),
                            hint: l10n.selectCategory,
                          ),
                        ],
                      ),
                    ),
                  ).animate().fadeIn(delay: 400.ms, duration: 500.ms),
                  const SizedBox(height: 15),

                  // Results Section
                  Expanded(
                    child: state.services.isEmpty
                        ? Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.search_off_rounded,
                                  size: 80,
                                  color: Colors.grey[400],
                                ),
                                const SizedBox(height: 10),
                                RTLText(
                                  text: l10n.noResults,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                          )
                        : ListView.builder(
                            itemCount: state.services.length,
                            itemBuilder: (context, index) {
                              final item = state.services[index];
                              return Card(
                                margin: const EdgeInsets.only(bottom: 16),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                elevation: 2,
                                child: ListTile(
                                  contentPadding: const EdgeInsets.all(16),
                                  leading: Container(
                                    width: 50,
                                    height: 50,
                                    decoration: BoxDecoration(
                                      color: AppColors.primary.withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Center(
                                      child: Text(
                                        categoryIcons[state.selectedCategory] ??
                                            '🔷',
                                        style: const TextStyle(fontSize: 24),
                                      ),
                                    ),
                                  ),
                                  title: RTLText(
                                    text: item.name,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                  subtitle: Padding(
                                    padding: const EdgeInsets.only(top: 4),
                                    child: RTLText(
                                      text: item.details,
                                      style: TextStyle(
                                        color: Colors.grey[600],
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                                ),
                              ).animate().fadeIn(
                                    delay: Duration(
                                        milliseconds: 600 + (index * 100)),
                                    duration: 500.ms,
                                  );
                            },
                          ),
                  ),
                ],
              ),
            ),
          );
        }

        return Center(child: Text(l10n.error));
      },
    );
  }

  Widget _buildDropdownRow({
    required IconData icon,
    required String value,
    required List<String> items,
    required Function(String?) onChanged,
    required String hint,
  }) {
    return Row(
      children: [
        Icon(icon, color: AppColors.primary),
        const SizedBox(width: 10),
        Expanded(
          child: DropdownButtonFormField<String>(
            value: items.contains(value) ? value : items.first,
            items: items.map((String item) {
              return DropdownMenuItem<String>(
                value: item,
                child: Text(item),
              );
            }).toList(),
            onChanged: onChanged,
            decoration: InputDecoration(
              hintText: hint,
              border: InputBorder.none,
              isDense: true,
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            ),
          ),
        ),
      ],
    );
  }
}
