import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:trakios/widgets/modal/modal.dart';
import 'package:trakios/widgets/modal/modals/mission_modal.dart';

class MissionMarker extends StatelessWidget {
  const MissionMarker({
    super.key,
    required this.onPressed,
    required this.mission,
  });

  final AsyncCallback onPressed;
  final Map<String, dynamic> mission;

  @override
  Widget build(BuildContext context) {
    // Determine which icon to use based on mission status
    final String iconPath = mission['status'] == 'completed' 
        ? 'assets/images/icons/mission_completed.png'
        : 'assets/images/icons/mission_active.png';
    
    return InkWell(
      child: Image.asset(
        iconPath,
        width: 80,
        height: 80,
        fit: BoxFit.contain,
      ),
      onTap: () => Modal.showModal(
        context,
        MissionModal(mission: mission, context: context),
      ),
    );
  }
}
