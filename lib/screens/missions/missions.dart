import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:trakios/assets/campaigns.dart';
import 'package:trakios/assets/missions.dart';

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
  final campaign = campaigns.firstWhere((c) => c['id'] == campaignId, orElse: () => {});
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
          title: const Text('Activities'),
          bottom: const TabBar(
            tabs: [
              Tab(
                icon: Icon(Icons.assignment),
                text: 'Missions',
              ),
              Tab(
                icon: Icon(Icons.campaign),
                text: 'Campaigns',
              ),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            MissionsTab(),
            CampaignsTab(),
          ],
        ),
      ),
    );
  }
}

class MissionsTab extends StatelessWidget {
  const MissionsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.assignment, size: 64, color: Colors.blue),
          SizedBox(height: 16),
          Text(
            'Missions',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          Text(
            'Complete individual tasks and challenges',
            style: TextStyle(fontSize: 16, color: Colors.grey),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class CampaignsTab extends StatefulWidget {
  const CampaignsTab({super.key});

  @override
  State<CampaignsTab> createState() => _CampaignsTabState();
}

class _CampaignsTabState extends State<CampaignsTab> {
  int? _expandedCampaignId;
  Map<String, dynamic>? _selectedMission;

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
              final double progress = calculateCampaignProgress(campaign['id'] as int);

              return AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                curve: Curves.easeInOut,
                margin: const EdgeInsets.only(bottom: 16),
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      if (isExpanded) {
                        _expandedCampaignId = null;
                        _selectedMission = null;
                      } else {
                        _expandedCampaignId = campaign['id'] as int;
                        _selectedMission = null;
                      }
                    });
                  },
                  child: Container(
                    // pill come nel mock bianco
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(26),
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 14,
                          offset: const Offset(0, 6),
                          color: Colors.black.withValues(alpha: 0.16),
                        ),
                      ],
                    ),
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
                                campaign['image']['src'],
                                width: 44,
                                height: 44,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  return Container(
                                    width: 44,
                                    height: 44,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      color: Colors.grey[300],
                                      borderRadius: BorderRadius.circular(14),
                                    ),
                                    child: Icon(
                                      Icons.image_not_supported,
                                      size: 20,
                                      color: Colors.grey[600],
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
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.black87,
                                    ),
                                  ),
                                  const SizedBox(height: 2),
                                  Text(
                                    _getCampaignSubtitle(campaign['id'] as int),
                                    style: const TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey,
                                    ),
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
                        AnimatedCrossFade(
                          crossFadeState: isExpanded
                              ? CrossFadeState.showSecond
                              : CrossFadeState.showFirst,
                          duration: const Duration(milliseconds: 200),
                          firstChild: const SizedBox(height: 4),
                          secondChild: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 10),
                              // descrizione campagna
                              Text(
                                campaign['description'] ?? '',
                                style: const TextStyle(
                                  fontSize: 13,
                                  color: Colors.black87,
                                  height: 1.3,
                                ),
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 10),
                              // lista missioni
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  for (final missionId in campaign['missions'])
                                    Builder(
                                      builder: (context) {
                                        final mission = getMissionById(missionId);
                                        if (mission == null) {
                                          return const SizedBox.shrink();
                                        }
                                        return _MissionRow(
                                          mission: mission,
                                          onTap: (mission) {
                                            setState(() {
                                              _selectedMission = mission;
                                            });
                                          },
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
                                  color: Colors.grey[600],
                                ),
                              ),
                            ],
                          ),
                        ),

                        // quando è chiuso mostra solo la freccetta per indicare che si può aprire
                        if (!isExpanded)
                          Align(
                            alignment: Alignment.centerRight,
                            child: Icon(
                              Icons.keyboard_arrow_down,
                              size: 18,
                              color: Colors.grey[500],
                            ),
                          ),
                      ],
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
            painter: _ArcPainter(progress),
          ),
          Text(
            '$percentage%',
            style: const TextStyle(
              fontSize: 9,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }
}

class _ArcPainter extends CustomPainter {
  final double progress;

  _ArcPainter(this.progress);

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
      ..color = Colors.grey.shade300
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    final fgPaint = Paint()
      ..color = const Color(0xFF00D26A)
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
      oldDelegate.progress != progress;
}

/// Righe mission come prima, ma su sfondo chiaro
class _MissionRow extends StatelessWidget {
  final Map<String, dynamic> mission;
  final void Function(Map<String, dynamic> mission) onTap;

  const _MissionRow({
    required this.mission,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTap(mission),
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
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.black87,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(width: 4),
                  Icon(
                    Icons.info_outline,
                    size: 16,
                    color: Colors.grey[500],
                  ),
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
                  ? const Color(0xFF00D26A)
                  : Colors.grey[400],
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
      margin:
          const EdgeInsets.only(left: 16, right: 16, bottom: 16, top: 0),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        boxShadow: [
          BoxShadow(
            blurRadius: 12,
            offset: const Offset(0, 6),
            color: Colors.black.withValues(alpha: 0.18),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(
                Icons.circle,
                size: 6,
                color: Colors.black87,
              ),
              const SizedBox(width: 6),
              Expanded(
                child: Text(
                  mission['name'] ?? 'Selected mission',
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
              ),
              Icon(
                mission['status'] == 'completed' ? Icons.check : Icons.circle_outlined,
                size: 18,
                color: mission['status'] == 'completed' 
                    ? const Color(0xFF00D26A) 
                    : Colors.grey[400],
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            mission['notes'] ??
                mission['description'] ??
                'Add a nice storytelling description for this mission.',
            style: const TextStyle(
              fontSize: 13,
              color: Colors.black87,
              height: 1.4,
            ),
          ),
          if (mission['type'] != null) ...[
            const SizedBox(height: 8),
            Text(
              'Type: ${mission['type']}',
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[600],
                fontStyle: FontStyle.italic,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
