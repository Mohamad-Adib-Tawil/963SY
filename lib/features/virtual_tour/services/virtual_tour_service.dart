import '../data/models/scene_model.dart';

abstract class VirtualTourService {
  Future<List<Scene>> getScenes();
}

class VirtualTourServiceImpl implements VirtualTourService {
  @override
  Future<List<Scene>> getScenes() async {
    final scenes = <Scene>[];

    // Define the base path for the virtual tour
    const basePath = 'assets/virtual_tour/Suwayda_AR_THahrEljbal/media';

    // List of panorama directories
    final panoramaDirs = [
      'panorama_0F54907C_05F6_71F4_4187_8147D51E402A_0',
      'panorama_0F48B5AD_05F6_5315_418E_30C79FBC493A_0',
      'panorama_0F2BBAD8_05F6_713C_4176_CEF8C54EBB2B_0',
      'panorama_0E3BD542_05F6_B30C_4171_AB17DB53A09B_0',
    ];

    // Create scenes for each panorama
    for (final dir in panoramaDirs) {
      final imagePath = '$basePath/$dir/panorama.jpg';
      scenes.add(Scene(
        id: dir,
        name: _getSceneName(dir),
        description: 'وصف المشهد ${_getSceneName(dir)}',
        imagePath: imagePath,
        hotspots: [],
        initialView: {
          'yaw': 0.0,
          'pitch': 0.0,
          'fov': 90.0,
        },
      ));
    }

    return scenes;
  }

  String _getSceneName(String dirName) {
    // Extract a meaningful name from the directory name
    final parts = dirName.split('_');
    if (parts.length > 1) {
      return 'مشهد ${parts[1]}';
    }
    return dirName;
  }
}
