import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:untitled4/features/services/domain/models/service_item_model.dart';
import 'package:flutter/material.dart';
import 'package:untitled4/l10n/app_localizations.dart';

part 'services_event.dart';
part 'services_state.dart';

class ServicesBloc extends Bloc<ServicesEvent, ServicesState> {
  ServicesBloc() : super(ServicesInitial()) {
    on<LoadServices>(_onLoadServices);
    on<ChangeGovernorate>(_onChangeGovernorate);
    on<ChangeCategory>(_onChangeCategory);
    on<InitialLoad>(_onInitialLoad);
  }

  final Map<String, Map<String, List<ServiceItemModel>>> governorateData = {
    'damascus': {
      'restaurants': [
        const ServiceItemModel(
            name: 'Al Abraaj', details: 'Seafood & grilled dishes'),
        const ServiceItemModel(
            name: 'Villa Mamas', details: 'Traditional Syrian cuisine'),
      ],
      'cafes': [
        const ServiceItemModel(
            name: 'Cafe Lilou', details: 'French-style bakery & coffee'),
        const ServiceItemModel(
            name: 'Dose Cafe', details: 'Trendy cafe with great ambiance'),
      ],
    },
    'aleppo': {
      'restaurants': [
        const ServiceItemModel(
            name: 'Mohammed Noor', details: 'Grilled Middle Eastern dishes'),
      ],
      'cafes': [
        const ServiceItemModel(
            name: 'Seven Cafe', details: 'Historic city center coffee shop'),
      ],
    },
    'homs': {
      'restaurants': [
        const ServiceItemModel(
            name: 'Al Hamra', details: 'Traditional Syrian dishes'),
      ],
      'cafes': [
        const ServiceItemModel(
            name: 'Al Nawfara', details: 'Historic cafe with fountain'),
      ],
    },
    'latakia': {
      'restaurants': [
        const ServiceItemModel(name: 'Sea View', details: 'Seafood restaurant'),
      ],
      'cafes': [
        const ServiceItemModel(
            name: 'Corniche Cafe', details: 'Seaside coffee shop'),
      ],
    },
  };

  List<String> getCategories(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return [
      l10n.restaurants,
      l10n.cafes,
      l10n.hotels,
      l10n.tourServices,
      l10n.publicServices,
      l10n.hospitals,
    ];
  }

  String getCategoryKey(String category, BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    if (category == l10n.restaurants) return 'restaurants';
    if (category == l10n.cafes) return 'cafes';
    if (category == l10n.hotels) return 'hotels';
    if (category == l10n.tourServices) return 'tourServices';
    if (category == l10n.publicServices) return 'publicServices';
    if (category == l10n.hospitals) return 'hospitals';
    return 'restaurants'; // default
  }

  String getGovernorateKey(String governorate, BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    if (governorate == l10n.damascus) return 'damascus';
    if (governorate == l10n.aleppo) return 'aleppo';
    if (governorate == l10n.homs) return 'homs';
    if (governorate == l10n.latakia) return 'latakia';
    return 'damascus'; // default
  }

  List<String> getGovernorates(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return [
      l10n.damascus,
      l10n.aleppo,
      l10n.homs,
      l10n.latakia,
    ];
  }

  void _onLoadServices(LoadServices event, Emitter<ServicesState> emit) async {
    try {
      emit(ServicesLoading());

      final categoryKey = getCategoryKey(event.category, event.context);
      final governorateKey =
          getGovernorateKey(event.governorate, event.context);
      final services = governorateData[governorateKey]?[categoryKey] ?? [];

      final governorates = getGovernorates(event.context);
      final categories = getCategories(event.context);

      emit(ServicesLoaded(
        selectedGovernorate: governorates.first,
        selectedCategory: categories.first,
        services: services,
        governorates: governorates,
        categories: categories,
      ));
    } catch (e) {
      emit(ServicesError(e.toString()));
    }
  }

  void _onChangeGovernorate(
      ChangeGovernorate event, Emitter<ServicesState> emit) {
    if (state is ServicesLoaded) {
      final currentState = state as ServicesLoaded;
      add(LoadServices(
        governorate: event.governorate,
        category: currentState.selectedCategory,
        context: event.context,
      ));
    }
  }

  void _onChangeCategory(ChangeCategory event, Emitter<ServicesState> emit) {
    if (state is ServicesLoaded) {
      final currentState = state as ServicesLoaded;
      add(LoadServices(
        governorate: currentState.selectedGovernorate,
        category: event.category,
        context: event.context,
      ));
    }
  }

  void _onInitialLoad(InitialLoad event, Emitter<ServicesState> emit) {
    emit(ServicesLoaded(
      selectedGovernorate: 'damascus',
      selectedCategory: 'restaurants',
      services: governorateData['damascus']?['restaurants'] ?? [],
      governorates: const ['damascus', 'aleppo', 'homs', 'latakia'],
      categories: const [
        'restaurants',
        'cafes',
        'hotels',
        'tourServices',
        'publicServices',
        'hospitals'
      ],
    ));
  }
}
