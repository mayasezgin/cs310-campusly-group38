import 'package:flutter/material.dart';

import '../models/event.dart';
import '../theme/app_spacing.dart';
import '../theme/app_text_styles.dart';
import '../utils/date_labels.dart';

/// Compact card for an event on the Club Dashboard: title, date/time and
/// location, as in the Club Dashboard wireframe.
class ClubEventCard extends StatelessWidget {
  const ClubEventCard({super.key, required this.event, this.onTap});

  final Event event;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    Widget infoRow(IconData icon, String text) => Padding(
      padding: const EdgeInsets.only(top: AppSpacing.sm),
      child: Row(
        children: [
          Icon(icon, size: 16, color: colors.onSurfaceVariant),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Text(
              text,
              style: AppTextStyles.caption(
                context,
              )?.copyWith(color: colors.onSurfaceVariant),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );

    return Card(
      margin: const EdgeInsets.only(bottom: AppSpacing.md),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppRadius.md),
        side: BorderSide(color: colors.outlineVariant),
      ),
      elevation: 0,
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(event.title, style: AppTextStyles.cardTitle(context)),
              infoRow(
                Icons.calendar_today_outlined,
                eventTimeRangeLabel(event.startAt, event.endAt),
              ),
              infoRow(Icons.location_on_outlined, event.location),
            ],
          ),
        ),
      ),
    );
  }
}
