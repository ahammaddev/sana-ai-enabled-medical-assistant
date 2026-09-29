import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sana/app/data/models/consultation_model.dart';
import 'package:sana/app/utils/constants/colors/app_colors.dart';
import 'package:sana/app/utils/constants/helpers/date_formatter.dart';

class ConsultationCard extends StatelessWidget {
  const ConsultationCard({
    super.key,
    required this.consultation,
    required this.onTap,
    required this.onDelete,
  });

  final ConsultationModel consultation;
  final VoidCallback onTap;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final lastMessage = consultation.lastMessage;

    return Dismissible(
      key: Key('chat_session_${consultation.id}'),
      direction: DismissDirection.endToStart,
      background: Container(
        color: AppColors.tertiary,
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        child: const Icon(Icons.delete, color: Colors.white),
      ),
      onDismissed: (_) => onDelete(),
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(
              width: 1,
              color: AppColors.secondary.withAlpha(40),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: AppColors.primary.withAlpha(20),
                    ),
                    child: const FaIcon(
                      FontAwesomeIcons.robot,
                      size: 14,
                      color: AppColors.primary,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      consultation.title,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: AppColors.primarydark,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  if (consultation.updatedAt.isNotEmpty) ...[
                    const SizedBox(width: 8),
                    Text(
                      DateFormatter.relative(consultation.updatedAt),
                      style: theme.textTheme.bodySmall?.copyWith(
                        fontSize: 10.5,
                        color: Colors.grey.withAlpha(150),
                      ),
                    ),
                  ],
                ],
              ),
              if (lastMessage != null && lastMessage.isNotEmpty) ...[
                const SizedBox(height: 8),
                Text(
                  lastMessage,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: AppColors.secondary,
                    height: 1.3,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
