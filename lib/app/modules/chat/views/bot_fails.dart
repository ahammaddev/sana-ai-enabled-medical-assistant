import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sana/app/utils/constants/colors/app_colors.dart';

class BotFails extends StatelessWidget {
  const BotFails({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      decoration: BoxDecoration(
        color: AppColors.tertiary.withAlpha(10),
        border: Border(
          left: BorderSide(width: 2, color: AppColors.tertiary.withAlpha(80)),
        ),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(5),
          bottomLeft: Radius.circular(5),
        ),
      ),
      padding: EdgeInsets.only(top: 10, bottom: 10, left: 10, right: 10),
      margin: EdgeInsets.only(right: context.width * 0.57, left: 0, bottom: 10),
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
          // Text(
          //   '> developed by Faisal Ahammad.',
          //   style: theme.textTheme.bodySmall!.copyWith(
          //     color: AppColors.tertiary.withAlpha(150),
          //   ),
          // ),
        ],
      ),
    );
  }
}
