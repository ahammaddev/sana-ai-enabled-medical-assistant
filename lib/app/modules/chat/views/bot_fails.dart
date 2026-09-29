import 'package:flutter/material.dart';
import 'package:sana/app/utils/constants/colors/app_colors.dart';

class BotFails extends StatelessWidget {
  const BotFails({super.key, this.onRetry});

  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final maxWidth = MediaQuery.of(context).size.width * 0.82;

    return Align(
      alignment: Alignment.centerLeft,
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: maxWidth),
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.tertiary.withAlpha(10),
            border: Border(
              left: BorderSide(
                width: 2,
                color: AppColors.tertiary.withAlpha(80),
              ),
            ),
          ),
          padding: const EdgeInsets.all(10),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'ALAS! FAILED TO LOAD',
                      style: theme.textTheme.bodySmall!.copyWith(
                        color: AppColors.tertiary,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    Text(
                      '> please try again.',
                      style: theme.textTheme.bodySmall!.copyWith(
                        color: AppColors.tertiary.withAlpha(150),
                      ),
                    ),
                  ],
                ),
              ),
              if (onRetry != null) ...[
                const SizedBox(width: 16),
                InkWell(
                  onTap: onRetry,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 1,
                        color: AppColors.tertiary.withAlpha(80),
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.refresh,
                          size: 14,
                          color: AppColors.tertiary,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          'RETRY',
                          style: theme.textTheme.labelSmall!.copyWith(
                            color: AppColors.tertiary,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
