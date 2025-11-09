// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:trakios/utilities/geo_utils.dart';
import 'package:trakios/utilities/image_utils.dart';

class MissionUtils {
  /// Check if the user is close enough to complete a mission
  static Future<bool> checkMissionProximity(
    Map<String, dynamic> mission,
  ) async {
    // Get mission coordinates
    final double? latitude = mission['latitude'] ?? 0.0;
    final double? longitude = mission['longitude'] ?? 0.0;

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
  static Future<File?> attemptMissionCompletion(
    BuildContext context,
    Map<String, dynamic> mission,
  ) async {
    final isCloseEnough = await checkMissionProximity(mission);

    if (!context.mounted) return null;

    if (isCloseEnough) {
      final image = await pickImageFromCamera();

      if (image != null) {
        await showDialog(
          context: context,
          barrierDismissible: true, // user must tap button!
          builder: (BuildContext context) {
            return AlertDialog(
              insetPadding: EdgeInsets.zero,
              backgroundColor: Colors.transparent,
              contentPadding: EdgeInsets.zero,
              content: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Stack(
                  children: [
                    // Immagine
                    Container(
                      height: MediaQuery.of(context).size.width * 0.8,
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: Image.file(image, fit: BoxFit.cover),
                    ),
                    // Bottone chiudi in alto a destra
                    Positioned(
                      top: 8,
                      right: 8,
                      child: Container(
                        height: 20,
                        width: 20,
                        decoration: BoxDecoration(
                          color: Colors.black45, // sfondo semi-trasparente
                          shape: BoxShape.circle,
                        ),
                        child: IconButton(
                          icon: Icon(Icons.close, color: Colors.white),
                          onPressed: () => Navigator.of(context).pop(),
                          iconSize: 18,
                          padding: EdgeInsets.zero,
                          constraints: BoxConstraints(),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
        _showMessage(context, 'Mission Accomplished your earnd ${mission['token']} Trakios Coins ❤️');

        return image;
      } else {
        _showMessage(context, 'Photo upload failed 😞');
      }
      // TODO: Update mission status to completed
      // TODO: Add tokens to user account
    } else {
      _showMessage(context, 'Try Again - Get closer to the location 📍');
      return null;
    }
    return null;
  }

  /// Show a message to the user
  static void _showMessage(BuildContext context, String message) {
    if (!context.mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 5),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}
