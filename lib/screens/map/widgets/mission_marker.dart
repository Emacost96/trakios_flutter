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
    return InkWell(
      child: Icon(
        Icons.where_to_vote_rounded,
        size: 50,
        color: Theme.of(context).primaryColor,
      ),
      onTap: () => Modal.showModal(
        context,
        MissionModal(mission: mission, context: context),
      ),
    );
  }
}
