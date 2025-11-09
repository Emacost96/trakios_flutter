import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:trakios/providers/profile/balance_provider.dart';
import 'package:trakios/theme/text_styles.dart';
import 'package:trakios/assets/user.dart';
import 'package:trakios/providers/profile/gallery_provider.dart';

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

// ---------------- Profile Header ----------------
class _ProfileHeaderCard extends ConsumerStatefulWidget {
  const _ProfileHeaderCard();

  @override
  ConsumerState<_ProfileHeaderCard> createState() => _ProfileHeaderCardState();
}

class _ProfileHeaderCardState extends ConsumerState<_ProfileHeaderCard> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final String userName = user['name'] ?? 'Unknown User';
    final tokenBalance = ref.watch(tokenBalanceProvider);
    final String avatarUrl = user['avatar'] ?? '';

    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(26)),
      color: theme.colorScheme.surface,
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Avatar + Nome
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(999),
                  child: _buildImage(avatarUrl, theme, size: 84),
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

            // Token Balance
            Text('Token Balance', style: AppTextStyles.bodySmall(context)),
            const SizedBox(height: 4),
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
                  tokenBalance.toString(),
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

            // Gallery button (solo UI)
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

  // Funzione comune per immagini locali e remote
  Widget _buildImage(String url, ThemeData theme, {double size = 40}) {
    Widget imageWidget;

    if (url.startsWith('assets/')) {
      imageWidget = Image.asset(
        url,
        width: size,
        height: size,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return _buildFallbackImage(theme, size);
        },
      );
    } else if (url.startsWith('http')) {
      imageWidget = Image.network(
        url,
        width: size,
        height: size,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return _buildFallbackImage(theme, size);
        },
      );
    } else {
      return _buildFallbackImage(theme, size);
    }

    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: theme.brightness == Brightness.dark
            ? Colors.black
            : Colors.white,
        borderRadius: BorderRadius.circular(999),
      ),
      child: imageWidget,
    );
  }

  Widget _buildFallbackImage(ThemeData theme, double size) {
    return CircleAvatar(
      radius: size / 2,
      backgroundColor: theme.colorScheme.primary.withOpacity(0.15),
      child: Icon(
        Icons.person,
        size: size / 2,
        color: theme.colorScheme.onSurface,
      ),
    );
  }
}

// ---------------- Gallery Grid ----------------
class _GalleryGrid extends ConsumerWidget {
  const _GalleryGrid();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final galleryImages = ref.watch(galleryProvider);

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
              child: _buildGalleryImage(url, theme),
            );
          },
        ),
      ],
    );
  }

  // Funzione comune per immagini della galleria
  Widget _buildGalleryImage(String path, ThemeData theme) {
    if (path.startsWith('assets/')) {
      // Asset locale
      return Image.asset(
        path,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return _buildFallbackGalleryImage(theme);
        },
      );
    } else if (path.startsWith('http')) {
      // URL remoto
      return Image.network(
        path,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return _buildFallbackGalleryImage(theme);
        },
      );
    } else {
      // File locale (Android e iOS)
      final file = File(path);
      if (file.existsSync()) {
        return Image.file(
          file,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return _buildFallbackGalleryImage(theme);
          },
        );
      } else {
        return _buildFallbackGalleryImage(theme);
      }
    }
  }

  Widget _buildFallbackGalleryImage(ThemeData theme) {
    return Container(
      color: theme.colorScheme.surface,
      child: Icon(
        Icons.image_not_supported,
        size: 22,
        color: theme.colorScheme.onSurface.withOpacity(0.6),
      ),
    );
  }
}
