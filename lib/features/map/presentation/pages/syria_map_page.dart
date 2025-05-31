import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:untitled4/const.dart';
import 'package:untitled4/core/widgets/base_screen.dart';
import 'package:untitled4/features/services/cubit/city_cubit.dart';
import 'package:untitled4/l10n/app_localizations.dart';
import 'package:untitled4/core/widgets/rtl_text.dart';
import 'package:collection/collection.dart';

class Governorate {
  late String? name;
  final double latitude;
  final double longitude;
  late String? image;
  late String? description;

  Governorate({
    this.name,
    required this.latitude,
    required this.longitude,
    this.description,
    this.image,
  });
}

class SyriaMapPage extends BaseScreen {
  const SyriaMapPage({super.key}) : super(navigationIndex: 3);

  @override
  State<BaseScreen> createState() => _SyriaMapPageState();
}

class _SyriaMapPageState extends BaseScreenState<SyriaMapPage> {
  late List<Governorate> governorates = [
    Governorate(
      name: "دمشق",
      latitude: 33.5138,
      longitude: 36.2765,
    ),
    Governorate(
      name: 'ريف دمشق',
      latitude: 33.5167,
      longitude: 36.4,
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
    final isArabic = Localizations.localeOf(context).languageCode == 'ar';
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushReplacementNamed(context, '/home');
        return false;
      },
      child: Scaffold(
        appBar: _buildAppBar(context, l10n),
        body: _buildMap(),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(
      BuildContext context, AppLocalizations l10n) {
    final isArabic = Localizations.localeOf(context).languageCode == 'ar';
    return AppBar(
      centerTitle: true,
      leading: IconButton(
        icon: Icon(
          isArabic ? Icons.arrow_forward : Icons.arrow_back,
          color: Colors.white,
        ),
        onPressed: () {
          Navigator.pushReplacementNamed(context, '/home');
        },
      ),
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
    return BlocConsumer<CityCubit, CityState>(
      listener: (context, state) {
        if (state is CitySuccess) {
          var damascus = state.cities.firstWhereOrNull((e) => e.cityType == 1);
          var aleppo = state.cities.firstWhereOrNull((e) => e.cityType == 2);
          var homs = state.cities.firstWhereOrNull((e) => e.cityType == 3);
          var hama = state.cities.firstWhereOrNull((e) => e.cityType == 4);
          var tartous = state.cities.firstWhereOrNull((e) => e.cityType == 5);
          var lattakia = state.cities.firstWhereOrNull((e) => e.cityType == 6);
          var assoidaa = state.cities.firstWhereOrNull((e) => e.cityType == 7);
          var daraa = state.cities.firstWhereOrNull((e) => e.cityType == 8);
          var qunitra = state.cities.firstWhereOrNull((e) => e.cityType == 9);
          var raqqa = state.cities.firstWhereOrNull((e) => e.cityType == 10);
          var deirEzzor =
              state.cities.firstWhereOrNull((e) => e.cityType == 11);
          var alHasakah =
              state.cities.firstWhereOrNull((e) => e.cityType == 12);
          var idlib = state.cities.firstWhereOrNull((e) => e.cityType == 13);
          var rifDemashk =
              state.cities.firstWhereOrNull((e) => e.cityType == 14);
          governorates = [
            if (damascus != null)
              Governorate(
                name: damascus.cityName!,
                latitude: 33.5138,
                longitude: 36.2765,
                description: damascus.description!,
                image: damascus.photo!,
              ),
            if (rifDemashk != null)
              Governorate(
                name: rifDemashk.cityName!,
                latitude: 33.5167,
                longitude: 36.4,
                description: rifDemashk.description!,
                image: rifDemashk.photo!,
              ),
            if (aleppo != null)
              Governorate(
                name: aleppo.cityName!,
                latitude: 36.2021,
                longitude: 37.1343,
                description: aleppo.description!,
                image: aleppo.photo!,
              ),
            if (homs != null)
              Governorate(
                name: homs.cityName!,
                latitude: 34.7333,
                longitude: 36.7167,
                description: homs.description!,
                image: homs.photo!,
              ),
            if (hama != null)
              Governorate(
                name: hama.cityName!,
                latitude: 35.1333,
                longitude: 36.75,
                description: hama.description!,
                image: hama.photo!,
              ),
            if (lattakia != null)
              Governorate(
                name: lattakia.cityName!,
                latitude: 35.5167,
                longitude: 35.7833,
                description: lattakia.description!,
                image: lattakia.photo!,
              ),
            if (tartous != null)
              Governorate(
                name: tartous.cityName!,
                latitude: 34.8833,
                longitude: 35.8833,
                description: tartous.description!,
                image: tartous.photo!,
              ),
            if (idlib != null)
              Governorate(
                name: idlib.cityName!,
                latitude: 35.9333,
                longitude: 36.6333,
                description: idlib.description!,
                image: idlib.photo!,
              ),
            if (daraa != null)
              Governorate(
                name: daraa.cityName!,
                latitude: 32.6189,
                longitude: 36.1021,
                description: daraa.description!,
                image: daraa.photo!,
              ),
            if (assoidaa != null)
              Governorate(
                name: assoidaa.cityName!,
                latitude: 32.7,
                longitude: 36.5667,
                description: assoidaa.description!,
                image: assoidaa.photo!,
              ),
            if (deirEzzor != null)
              Governorate(
                name: deirEzzor.cityName!,
                latitude: 35.3333,
                longitude: 40.15,
                description: deirEzzor.description!,
                image: deirEzzor.photo!,
              ),
            if (alHasakah != null)
              Governorate(
                name: alHasakah.cityName!,
                latitude: 36.4833,
                longitude: 40.75,
                description: alHasakah.description!,
                image: alHasakah.photo!,
              ),
            if (raqqa != null)
              Governorate(
                name: raqqa.cityName!,
                latitude: 35.95,
                longitude: 39.0167,
                description: raqqa.description!,
                image: raqqa.photo!,
              ),
            if (qunitra != null)
              Governorate(
                name: qunitra.cityName!,
                latitude: 33.1256,
                longitude: 35.8236,
                description: qunitra.description!,
                image: qunitra.photo!,
              ),
          ];
        }
      },
      builder: (context, state) {
        if (state is CitySuccess) {
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
        } else if (state is CityFailuer) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.wifi_off,
                  size: 80,
                  color: Colors.grey.withOpacity(0.6),
                ),
                const SizedBox(height: 16),
                Text(
                  AppLocalizations.of(context)!.offlineTitle,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  AppLocalizations.of(context)!.offlineDescription,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[700],
                  ),
                ),
              ],
            ),
          );
        } else {
          return const LinearProgressIndicator(color: Colors.white);
        }
      },
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
            _buildGovernorateLabel(governorate.name ?? ''),
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
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 200,
              width: 300,
              child: governorate.image != null && governorate.image!.isNotEmpty
                  ? Image.network(
                      governorate.image!,
                      fit: BoxFit.cover,
                    )
                  : const SizedBox.shrink(),
            ),
            Text(
              governorate.name ?? '',
              style: const TextStyle(
                overflow: TextOverflow.ellipsis,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              governorate.description ?? '',
              textAlign: TextAlign.justify,
              style: const TextStyle(fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }
}
