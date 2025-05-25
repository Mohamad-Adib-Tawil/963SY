import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:untitled4/const.dart';
import 'package:untitled4/core/widgets/base_screen.dart';
import 'package:untitled4/l10n/app_localizations.dart';
import 'package:untitled4/core/widgets/rtl_text.dart';

class Governorate {
  final String name;
  final double latitude;
  final double longitude;

  final String description;

  const Governorate({
    required this.name,
    required this.latitude,
    required this.longitude,
    required this.description,
  });
}

class SyriaMapPage extends BaseScreen {
  const SyriaMapPage({super.key}) : super(navigationIndex: 3);

  @override
  State<BaseScreen> createState() => _SyriaMapPageState();
}

class _SyriaMapPageState extends BaseScreenState<SyriaMapPage> {
  static const List<Governorate> governorates = [
    Governorate(
      name: "دمشق",
      latitude: 33.5138,
      longitude: 36.2765,
      description: 'العاصمة السورية، وتعد مركزاً ثقافياً وتاريخياً مهماً.',
    ),
    Governorate(
      name: "ريف دمشق",
      latitude: 33.5167,
      longitude: 36.4,
      description:
          'تحيط بالعاصمة دمشق، وتضم العديد من المناطق الجبلية والزراعية.',
    ),
    Governorate(
      name: "حلب",
      latitude: 36.2021,
      longitude: 37.1343,
      description: 'ثاني أكبر مدينة في سوريا، مشهورة بقلعتها وأسواقها القديمة.',
    ),
    Governorate(
      name: "حمص",
      latitude: 34.7333,
      longitude: 36.7167,
      description: 'مدينة عريقة تقع في وسط سوريا، وتعد مركزاً صناعياً هاماً.',
    ),
    Governorate(
      name: "حماة",
      latitude: 35.1333,
      longitude: 36.75,
      description: 'معروفة بنواعيرها على نهر العاصي وتاريخها العريق.',
    ),
    Governorate(
      name: "اللاذقية",
      latitude: 35.5167,
      longitude: 35.7833,
      description: 'مدينة ساحلية مهمة على البحر الأبيض المتوسط.',
    ),
    Governorate(
      name: "طرطوس",
      latitude: 34.8833,
      longitude: 35.8833,
      description: 'مدينة ساحلية هادئة ذات طابع سياحي وزراعي.',
    ),
    Governorate(
      name: "إدلب",
      latitude: 35.9333,
      longitude: 36.6333,
      description: 'تقع في شمال غرب سوريا وتتميز بطبيعتها الزراعية.',
    ),
    Governorate(
      name: "درعا",
      latitude: 32.6189,
      longitude: 36.1021,
      description: 'تقع جنوب سوريا، مشهورة بسهولها وموقعها الحدودي.',
    ),
    Governorate(
      name: "السويداء",
      latitude: 32.7,
      longitude: 36.5667,
      description: 'مدينة جبلية مشهورة بالعنب والنبيذ وتاريخها الديني.',
    ),
    Governorate(
      name: "دير الزور",
      latitude: 35.3333,
      longitude: 40.15,
      description: 'تقع على نهر الفرات، وتعد مركزاً زراعياً ونفطياً مهماً.',
    ),
    Governorate(
      name: "الحسكة",
      latitude: 36.4833,
      longitude: 40.75,
      description: 'شمال شرق سوريا، غنية بالزراعة والثقافات المتنوعة.',
    ),
    Governorate(
      name: "الرقة",
      latitude: 35.95,
      longitude: 39.0167,
      description: 'تقع على نهر الفرات، وكانت عاصمة للدولة العباسية سابقاً.',
    ),
    Governorate(
      name: "القنيطرة",
      latitude: 33.1256,
      longitude: 35.8236,
      description: 'تقع في الجولان السوري، وتعرضت لدمار كبير بسبب الاحتلال.',
    ),
  ];

  @override
  Widget buildBody(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: _buildAppBar(context, l10n),
      body: _buildMap(),
    );
  }

  PreferredSizeWidget _buildAppBar(
      BuildContext context, AppLocalizations l10n) {
    return AppBar(
      centerTitle: true,
      title: RTLText(
        text: l10n.map,
        style: const TextStyle(color: Colors.white),
      ),
      flexibleSpace: Container(
        decoration: const BoxDecoration(
          color: AppColors.primary,
        ),
      ),
    );
  }

  Widget _buildMap() {
    return FlutterMap(
      options: const MapOptions(
        initialCenter: LatLng(35.0, 38.5),
        initialZoom: 6.0,
      ),
      children: [
        _buildTileLayer(),
        _buildMarkerLayer(),
      ],
    );
  }

  Widget _buildTileLayer() {
    return TileLayer(
      urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
      userAgentPackageName: 'com.example.syria_map',
    );
  }

  Widget _buildMarkerLayer() {
    return MarkerLayer(
      markers: governorates.map(_createMarker).toList(),
    );
  }

  Marker _createMarker(Governorate governorate) {
    return Marker(
      width: 120,
      height: 60,
      point: LatLng(governorate.latitude, governorate.longitude),
      child: GestureDetector(
        onTap: () => _showGovernorateDetails(governorate),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.location_on, color: Colors.red, size: 30),
            _buildGovernorateLabel(governorate.name),
          ],
        ),
      ),
    );
  }

  Widget _buildGovernorateLabel(String name) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
      ),
      child: RTLText(
        text: name,
        style: const TextStyle(fontSize: 12),
      ),
    );
  }

  void _showGovernorateDetails(Governorate governorate) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              governorate.name,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              governorate.description,
              textAlign: TextAlign.justify,
              style: const TextStyle(fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }
}
