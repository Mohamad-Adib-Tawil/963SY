import 'dart:io';
import 'package:image/image.dart' as img;
import 'package:path/path.dart' as path;

void main() async {
  final sourceImage = File('assets/icons/photo_2025-05-06_18-35-23.jpg');
  if (!await sourceImage.exists()) {
    print('Source image not found!');
    return;
  }

  final image = img.decodeImage(await sourceImage.readAsBytes());
  if (image == null) {
    print('Failed to decode image!');
    return;
  }

  // Android icons
  final androidSizes = {
    'mipmap-mdpi': 48,
    'mipmap-hdpi': 72,
    'mipmap-xhdpi': 96,
    'mipmap-xxhdpi': 144,
    'mipmap-xxxhdpi': 192,
  };

  print('Generating Android icons...');
  for (final entry in androidSizes.entries) {
    final resized = img.copyResize(
      image,
      width: entry.value,
      height: entry.value,
    );
    final outputDir = Directory('android/app/src/main/res/${entry.key}');
    if (!await outputDir.exists()) {
      await outputDir.create(recursive: true);
    }
    await File('${outputDir.path}/ic_launcher.png')
        .writeAsBytes(img.encodePng(resized));
    print('Generated ${entry.key} icon');
  }

  // iOS icons
  final iosIcons = [
    {
      'size': 20,
      'scales': [1, 2, 3]
    },
    {
      'size': 29,
      'scales': [1, 2, 3]
    },
    {
      'size': 40,
      'scales': [1, 2, 3]
    },
    {
      'size': 60,
      'scales': [2, 3]
    },
    {
      'size': 76,
      'scales': [1, 2]
    },
    {
      'size': 83.5,
      'scales': [2]
    },
    {
      'size': 1024,
      'scales': [1]
    },
  ];

  print('Generating iOS icons...');
  for (final icon in iosIcons) {
    for (final scale in icon['scales'] as List<num>) {
      final size = ((icon['size'] as num) * scale).round();
      final resized = img.copyResize(
        image,
        width: size,
        height: size,
      );
      final outputDir =
          Directory('ios/Runner/Assets.xcassets/AppIcon.appiconset');
      if (!await outputDir.exists()) {
        await outputDir.create(recursive: true);
      }
      await File('${outputDir.path}/Icon-${icon['size']}@${scale}x.png')
          .writeAsBytes(img.encodePng(resized));
      print('Generated iOS icon size ${icon['size']} at ${scale}x');
    }
  }

  print('Icons generated successfully!');
}
