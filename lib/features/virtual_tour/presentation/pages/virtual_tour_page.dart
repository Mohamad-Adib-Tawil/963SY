import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../controllers/virtual_tour_controller.dart';
import 'package:photo_view/photo_view.dart';

class VirtualTourPage extends StatefulWidget {
  const VirtualTourPage({super.key});

  @override
  State<VirtualTourPage> createState() => _VirtualTourPageState();
}

class _VirtualTourPageState extends State<VirtualTourPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<VirtualTourController>().loadScenes();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Virtual Tour'),
        actions: [
          IconButton(
            icon: const Icon(Icons.info_outline),
            onPressed: () {
              _showSceneInfo(context);
            },
          ),
        ],
      ),
      body: Consumer<VirtualTourController>(
        builder: (context, controller, child) {
          if (controller.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (controller.error != null) {
            return Center(
              child: Text('Error: ${controller.error}'),
            );
          }

          if (controller.currentScene == null) {
            return const Center(
              child: Text('No scenes available'),
            );
          }

          return Stack(
            children: [
              // 360° Image Viewer
              PhotoView(
                imageProvider: AssetImage(controller.currentScene!.imagePath),
                minScale: PhotoViewComputedScale.contained,
                maxScale: PhotoViewComputedScale.covered * 2,
                enableRotation: true,
                backgroundDecoration: const BoxDecoration(
                  color: Colors.black,
                ),
              ),

              // Scene Navigation
              Positioned(
                bottom: 16,
                left: 16,
                right: 16,
                child: _buildSceneNavigation(controller),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildSceneNavigation(VirtualTourController controller) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.5),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            controller.currentScene?.name ?? '',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: controller.scenes.map((scene) {
                final isCurrent = scene.id == controller.currentScene?.id;
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: GestureDetector(
                    onTap: () => controller.navigateToScene(scene.id),
                    child: Container(
                      width: 80,
                      height: 60,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: isCurrent ? Colors.blue : Colors.transparent,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(4),
                        child: Image.asset(
                          scene.imagePath,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  void _showSceneInfo(BuildContext context) {
    final controller = context.read<VirtualTourController>();
    final scene = controller.currentScene;
    if (scene == null) return;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(scene.name),
        content: Text(scene.description),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }
}
