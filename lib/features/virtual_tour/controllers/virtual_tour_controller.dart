import 'package:flutter/material.dart';
import '../data/models/scene_model.dart';
import '../services/virtual_tour_service.dart';

class VirtualTourController extends ChangeNotifier {
  final VirtualTourService _service;
  List<Scene> _scenes = [];
  Scene? _currentScene;
  bool _isLoading = false;
  String? _error;
  Map<String, double> _currentView = {
    'yaw': 0.0,
    'pitch': 0.0,
    'fov': 90.0,
  };

  VirtualTourController(this._service);

  List<Scene> get scenes => _scenes;
  Scene? get currentScene => _currentScene;
  bool get isLoading => _isLoading;
  String? get error => _error;
  Map<String, double> get currentView => _currentView;

  Future<void> loadScenes() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _scenes = await _service.getScenes();
      if (_scenes.isNotEmpty) {
        _currentScene = _scenes.first;
        _currentView = _currentScene!.initialView;
      }
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void navigateToScene(String sceneId) {
    final scene = _scenes.firstWhere((s) => s.id == sceneId);
    _currentScene = scene;
    _currentView = scene.initialView;
    notifyListeners();
  }

  void updateView(Map<String, double> newView) {
    _currentView = newView;
    notifyListeners();
  }

  void handleHotspotTap(String hotspotId) {
    // TODO: Implement hotspot navigation logic
    print('Hotspot tapped: $hotspotId');
  }
}
