import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled4/core/widgets/base_screen.dart';
import 'package:untitled4/core/constants/app_colors.dart';
import 'package:untitled4/l10n/app_localizations.dart';
import 'package:untitled4/core/widgets/rtl_text.dart';
import 'package:url_launcher/url_launcher.dart' as url_launcher;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:untitled4/features/about/bloc/about_bloc.dart';

class Place {
  final String name;
  final String description;

  Place({required this.name, required this.description});
}

class AboutUsPage extends BaseScreen {
  const AboutUsPage({super.key}) : super(navigationIndex: 0);

  @override
  State<BaseScreen> createState() => _AboutUsPageState();
}

class _AboutUsPageState extends BaseScreenState<AboutUsPage> {
  List<Place> allPlaces = [];
  List<Place> filteredPlaces = [];

  @override
  void initState() {
    super.initState();
    context.read<AboutBloc>().add(const LoadAboutContent());
    context.read<AboutBloc>().add(const LoadAppInfo());

    filteredPlaces = List.from(allPlaces);
  }

  void _searchPlaces(String query) {
    setState(() {
      filteredPlaces = allPlaces
          .where((place) =>
              place.name.toLowerCase().contains(query.toLowerCase()) ||
              place.description.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      height: 250,
      width: double.infinity,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/963.png'),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildSection({
    required String title,
    required String content,
    required IconData icon,
    required int index,
  }) {
    final isArabic = Localizations.localeOf(context).languageCode == 'ar';

    return Card(
      color: AppColors.backgroundWhite,
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Icon(
                    icon,
                    color: AppColors.primary,
                    size: 28,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            isArabic
                ? RTLText(
                    text: content,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.black87,
                      height: 1.6,
                    ),
                    textAlign: TextAlign.justify,
                    maxLines: null,
                    overflow: TextOverflow.visible,
                  )
                : Text(
                    content,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.black87,
                      height: 1.6,
                    ),
                    textAlign: TextAlign.justify,
                    maxLines: null,
                    overflow: TextOverflow.visible,
                  ),
          ],
        ),
      ),
    ).animate().fadeIn(duration: 500.ms).slideY(
          begin: 0.1,
          end: 0,
          duration: 500.ms,
          delay: (index * 200).ms,
        );
  }

  Widget _buildSocialMediaIconOnly({
    required IconData icon,
    required String url,
    required int index,
  }) {
    return InkWell(
      onTap: () => _launchURL(url),
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: AppColors.backgroundWhite,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              blurRadius: 6,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Icon(
          icon,
          color: AppColors.primary, // استخدام اللون الأساسي للتطبيق
          size: 26,
        ),
      ),
    ).animate().fadeIn(duration: 600.ms).slideX(
      begin: 0.3,
      end: 0,
      delay: (index * 200).ms,
      duration: 600.ms,
    );
  }

  Future<void> _launchURL(String url) async {
    final Uri uri = Uri.parse(url);

    if (!await url_launcher.launchUrl(uri,
        mode: url_launcher.LaunchMode.externalApplication)) {
      // إذا فشل، أظهر رسالة
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('لا يمكن فتح الرابط')),
        );
      }
    }
  }

  @override
  Widget buildBody(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return BlocBuilder<AboutBloc, AboutState>(
      builder: (context, state) {
        if (state is AboutLoading) {
          return Center(
            child: Text(l10n.loading),
          );
        }

        if (state is AboutError) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  state.message,
                  style: const TextStyle(color: Colors.red),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    context.read<AboutBloc>().add(const LoadAboutContent());
                    context.read<AboutBloc>().add(const LoadAppInfo());
                  },
                  child: Text(l10n.retry),
                ),
              ],
            ),
          );
        }

        return SingleChildScrollView(
          child: Column(
            children: [
              _buildHeader(context),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildSection(
                      title: l10n.whoWeAre,
                      content: l10n.whoWeAreContent,
                      icon: FontAwesomeIcons.infoCircle,
                      index: 0,
                    ),
                    _buildSection(
                      title: l10n.whatIs963SY,
                      content: l10n.whatIs963SYContent,
                      icon: FontAwesomeIcons.questionCircle,
                      index: 1,
                    ),
                    _buildSection(
                      title: l10n.ourMission,
                      content: l10n.ourMissionContent,
                      icon: FontAwesomeIcons.flag,
                      index: 2,
                    ),
                    const SizedBox(height: 24),
                    // Text(
                    //   l10n.contactUs,
                    //   style: const TextStyle(
                    //     fontSize: 24,
                    //     fontWeight: FontWeight.bold,
                    //   ),
                    // ),
                    // const SizedBox(height: 16),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    //   children: [
                    //     _buildSocialMediaIconOnly(
                    //       icon: FontAwesomeIcons.globe,
                    //       url: 'https://963sy.net',
                    //       index: 0,
                    //     ),
                    //     _buildSocialMediaIconOnly(
                    //       icon: FontAwesomeIcons.facebook,
                    //       url: 'https://www.facebook.com/share/12J86eBRuZK/',
                    //       index: 1,
                    //     ),
                    //     _buildSocialMediaIconOnly(
                    //       icon: FontAwesomeIcons.instagram,
                    //       url: 'https://www.instagram.com/963sy.app?igsh=eWV3bTkzZW14cjA=',
                    //       index: 2,
                    //     ),
                    //     _buildSocialMediaIconOnly(
                    //       icon: FontAwesomeIcons.youtube,
                    //       url: 'https://youtube.com/@963syapp?si=KpjVYAYEwy8oekRR',
                    //       index: 3,
                    //     ),
                    //   ],
                    // ),

                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
