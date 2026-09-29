import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sana/app/utils/constants/colors/app_colors.dart';

class EmptyConsultations extends StatelessWidget {
  const EmptyConsultations({
    super.key,
    required this.isSearching,
    required this.onNewConsultation,
  });

  final bool isSearching;
  final VoidCallback onNewConsultation;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            FaIcon(
              FontAwesomeIcons.robot,
              size: 60,
              color: AppColors.primary.withAlpha(100),
            ),
            const SizedBox(height: 16),
            Text(
              isSearching
                  ? 'No matching consultations found'
                  : 'No consultations yet',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: AppColors.primarydark,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              isSearching
                  ? 'Try searching with different keywords.'
                  : 'Start a new consultation with Sana.',
              textAlign: TextAlign.center,
              style: theme.textTheme.bodySmall?.copyWith(
                color: AppColors.secondary,
              ),
            ),
            const SizedBox(height: 20),
            if (!isSearching)
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 12,
                  ),
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.zero,
                  ),
                ),
                onPressed: onNewConsultation,
                icon: const Icon(Icons.add, size: 18),
                label: const Text('NEW CONSULTATION'),
              ),
          ],
        ),
      ),
    );
  }
}
