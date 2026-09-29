import 'package:flutter/material.dart';
import 'package:sana/app/utils/constants/colors/app_colors.dart';

class BotLoading extends StatelessWidget {
  const BotLoading({super.key});

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
            color: AppColors.primary.withAlpha(10),
            border: Border(
              left: BorderSide(width: 2, color: AppColors.primary.withAlpha(80)),
            ),
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(5),
              bottomLeft: Radius.circular(5),
            ),
          ),
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'SANA IS THINKING',
                style: theme.textTheme.bodySmall!.copyWith(
                  color: AppColors.primarydark,
                  fontWeight: FontWeight.w800,
                ),
              ),
              Text(
                '> powered by Ahammad Intelligence.',
                style: theme.textTheme.bodySmall!.copyWith(
                  color: AppColors.primarydark.withAlpha(150),
                ),
              ),
              Text(
                '> developed by Faisal Ahammad.',
                style: theme.textTheme.bodySmall!.copyWith(
                  color: AppColors.primarydark.withAlpha(150),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
