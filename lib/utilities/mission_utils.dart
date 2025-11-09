import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:trakios/utilities/geo_utils.dart';

class MissionUtils {
  /// Check if the user is close enough to complete a mission
  static Future<bool> checkMissionProximity(Map<String, dynamic> mission) async {
    // Get mission coordinates
    final double? latitude = mission['latitude']?.toDouble();
    final double? longitude = mission['longitude']?.toDouble();
    
    if (latitude == null || longitude == null) {
      return false; // Cannot check proximity without coordinates
    }
    
    final missionCoordinate = LatLng(latitude, longitude);
    
    // Get user's current position
    final position = await GeoUtils.getUserPosition();
    if (position == null) {
      return false; // Cannot check proximity without user position
    }
    
    // Check if user is within 10 meters
    return GeoUtils.isCloserTahn10Meters(position, missionCoordinate);
  }
  
  /// Attempt to start/complete a mission with proximity check
  static Future<void> attemptMissionCompletion(
    BuildContext context, 
    Map<String, dynamic> mission,
  ) async {
    final isCloseEnough = await checkMissionProximity(mission);
    
    if (!context.mounted) return;
    
    if (isCloseEnough) {
      _showMessage(context, 'Mission Accomplished! 🎉');
      // TODO: Update mission status to completed
      // TODO: Add tokens to user account
    } else {
      _showMessage(context, 'Try Again - Get closer to the location 📍');
    }
  }
  
  /// Show a message to the user
  static void _showMessage(BuildContext context, String message) {
    if (!context.mounted) return;
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 3),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}