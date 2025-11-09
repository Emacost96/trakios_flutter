import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:trakios/assets/missions.dart';
import 'package:trakios/theme/text_styles.dart';
import 'package:trakios/widgets/styled_button/styled_button.dart';
import 'package:trakios/utilities/mission_utils.dart';

class MissionDetail extends ConsumerStatefulWidget {
  const MissionDetail({super.key, required this.id});
  final String id;

  @override
  ConsumerState<MissionDetail> createState() => _MissionDetailState();
}

class _MissionDetailState extends ConsumerState<MissionDetail> {
  Map<String, dynamic>? mission;

  @override
  void initState() {
    super.initState();
    _loadMission();
  }

  void _loadMission() {
    final missionId = int.tryParse(widget.id);
    if (missionId != null) {
      try {
        mission = missions.firstWhere((m) => m['id'] == missionId);
        setState(() {});
      } catch (e) {
        // Mission not found
        mission = null;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (mission == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Mission Not Found')),
        body: const Center(child: Text('Mission not found')),
      );
    }

    final String name = mission!['name'] ?? 'Unknown Mission';
    final String type = mission!['type'] ?? '';
    final String shortDescription = mission!['shortDescription'] ?? '';
    final String notes = mission!['notes'] ?? '';
    final String status = mission!['status'] ?? 'active';
    final int token = (mission!['token'] ?? 0);
    final List<dynamic> images = mission!['images'] ?? [];

    String? imageUrl;
    if (images.isNotEmpty && images[0] is Map && images[0]['url'] is String) {
      imageUrl = images[0]['url'] as String;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(name, style: AppTextStyles.subtitle(context)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
        backgroundColor: Theme.of(context).colorScheme.surface,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // HERO IMAGE
            if (imageUrl != null)
              Container(
                width: double.infinity,
                height: 250,
                child: _MissionDetailImage(url: imageUrl),
              ),

            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // TITLE AND STATUS
                  Row(
                    children: [
                      Expanded(
                        child: Text(name, style: AppTextStyles.title(context)),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: status == 'completed'
                              ? Theme.of(
                                  context,
                                ).colorScheme.primary.withValues(alpha: 0.1)
                              : Theme.of(
                                  context,
                                ).colorScheme.secondary.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          status == 'completed' ? 'Completed' : 'Active',
                          style: AppTextStyles.caption(context).copyWith(
                            color: status == 'completed'
                                ? Theme.of(context).colorScheme.primary
                                : Theme.of(context).colorScheme.secondary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 12),

                  // TYPE AND TOKEN
                  Row(
                    children: [
                      if (type.isNotEmpty) ...[
                        Icon(
                          Icons.category_outlined,
                          size: 16,
                          color: Theme.of(
                            context,
                          ).colorScheme.onSurface.withValues(alpha: 0.6),
                        ),
                        const SizedBox(width: 6),
                        Text(
                          type,
                          style: AppTextStyles.caption(
                            context,
                          ).copyWith(fontStyle: FontStyle.italic),
                        ),
                        const SizedBox(width: 16),
                      ],
                      Icon(
                        Icons.token_rounded,
                        size: 16,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        '${token} tokens',
                        style: AppTextStyles.caption(context).copyWith(
                          fontWeight: FontWeight.w600,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  // SHORT DESCRIPTION
                  if (shortDescription.isNotEmpty) ...[
                    Text('Overview', style: AppTextStyles.subtitle(context)),
                    const SizedBox(height: 8),
                    Text(shortDescription, style: AppTextStyles.body(context)),
                    const SizedBox(height: 20),
                  ],

                  // DETAILED DESCRIPTION
                  if (notes.isNotEmpty) ...[
                    Text('Description', style: AppTextStyles.subtitle(context)),
                    const SizedBox(height: 8),
                    Text(
                      notes,
                      style: AppTextStyles.body(context).copyWith(height: 1.6),
                    ),
                    const SizedBox(height: 20),
                  ],

                  // MISSION DETAILS
                  if (mission!['mission'] != null) ...[
                    Text(
                      'Mission Details',
                      style: AppTextStyles.subtitle(context),
                    ),
                    const SizedBox(height: 12),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Theme.of(
                          context,
                        ).colorScheme.surfaceContainerHighest,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (mission!['mission']['type'] != null) ...[
                            Row(
                              children: [
                                Icon(
                                  Icons.task_alt,
                                  size: 18,
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  'Type: ${mission!['mission']['type']}',
                                  style: AppTextStyles.bodySmall(
                                    context,
                                  ).copyWith(fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                          ],
                          if (mission!['mission']['description'] != null) ...[
                            Text(
                              mission!['mission']['description'],
                              style: AppTextStyles.bodySmall(context),
                            ),
                          ],
                        ],
                      ),
                    ),
                    const SizedBox(height: 30),
                  ],

                  // LOCATION INFO
                  if (mission!['latitude'] != null &&
                      mission!['longitude'] != null) ...[
                    Text('Location', style: AppTextStyles.subtitle(context)),
                    const SizedBox(height: 12),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Theme.of(
                          context,
                        ).colorScheme.surfaceContainerHighest,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.location_on,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Coordinates',
                                  style: AppTextStyles.bodySmall(
                                    context,
                                  ).copyWith(fontWeight: FontWeight.w500),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  'Lat: ${mission!['latitude']}, Lng: ${mission!['longitude']}',
                                  style: AppTextStyles.caption(context),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 30),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          border: Border(
            top: BorderSide(
              color: Theme.of(
                context,
              ).colorScheme.outline.withValues(alpha: 0.2),
              width: 1,
            ),
          ),
        ),
        child: SafeArea(
          child: SizedBox(
            width: double.infinity,
            child: status == 'completed'
                ? ElevatedButton(
                    onPressed: null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.surface,
                      foregroundColor: Theme.of(
                        context,
                      ).colorScheme.onSurface.withValues(alpha: 0.6),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      minimumSize: const Size(double.infinity, 60),
                    ),
                    child: Text(
                      'Completed',
                      style: AppTextStyles.button(context).copyWith(
                        color: Theme.of(
                          context,
                        ).colorScheme.onSurface.withValues(alpha: 0.6),
                      ),
                    ),
                  )
                : StyledButton(
                    onPressed: () async {
                      await MissionUtils.attemptMissionCompletion(
                        context,
                        ref,
                        mission!,
                      );
                    },
                    text: 'Start Mission',
                    color: Theme.of(context).colorScheme.primary,
                    textColor: Theme.of(context).colorScheme.onPrimary,
                  ),
          ),
        ),
      ),
    );
  }
}

class _MissionDetailImage extends StatelessWidget {
  final String url;

  const _MissionDetailImage({required this.url});

  @override
  Widget build(BuildContext context) {
    // Se inizia con 'assets/' -> è un asset locale
    if (url.startsWith('assets/')) {
      return Image.asset(
        url,
        width: double.infinity,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return Container(
            width: double.infinity,
            color: Theme.of(context).colorScheme.surfaceContainerHighest,
            child: Icon(
              Icons.image_not_supported,
              size: 60,
              color: Theme.of(
                context,
              ).colorScheme.onSurface.withValues(alpha: 0.4),
            ),
          );
        },
      );
    }

    // Se ho URL http/https -> carico in rete
    return Image.network(
      url,
      width: double.infinity,
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) {
        return Container(
          width: double.infinity,
          color: Theme.of(context).colorScheme.surfaceContainerHighest,
          child: Icon(
            Icons.image_not_supported,
            size: 60,
            color: Theme.of(
              context,
            ).colorScheme.onSurface.withValues(alpha: 0.4),
          ),
        );
      },
    );
  }
}
