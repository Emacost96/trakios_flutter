import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:trakios/assets/campaigns.dart';
import 'package:trakios/assets/missions.dart';
import 'package:trakios/theme/text_styles.dart';
import 'package:trakios/widgets/modal/modal.dart';
import 'package:trakios/widgets/modal/modals/mission_modal.dart';

// Helper functions to connect campaigns with missions
Map<String, dynamic>? getMissionById(int missionId) {
  try {
    return missions.firstWhere((mission) => mission['id'] == missionId);
  } catch (e) {
    return null;
  }
}

List<Map<String, dynamic>> getMissionsForCampaign(int campaignId) {
  // Find the campaign first
  final campaign = campaigns.firstWhere(
    (c) => c['id'] == campaignId,
    orElse: () => {},
  );
  if (campaign.isEmpty) return [];

  // Get mission IDs from the campaign
  final missionIds = campaign['missions'] as List<dynamic>;

  // Find missions by their IDs
  final result = <Map<String, dynamic>>[];
  for (final id in missionIds) {
    final mission = getMissionById(id);
    if (mission != null) {
      result.add(mission);
    }
  }
  return result;
}

double calculateCampaignProgress(int campaignId) {
  final campaignMissions = getMissionsForCampaign(campaignId);
  if (campaignMissions.isEmpty) return 0.0;

  final completedCount = campaignMissions
      .where((mission) => mission['status'] == 'completed')
      .length;

  return completedCount / campaignMissions.length;
}

class Missions extends StatelessWidget {
  const Missions({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 0,
          bottom: const TabBar(
            dividerColor: Colors.transparent,
            tabs: [
              Tab(text: 'Campaigns'),
              Tab(text: 'Missions'),
            ],
          ),
        ),
        body: const TabBarView(children: [CampaignsTab(), MissionsTab()]),
      ),
    );
  }
}

class MissionsTab extends StatelessWidget {
  const MissionsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: missions.length,
      itemBuilder: (context, index) {
        final mission = missions[index];

        final String name = mission['name'] ?? '';
        final String shortDescription =
            mission['shortDescription'] ?? mission['notes'] ?? '';
        final String status = mission['status'] ?? 'active';
        final int token = (mission['token'] ?? 0);

        String? imageUrl;
        if (mission['images'] is List && mission['images'].isNotEmpty) {
          final first = mission['images'][0];
          if (first is Map && first['url'] is String) {
            imageUrl = first['url'] as String;
          }
        }

        return GestureDetector(
          onTap: () {
            context.push('/missions/${mission['id']}');
          },
          child: Card(
            margin: const EdgeInsets.only(bottom: 18),
            elevation: 3,
            color: status == 'completed' 
                ? Theme.of(context).colorScheme.surface.withValues(alpha: 0.4)
                : Theme.of(context).colorScheme.surface,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(22),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // IMAGE
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(22),
                  ),
                  child: _MissionImage(
                    url: imageUrl,
                    isCompleted: status == 'completed',
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // TITLE + TOKEN
                      Row(
                        children: [
                          Expanded(
                            child: Row(
                              children: [
                                Flexible(
                                  child: Text(
                                    name,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: AppTextStyles.subtitle(context),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Icon(
                                  Icons.info_outline,
                                  size: 18,
                                  color: Theme.of(context).colorScheme.onSurface
                                      .withValues(alpha: 0.6),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 12),
                          Row(
                            children: [
                              Icon(
                                Icons.token_rounded,
                                size: 16,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                              const SizedBox(width: 3),
                              Text(
                                '${token}',
                                style: AppTextStyles.caption(
                                  context,
                                ).copyWith(fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                        ],
                      ),

                      const SizedBox(height: 4),

                      // SHORT DESCRIPTION
                      Text(
                        shortDescription,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: AppTextStyles.bodySmall(context),
                      ),

                      const SizedBox(height: 10),

                      // // BUTTON FULL WIDTH
                      // SizedBox(
                      //   width: double.infinity,
                      //   child: ElevatedButton(
                      //     style: ElevatedButton.styleFrom(
                      //       elevation: 0,
                      //       backgroundColor: status == 'completed'
                      //           ? Theme.of(context).colorScheme.primary
                      //           : Theme.of(context).colorScheme.secondary,
                      //       shape: RoundedRectangleBorder(
                      //         borderRadius: BorderRadius.circular(14),
                      //       ),
                      //       padding: const EdgeInsets.symmetric(
                      //         vertical: 10,
                      //       ),
                      //     ),
                      //     onPressed: status == 'completed'
                      //         ? null
                      //         : () async {
                      //             await MissionUtils.attemptMissionCompletion(context, mission);
                      //           },
                      //     child: Text(
                      //       status == 'completed'
                      //           ? 'Completed'
                      //           : 'Start Mission',
                      //       style: AppTextStyles.button(context),
                      //     ),
                      //   ),
                      // ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _MissionImage extends StatelessWidget {
  final String? url;
  final bool isCompleted;

  const _MissionImage({this.url, this.isCompleted = false});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        _wrapWithGrayscale(_buildImage(context)),
        // Dark overlay for completed missions
        if (isCompleted)
          Container(
            width: double.infinity,
            height: 160,
            decoration: BoxDecoration(
              color: Colors.black.withValues(alpha: 0.4),
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(22),
              ),
            ),
            child: Center(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.check_circle,
                      color: Colors.white,
                      size: 20,
                    ),
                    SizedBox(width: 8),
                    Text(
                      'COMPLETED',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
      ],
    );
  }

  Widget _wrapWithGrayscale(Widget child) {
    if (!isCompleted) return child;

    return ColorFiltered(
      colorFilter: const ColorFilter.mode(Colors.grey, BlendMode.saturation),
      child: child,
    );
  }

  Widget _buildImage(BuildContext context) {
    // Se non ho URL valido -> uso un asset locale di default
    if (url == null || url!.isEmpty) {
      return Image.asset(
        'assets/images/missions/chiesa.png',
        width: double.infinity,
        height: 160,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return Container(
            width: double.infinity,
            height: 160,
            decoration: BoxDecoration(
              color: Theme.of(
                context,
              ).colorScheme.surface.withValues(alpha: 0.5),
            ),
            child: Icon(
              Icons.image_not_supported,
              size: 50,
              color: Theme.of(
                context,
              ).colorScheme.onSurface.withValues(alpha: 0.6),
            ),
          );
        },
      );
    }

    // Se inizia con 'assets/' -> è un asset locale
    if (url!.startsWith('assets/')) {
      return Image.asset(
        url!,
        width: double.infinity,
        height: 160,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          // Se asset non trovato, usa placeholder
          return Image.asset(
            'assets/images/missions/chiesa.png',
            width: double.infinity,
            height: 160,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return Container(
                width: double.infinity,
                height: 160,
                color: Theme.of(
                  context,
                ).colorScheme.surface.withValues(alpha: 0.3),
                child: Icon(
                  Icons.image_not_supported,
                  size: 50,
                  color: Theme.of(
                    context,
                  ).colorScheme.onSurface.withValues(alpha: 0.5),
                ),
              );
            },
          );
        },
      );
    }

    // Se ho URL http/https -> carico in rete con fallback
    return Image.network(
      url!,
      width: double.infinity,
      height: 160,
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) {
        // Fallback su asset locale
        return Image.asset(
          'assets/images/missions/chiesa.png',
          width: double.infinity,
          height: 160,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return Container(
              width: double.infinity,
              height: 160,
              color: Theme.of(
                context,
              ).colorScheme.surface.withValues(alpha: 0.5),
              child: Icon(
                Icons.image_not_supported,
                size: 50,
                color: Theme.of(
                  context,
                ).colorScheme.onSurface.withValues(alpha: 0.6),
              ),
            );
          },
        );
      },
    );
  }
}

class CampaignsTab extends StatefulWidget {
  const CampaignsTab({super.key});

  @override
  State<CampaignsTab> createState() => _CampaignsTabState();
}

class _CampaignsTabState extends State<CampaignsTab>
    with TickerProviderStateMixin {
  int? _expandedCampaignId;
  Map<String, dynamic>? _selectedMission;
  final Map<int, AnimationController> _animationControllers = {};

  @override
  void dispose() {
    for (final controller in _animationControllers.values) {
      controller.dispose();
    }
    super.dispose();
  }

  AnimationController _getAnimationController(int campaignId) {
    if (!_animationControllers.containsKey(campaignId)) {
      _animationControllers[campaignId] = AnimationController(
        duration: const Duration(milliseconds: 250),
        vsync: this,
      );
    }
    return _animationControllers[campaignId]!;
  }

  String _getCampaignSubtitle(int campaignId) {
    final campaignMissions = getMissionsForCampaign(campaignId);
    final completedCount = campaignMissions
        .where((mission) => mission['status'] == 'completed')
        .length;
    final totalCount = campaignMissions.length;

    if (completedCount == totalCount) {
      return 'All missions completed!';
    } else if (completedCount == 0) {
      return 'Start your adventure';
    } else {
      return '$completedCount of $totalCount missions completed';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: campaigns.length,
            itemBuilder: (context, index) {
              final campaign = campaigns[index];
              final bool isExpanded = _expandedCampaignId == campaign['id'];
              final double progress = calculateCampaignProgress(
                campaign['id'] as int,
              );

              return AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                curve: Curves.easeInOut,
                margin: const EdgeInsets.only(bottom: 16),
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      final currentCampaignId = campaign['id'] as int;
                      final animationController = _getAnimationController(
                        currentCampaignId,
                      );

                      if (isExpanded) {
                        // Closing the currently expanded campaign
                        _expandedCampaignId = null;
                        _selectedMission = null;
                        animationController.reverse();
                      } else {
                        // Opening a new campaign - first close any currently open campaign
                        if (_expandedCampaignId != null) {
                          final previousController = _getAnimationController(
                            _expandedCampaignId!,
                          );
                          previousController.reverse();
                        }

                        // Then open the new campaign
                        _expandedCampaignId = currentCampaignId;
                        _selectedMission = null;
                        animationController.forward();
                      }
                    });
                  },
                  child: Card(
                    elevation: 3,
                    color: Theme.of(
                      context,
                    ).colorScheme.surfaceContainerHighest,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(26),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 14,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // RIGA PRINCIPALE: icon - testi - progress
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(14),
                                child: Image.asset(
                                  campaign['image']['url'] ?? '',
                                  width: 44,
                                  height: 44,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) {
                                    return Container(
                                      width: 44,
                                      height: 44,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .surface
                                            .withValues(alpha: 0.5),
                                        borderRadius: BorderRadius.circular(14),
                                      ),
                                      child: Icon(
                                        Icons.image_not_supported,
                                        size: 20,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onSurface
                                            .withValues(alpha: 0.6),
                                      ),
                                    );
                                  },
                                ),
                              ),
                              const SizedBox(width: 12),
                              // Titolo + sottotitolo
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      campaign['name'],
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: AppTextStyles.subtitle(context),
                                    ),
                                    const SizedBox(height: 2),
                                    Text(
                                      _getCampaignSubtitle(
                                        campaign['id'] as int,
                                      ),
                                      style: AppTextStyles.caption(context),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 8),
                              // Indicatore percentuale tipo "pill" in alto a destra
                              _CircularProgressArc(progress: progress),
                            ],
                          ),

                          // CONTENUTO ESPANSO
                          SizeTransition(
                            sizeFactor: _getAnimationController(
                              campaign['id'] as int,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(top: 8),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(height: 10),
                                  // descrizione campagna
                                  Text(
                                    campaign['description'] ?? '',
                                    style: AppTextStyles.bodySmall(
                                      context,
                                    ).copyWith(height: 1.3),
                                    maxLines: 3,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const SizedBox(height: 10),
                                  // lista missioni
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      for (final missionId
                                          in campaign['missions'])
                                        Builder(
                                          builder: (context) {
                                            final mission = getMissionById(
                                              missionId,
                                            );
                                            if (mission == null) {
                                              return const SizedBox.shrink();
                                            }
                                            return _MissionRow(
                                              mission: mission,
                                            );
                                          },
                                        ),
                                    ],
                                  ),
                                  const SizedBox(height: 4),
                                  // freccetta giù centrata come nel mock
                                  Align(
                                    alignment: Alignment.center,
                                    child: Icon(
                                      Icons.keyboard_arrow_up,
                                      size: 18,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onSurface
                                          .withValues(alpha: 0.6),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),

                          // quando è chiuso mostra solo la freccetta per indicare che si può aprire
                          if (!isExpanded)
                            Align(
                              alignment: Alignment.centerRight,
                              child: Icon(
                                Icons.keyboard_arrow_down,
                                size: 18,
                                color: Theme.of(
                                  context,
                                ).colorScheme.onSurface.withValues(alpha: 0.5),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),

        if (_selectedMission != null)
          _MissionDetailCard(mission: _selectedMission!),
      ],
    );
  }
}

class _CircularProgressArc extends StatelessWidget {
  final double progress; // 0..1

  const _CircularProgressArc({required this.progress});

  @override
  Widget build(BuildContext context) {
    final percentage = (progress * 100).round();
    return SizedBox(
      width: 40,
      height: 40,
      child: Stack(
        alignment: Alignment.center,
        children: [
          CustomPaint(
            size: const Size(40, 40),
            painter: _ArcPainter(
              progress,
              Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.3),
              Theme.of(context).colorScheme.primary,
            ),
          ),
          Text(
            '$percentage%',
            style: AppTextStyles.caption(
              context,
            ).copyWith(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}

class _ArcPainter extends CustomPainter {
  final double progress;
  final Color backgroundColor;
  final Color progressColor;

  _ArcPainter(this.progress, this.backgroundColor, this.progressColor);

  @override
  void paint(Canvas canvas, Size size) {
    final strokeWidth = 4.0;
    final rect = Rect.fromLTWH(
      strokeWidth / 2,
      strokeWidth / 2,
      size.width - strokeWidth,
      size.height - strokeWidth,
    );

    final bgPaint = Paint()
      ..color = backgroundColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    final fgPaint = Paint()
      ..color = progressColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    // cerchio completo grigio
    canvas.drawArc(rect, -math.pi / 2, 2 * math.pi, false, bgPaint);
    // arco verde in base al progress
    canvas.drawArc(rect, -math.pi / 2, 2 * math.pi * progress, false, fgPaint);
  }

  @override
  bool shouldRepaint(covariant _ArcPainter oldDelegate) =>
      oldDelegate.progress != progress ||
      oldDelegate.backgroundColor != backgroundColor ||
      oldDelegate.progressColor != progressColor;
}

/// Righe mission come prima, ma su sfondo chiaro
class _MissionRow extends StatelessWidget {
  final Map<String, dynamic> mission;

  const _MissionRow({required this.mission});

  void _openMissionModal(BuildContext context) {
    Modal.showModal(context, MissionModal(mission: mission, context: context));
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _openMissionModal(context),
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 6),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Testo missione + icona info accanto
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Flexible(
                    child: Text(
                      mission['name'],
                      style: AppTextStyles.bodySmall(
                        context,
                      ).copyWith(fontWeight: FontWeight.w500),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(width: 4),
                  // Icon(
                  //   Icons.info_outline,
                  //   size: 16,
                  //   color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.5),
                  // ),
                ],
              ),
            ),

            const SizedBox(width: 8),

            // Icona check o checkbox
            Icon(
              mission['status'] == 'completed'
                  ? Icons.check_rounded
                  : Icons.check_box_outline_blank_rounded,
              size: 18,
              color: mission['status'] == 'completed'
                  ? Theme.of(context).colorScheme.primary
                  : Theme.of(
                      context,
                    ).colorScheme.onSurface.withValues(alpha: 0.4),
            ),
          ],
        ),
      ),
    );
  }
}

class _MissionDetailCard extends StatelessWidget {
  final Map<String, dynamic> mission;

  const _MissionDetailCard({required this.mission});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 16, right: 16, bottom: 16, top: 0),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(22),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.circle,
                size: 6,
                color: Theme.of(context).colorScheme.onSurface,
              ),
              const SizedBox(width: 6),
              Expanded(
                child: Text(
                  mission['name'] ?? 'Selected mission',
                  style: AppTextStyles.bodySmall(
                    context,
                  ).copyWith(fontWeight: FontWeight.bold),
                ),
              ),
              Icon(
                mission['status'] == 'completed'
                    ? Icons.check
                    : Icons.circle_outlined,
                size: 18,
                color: mission['status'] == 'completed'
                    ? Theme.of(context).colorScheme.primary
                    : Theme.of(
                        context,
                      ).colorScheme.onSurface.withValues(alpha: 0.4),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            mission['notes'] ??
                mission['description'] ??
                'Add a nice storytelling description for this mission.',
            style: AppTextStyles.bodySmall(context).copyWith(height: 1.4),
          ),
          if (mission['type'] != null) ...[
            const SizedBox(height: 8),
            Text(
              'Type: ${mission['type']}',
              style: AppTextStyles.caption(
                context,
              ).copyWith(fontStyle: FontStyle.italic),
            ),
          ],
        ],
      ),
    );
  }
}
