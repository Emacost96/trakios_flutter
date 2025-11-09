import 'package:flutter/material.dart';
import 'package:trakios/theme/text_styles.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.colorScheme.background,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: theme.colorScheme.background,
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

    const String userName = 'Jane Doe';
    const int tokenBalance = 2045;

    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(26),
      ),
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
                  child: Image.network(
                    // Avatar Pexels (hardcoded)
                    'https://images.pexels.com/photos/3760850/pexels-photo-3760850.jpeg?auto=compress&cs=tinysrgb&w=400',
                    width: 84,
                    height: 84,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => CircleAvatar(
                      radius: 42,
                      backgroundColor: theme.colorScheme.primary.withValues(alpha: 0.15),
                      child: Icon(
                        Icons.person,
                        size: 40,
                        color: theme.colorScheme.onSurface,
                      ),
                    ),
                  ),
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
            Text(
              'Token Balance',
              style: AppTextStyles.bodySmall(context),
            ),

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
                  style: AppTextStyles.title(context).copyWith(
                    fontWeight: FontWeight.w800,
                  ),
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
                  backgroundColor: const Color(0xFFFF5A64), // rosso stile mock
                  foregroundColor: Colors.white,
                  padding:
                      const EdgeInsets.symmetric(vertical: 12, horizontal: 14),
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
                  backgroundColor: const Color(0xFFFF5A64),
                  foregroundColor: Colors.white,
                  padding:
                      const EdgeInsets.symmetric(vertical: 11, horizontal: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18),
                  ),
                ),
                onPressed: () {
                  // TODO: scroll alla gallery / apri pagina gallery
                },
                icon: const Icon(Icons.photo_library_rounded, size: 20),
                label: Text(
                  'Gallery',
                  style: AppTextStyles.button(context),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _GalleryGrid extends StatelessWidget {
  const _GalleryGrid();

  // immagini Pexels hardcodate
  static const List<String> _galleryImages = [
    'https://images.pexels.com/photos/4606720/pexels-photo-4606720.jpeg?auto=compress&cs=tinysrgb&w=400', // Colosseo
    'https://images.pexels.com/photos/208745/pexels-photo-208745.jpeg?auto=compress&cs=tinysrgb&w=400',  // paesaggio verde
    'https://images.pexels.com/photos/4606726/pexels-photo-4606726.jpeg?auto=compress&cs=tinysrgb&w=400', // chiesetta
    'https://images.pexels.com/photos/4606727/pexels-photo-4606727.jpeg?auto=compress&cs=tinysrgb&w=400', // borgo
    'https://images.pexels.com/photos/240040/pexels-photo-240040.jpeg?auto=compress&cs=tinysrgb&w=400',  // mare
    'https://images.pexels.com/photos/356004/pexels-photo-356004.jpeg?auto=compress&cs=tinysrgb&w=400',  // montagna
    'https://images.pexels.com/photos/417173/pexels-photo-417173.jpeg?auto=compress&cs=tinysrgb&w=400',  // ponte
    'https://images.pexels.com/photos/21014/pexels-photo.jpg?auto=compress&cs=tinysrgb&w=400',
    'https://images.pexels.com/photos/4606720/pexels-photo-4606720.jpeg?auto=compress&cs=tinysrgb&w=400', // Colosseo
    'https://images.pexels.com/photos/208745/pexels-photo-208745.jpeg?auto=compress&cs=tinysrgb&w=400',  // paesaggio verde
    'https://images.pexels.com/photos/4606726/pexels-photo-4606726.jpeg?auto=compress&cs=tinysrgb&w=400', // ch
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Recent Memories',
          style: AppTextStyles.subtitle(context),
        ),
        const SizedBox(height: 10),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: _galleryImages.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
            childAspectRatio: 1,
          ),
          itemBuilder: (context, index) {
            final url = _galleryImages[index];
            return ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.network(
                url,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: theme.colorScheme.surfaceVariant,
                    child: Icon(
                      Icons.image_not_supported,
                      size: 22,
                      color:
                          theme.colorScheme.onSurface.withValues(alpha: 0.6),
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
