import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_location_marker/flutter_map_location_marker.dart';
import 'package:latlong2/latlong.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final MapController _mapController = MapController();

  /// Modalità attuale: se true, la mappa segue automaticamente la posizione utente
  bool _tracking = false;

  /// Stile marker personalizzato
  final _markerStyle = const LocationMarkerStyle(
    marker: DefaultLocationMarker(
      color: Colors.blue,
      child: Icon(Icons.navigation, color: Colors.white),
    ),
    markerSize: Size(40, 40),
    accuracyCircleColor: Color.fromARGB(80, 50, 120, 255),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FlutterMap(
        mapController: _mapController,
        options: const MapOptions(
          initialCenter: LatLng(
            41.9028,
            12.4964,
          ), // Roma come posizione iniziale
          initialZoom: 13,
        ),
        children: [
          // Layer base (OpenStreetMap)
          TileLayer(
            urlTemplate:
                "https://{s}.basemaps.cartocdn.com/rastertiles/voyager/{z}/{x}/{y}{r}.png",

            userAgentPackageName: 'com.trakios.trakios - info@trakios.com',
          ),
          RichAttributionWidget(
            attributions: [
              TextSourceAttribution(
                '© OpenStreetMap contributors',
                onTap: () {
                  // Logica per aprire il link https://www.openstreetmap.org/copyright
                },
              ),
            ],
          ),

          // Layer della posizione e bussola
          CurrentLocationLayer(
            style: _markerStyle,

            alignPositionOnUpdate: _tracking
                ? AlignOnUpdate.always
                : AlignOnUpdate.never,
            alignDirectionOnUpdate: _tracking
                ? AlignOnUpdate.always
                : AlignOnUpdate.never,

            moveAnimationDuration: const Duration(milliseconds: 300),
          ),
        ],
      ),

      floatingActionButton: FloatingActionButton(
        backgroundColor: _tracking ? Colors.blue : Colors.grey[700],
        onPressed: () {
          setState(() {
            _tracking = !_tracking;
          });

          if (_tracking) {
            // Centra subito sulla posizione corrente
            _mapController.move(_mapController.camera.center, 16);
          }
        },
        child: Icon(
          _tracking ? Icons.my_location : Icons.location_searching,
          color: Colors.white,
        ),
      ),
    );
  }
}
