import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_location_marker/flutter_map_location_marker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:trakios/assets/missions.dart';
import 'package:trakios/providers/profile/balance_provider.dart';
import 'package:trakios/screens/map/widgets/mission_marker.dart';
import 'package:trakios/theme/text_styles.dart';
import 'package:trakios/utilities/mission_utils.dart';

class MapScreen extends ConsumerStatefulWidget {
  const MapScreen({super.key});

  @override
  ConsumerState<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends ConsumerState<MapScreen> {
  late final MapController _mapController = MapController();
  bool _tracking = false;

  /// Custom style for the user location marker
  static const _markerStyle = LocationMarkerStyle(
    marker: DefaultLocationMarker(
      color: Colors.blue,
      child: Icon(Icons.navigation, color: Colors.white),
    ),
    markerSize: Size(40, 40),
    accuracyCircleColor: Color.fromARGB(80, 50, 120, 255),
  );

  /// Get the user's current location as a LatLng
  Future<LatLng?> _getUserLocation() async {
    // Check if location services are enabled
    if (!await Geolocator.isLocationServiceEnabled()) {
      _showSnack('Location services are disabled');
      return null;
    }

    // Check and request permissions if needed
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    if (permission == LocationPermission.denied) {
      _showSnack('Location permission denied');
      return null;
    }

    if (permission == LocationPermission.deniedForever) {
      _showSnack('Location permission permanently denied');
      return null;
    }

    // Get the user's current position
    final position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    return LatLng(position.latitude, position.longitude);
  }

  /// Helper to show a simple message on screen
  void _showSnack(String message) {
    if (!mounted) return;
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  /// Toggle tracking mode and move the map to user's location if enabled
  Future<void> _toggleTracking() async {
    setState(() => _tracking = !_tracking);

    if (_tracking) {
      final userLatLng = await _getUserLocation();
      if (userLatLng != null) {
        _mapController.move(userLatLng, 16);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    onPressed(Map<String, dynamic> mission) async {
      await MissionUtils.attemptMissionCompletion(context, ref, mission);
    }

    return FutureBuilder<LatLng?>(
      future: _getUserLocation(),
      builder: (context, snapshot) {
        // Show loading indicator while fetching location
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        // If we couldn’t get the location, show an error message
        final userLocation = snapshot.data;
        if (userLocation == null) {
          return const Scaffold(
            body: Center(child: Text('Unable to retrieve location')),
          );
        }

        final balanceProvider = ref.watch(tokenBalanceProvider);
        // Build the map once we have a valid location
        return Scaffold(
          body: Column(
            children: [
              // Header with TRAKIOS title and user tokens
              Container(
                width: double.infinity,
                padding: const EdgeInsets.only(
                  top: 50, // Account for status bar
                  left: 24,
                  right: 24,
                  bottom: 16,
                ),
                decoration: BoxDecoration(
                  color: Theme.of(context).appBarTheme.backgroundColor,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image.asset(
                      'assets/images/logo/text_logo.png',
                      height: 20,
                      fit: BoxFit.contain,
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      // decoration: BoxDecoration(
                      //   color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.2),
                      //   borderRadius: BorderRadius.circular(20),
                      //   border: Border.all(
                      //     color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.4),
                      //     width: 1,
                      //   ),
                      // ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.token_rounded,
                            color: Theme.of(context).colorScheme.primary,
                            size: 16,
                          ),
                          SizedBox(width: 4),

                          Text(
                            balanceProvider.toString(),
                            style: AppTextStyles.subtitle(context).copyWith(
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              // Map container
              Expanded(
                child: FlutterMap(
                  mapController: _mapController,
                  options: MapOptions(
                    initialCenter: userLocation,
                    initialZoom: 15,
                  ),
                  children: [
                    // Base map layer (Carto Voyager)
                    TileLayer(
                      urlTemplate:
                          "https://{s}.basemaps.cartocdn.com/rastertiles/voyager/{z}/{x}/{y}{r}.png",
                      userAgentPackageName:
                          'com.trakios.trakios - info@trakios.com',
                    ),

                    // Map attribution info
                    RichAttributionWidget(
                      attributions: [
                        TextSourceAttribution(
                          '© OpenStreetMap contributors',
                          onTap: () {},
                        ),
                      ],
                    ),
                    // User’s current location and compass
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
                    MarkerLayer(
                      markers: [
                        ...missions.map((mission) {
                          final missionCoordinate = LatLng(
                            mission['latitude'],
                            mission['longitude'],
                          );
                          return Marker(
                            point: missionCoordinate,
                            width: 60,
                            height: 60,
                            child: MissionMarker(
                              onPressed: () => onPressed(mission),
                              mission: mission,
                            ),
                          );
                        }),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),

          // Floating action button to toggle tracking mode
          floatingActionButton: FloatingActionButton(
            backgroundColor: _tracking ? Colors.blue : Colors.grey[700],
            onPressed: _toggleTracking,
            child: Icon(
              _tracking ? Icons.my_location : Icons.location_searching,
              color: Colors.white,
            ),
          ),
        );
      },
    );
  }
}
