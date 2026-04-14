import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sana/app/utils/constants/colors/app_colors.dart';

class BotLoading extends StatelessWidget {
  const BotLoading({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      decoration: BoxDecoration(
        color: AppColors.primary.withAlpha(10),
        border: Border(
          left: BorderSide(width: 2, color: AppColors.primary.withAlpha(80)),
        ),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(5),
          bottomLeft: Radius.circular(5),
        ),
      ),
      padding: EdgeInsets.only(top: 10, bottom: 10, left: 10, right: 10),
      margin: EdgeInsets.only(right: context.width * 0.3, left: 0, bottom: 10),
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
    );
  }
}
