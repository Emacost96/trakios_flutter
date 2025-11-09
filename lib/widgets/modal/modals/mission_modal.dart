import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:trakios/theme/text_styles.dart';
import 'package:trakios/widgets/styled_button/styled_button.dart';
import 'package:trakios/utilities/mission_utils.dart';

class MissionModal extends ConsumerWidget {
  const MissionModal({super.key, required this.mission, required this.context});

  final Map<String, dynamic> mission;
  final BuildContext context;

  @override
  Widget build(BuildContext context, WidgetRef ref) => Column(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        spacing: 18,
        children: [
          if (mission['images'] != null && mission['images']![0] != null)
            Flexible(
              flex: 3,
              child: Padding(
                padding: EdgeInsets.only(top: 8),
                child: Container(
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
              ),
            ),
          Flexible(
            flex: 7,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(mission['name'], style: AppTextStyles.title(context)),
                Text(mission['notes'], style: AppTextStyles.body(context)),
              ],
            ),
          ),
          Flexible(
            flex: 1,
            child: SizedBox(
              height: 25,
              width: 25,
              child: Center(
                child: IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    context.push('/missions/${mission['id']}');
                  },
                  icon: Icon(
                    Icons.info_outline,
                    size: 20,
                    color: Theme.of(
                      context,
                    ).colorScheme.onSurface.withValues(alpha: 0.7),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      SizedBox(height: 24),
      if (mission['mission']?['type'] != null &&
          mission['mission']?['type'] == 'photo')
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              Icons.camera,
              size: 20,
              color: Theme.of(context).colorScheme.onPrimary,
            ),
            SizedBox(width: 8),
            Expanded(
              child: Text(
                mission['mission']?['description'],
                style: AppTextStyles.caption(context),
              ),
            ),
          ],
        ),

      SizedBox(height: 14),
      StyledButton(
        onPressed: () async {
          await MissionUtils.attemptMissionCompletion(context, ref, mission);
          if (context.mounted) {
            Navigator.of(context).pop();
          }
        },
        text: 'Start Mission',
        textColor: Theme.of(context).colorScheme.onPrimary,
        color: Theme.of(context).colorScheme.primary,
      ),
    ],
  );
}
