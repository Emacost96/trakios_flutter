import 'package:flutter/material.dart';
import 'package:trakios/theme/text_styles.dart';
import 'package:trakios/theme/theme.dart';
import 'package:trakios/assets/user.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: theme.scaffoldBackgroundColor,
        title: const Text('Profile'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            _ProfileHeaderCard(),
            SizedBox(height: 18),
            _GalleryGrid(),
          ],
        ),
      ),
    );
  }
}

class _ProfileHeaderCard extends StatelessWidget {
  const _ProfileHeaderCard();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final String userName = user['name'] ?? 'Unknown User';
    final int tokenBalance = user['tokenBalance'] ?? 0;
    final String avatarUrl = user['avatar'] ?? '';

    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(26)),
      color: theme.colorScheme.surface,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(18, 18, 18, 18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Avatar + Nome
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(999),
                  child: _buildAvatar(avatarUrl, theme),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    userName,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyles.title(context),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 18),

            // Token Balance label
            Text('Token Balance', style: AppTextStyles.bodySmall(context)),

            const SizedBox(height: 4),

            // Token Balance value + icon
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  Icons.token_rounded,
                  size: 22,
                  color: theme.colorScheme.primary,
                ),
                const SizedBox(width: 8),
                Text(
                  tokenBalance.toString().replaceAll('.', ','),
                  style: AppTextStyles.title(
                    context,
                  ).copyWith(fontWeight: FontWeight.w800),
                ),
              ],
            ),

            const SizedBox(height: 18),

            // Mission History button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  backgroundColor: theme.colorScheme.primary,
                  foregroundColor: theme.colorScheme.onPrimary,
                  padding: const EdgeInsets.symmetric(
                    vertical: 12,
                    horizontal: 14,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18),
                  ),
                ),
                onPressed: () {
                  // TODO: naviga allo storico missioni
                },
                icon: const Icon(Icons.receipt_long_rounded, size: 20),
                label: Text(
                  'Mission History',
                  style: AppTextStyles.button(context),
                ),
              ),
            ),

            const SizedBox(height: 10),

            // Gallery button (solo UI / filtro)
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  backgroundColor: theme.colorScheme.secondary,
                  foregroundColor: theme.colorScheme.onSecondary,
                  padding: const EdgeInsets.symmetric(
                    vertical: 11,
                    horizontal: 14,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18),
                  ),
                ),
                onPressed: () {
                  // TODO: scroll alla gallery / apri pagina gallery
                },
                icon: const Icon(Icons.photo_library_rounded, size: 20),
                label: Text('Gallery', style: AppTextStyles.button(context)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAvatar(String avatarUrl, ThemeData theme) {
    // Verifica se l'avatar è un asset locale o un URL di rete
    print('Avatar URL: $avatarUrl'); // Debug line

    Widget imageWidget;

    if (avatarUrl.startsWith('assets/')) {
      imageWidget = Image.asset(
        avatarUrl,
        width: 84,
        height: 84,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          print('Error loading avatar asset: $error'); // Debug line
          return _buildFallbackAvatar(theme);
        },
      );
    } else if (avatarUrl.startsWith('http')) {
      imageWidget = Image.network(
        avatarUrl,
        width: 84,
        height: 84,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          print('Error loading avatar network: $error'); // Debug line
          return _buildFallbackAvatar(theme);
        },
      );
    } else {
      print('Avatar URL does not match any pattern: $avatarUrl'); // Debug line
      return _buildFallbackAvatar(theme);
    }

    // Aggiungi background colorato in base al tema
    return Container(
      width: 84,
      height: 84,
      decoration: BoxDecoration(
        color: theme.brightness == Brightness.dark
            ? Colors.black
            : Colors.white,
        borderRadius: BorderRadius.circular(999),
      ),
      child: imageWidget,
    );
  }

  Widget _buildFallbackAvatar(ThemeData theme) {
    return CircleAvatar(
      radius: 42,
      backgroundColor: theme.colorScheme.primary.withValues(alpha: 0.15),
      child: Icon(Icons.person, size: 40, color: theme.colorScheme.onSurface),
    );
  }
}

class _GalleryGrid extends StatelessWidget {
  const _GalleryGrid();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final List<String> galleryImages = List<String>.from(
      user['recentMemories'] ?? [],
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Recent Memories', style: AppTextStyles.subtitle(context)),
        const SizedBox(height: 10),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: galleryImages.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
            childAspectRatio: 1,
          ),
          itemBuilder: (context, index) {
            final url = galleryImages[index];
            return ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.network(
                url,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: theme.colorScheme.surface,
                    child: Icon(
                      Icons.image_not_supported,
                      size: 22,
                      color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
                    ),
                  );
                },
              ),
            );
          },
        ),
      ],
    );
  }
}
