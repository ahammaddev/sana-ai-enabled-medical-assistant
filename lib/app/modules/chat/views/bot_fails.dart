import 'package:flutter/material.dart';
import 'package:sana/app/utils/constants/colors/app_colors.dart';

class BotFails extends StatelessWidget {
  const BotFails({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final maxWidth = MediaQuery.of(context).size.width * 0.82;

    return Align(
      alignment: Alignment.centerLeft,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: maxWidth,
        ),
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.tertiary.withAlpha(10),
            border: Border(
              left: BorderSide(width: 2, color: AppColors.tertiary.withAlpha(80)),
            ),
          ),
          padding: const EdgeInsets.all(10),
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
      ),
    );
  }
}
