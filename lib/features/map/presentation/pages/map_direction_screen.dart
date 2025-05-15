import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class MapDirectionScreen extends StatelessWidget {
  final String placeName;
  final double latitude;
  final double longitude;

  const MapDirectionScreen({
    super.key,
    required this.placeName,
    required this.latitude,
    required this.longitude,
  });

  void _openInGoogleMaps() async {
    final url =
        'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      // Handle error
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Directions to $placeName')),
      body: Column(
        children: [
          Expanded(
            child: GoogleMap(
              initialCameraPosition: CameraPosition(
                target: LatLng(latitude, longitude),
                zoom: 15,
              ),
              markers: {
                Marker(
                  markerId: const MarkerId('destination'),
                  position: LatLng(latitude, longitude),
                  infoWindow: InfoWindow(title: placeName),
                ),
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton.icon(
              onPressed: _openInGoogleMaps,
              icon: const Icon(Icons.map),
              label: const Text('Open in Google Maps'),
            ),
          ),
        ],
      ),
    );
  }
}
