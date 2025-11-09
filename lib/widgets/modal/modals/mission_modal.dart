import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:trakios/theme/text_styles.dart';
import 'package:trakios/widgets/styled_button/styled_button.dart';

class MissionModal extends StatelessWidget {
  const MissionModal({
    super.key,
    required this.mission,
    required this.onPressed,
    required this.context,
  });

  final Map mission;
  final AsyncCallback onPressed;
  final BuildContext context;

  @override
  Widget build(BuildContext context) => Column(
    children: [
      Stack(
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
          Positioned(
            top: 0,
            right: 0,
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
                context.go('/missions/${mission['id']}');
              },
              child: Container(
                padding: const EdgeInsets.all(8),
                child: Icon(
                  Icons.info_outline,
                  size: 20,
                  color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.7),
                ),
              ),
            ),
          ),
        ],
      ),

      SizedBox(height: 24),
      StyledButton(
        onPressed: onPressed,
        text: 'Start Mission',
        textColor: Theme.of(context).colorScheme.onPrimary,
        color: Theme.of(context).colorScheme.primary,
      ),
    ],
  );
}
