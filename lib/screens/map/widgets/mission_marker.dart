import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:trakios/theme/text_styles.dart';
import 'package:trakios/widgets/modal/modal.dart';
import 'package:trakios/widgets/styled_button/styled_button.dart';

class MissionMarker extends StatelessWidget {
  const MissionMarker({
    super.key,
    required this.onPressed,
    required this.mission,
  });

  final AsyncCallback onPressed;
  final Map<dynamic, dynamic> mission;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Icon(
        Icons.where_to_vote_rounded,
        size: 50,
        color: Theme.of(context).primaryColor,
      ),
      onTap: () => Modal.showModal(context, _buildModal(context)),
    );
  }

  Widget _buildModal(BuildContext context) => Column(
    children: [
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        spacing: 18,
        children: [
          if (mission['images'] != null && mission['images']![0] != null)
            Container(
              height: 100,
              width: 100,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(5)),
                image: DecorationImage(
                  image: AssetImage(mission['images'][0]['url']),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          Flexible(
            child: Column(
              children: [
                Text(mission['name'], style: AppTextStyles.title(context)),
                Text(mission['notes'], style: AppTextStyles.body(context)),
              ],
            ),
          ),
        ],
      ),

      SizedBox(height: 24),
      // TODO: develop on pressed
      StyledButton(
        onPressed: onPressed,
        text: 'Start Mission',
        textColor: Theme.of(context).colorScheme.onPrimary,
        color: Theme.of(context).colorScheme.primary,
      ),
    ],
  );
}
