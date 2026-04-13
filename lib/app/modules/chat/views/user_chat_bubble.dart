import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:sana/app/modules/chat/controllers/chat_controller.dart';
import 'package:sana/app/utils/constants/colors/app_colors.dart';

class UserChatBubble extends GetView<ChatController> {
  const UserChatBubble({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: EdgeInsets.only(left: 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                'USER QUERY',
                style: theme.textTheme.bodySmall!.copyWith(
                  color: AppColors.secondary,

                  fontWeight: FontWeight.w600,
                ),
              ),
              // SizedBox(width: 5),
              //     Obx(
              //       () => AnimatedContainer(
              //         duration: Duration(seconds: 1),
              //         curve: Curves.linear,
              //         decoration: BoxDecoration(
              //           color: controller.blinkController.value
              //               ? theme.colorScheme.primary
              //               : theme.colorScheme.primary.withAlpha(1),
              //           shape: BoxShape.circle,
              //         ),

              //         padding: EdgeInsets.all(4),
              //       ),
              //     ),
            ],
          ),
          SizedBox(height: 10),
          Container(
            padding: EdgeInsets.all(15),
            decoration: BoxDecoration(
              // color: AppColors.grey,
              // boxShadow: [
              //   BoxShadow(
              //     color: AppColors.grey,
              //     blurRadius: 4,
              //     spreadRadius: 1,
              //     offset: Offset(0, 2),
              //   ),
              // ],
              borderRadius: BorderRadius.circular(5),
              border: Border.all(
                // top: BorderSide(width: 1, color: Colors.white.withAlpha(200)),
                width: 1,
                color: AppColors.secondary.withAlpha(40),
              ),
            ),
            child: Text(
              'You can take aspirin to help lower your fever, as it works on the part of your brain that controls body temperature. For adults, the recommended dose is one to two tablets every three to four hours, up to six times a day. If your fever is high, meaning between 38 and 40 degrees Celsius (about 100.4 to 104 degrees Fahrenheit), or if you feel very unwell, you should contact your doctor right away.',
              style: theme.textTheme.bodySmall!.copyWith(),
            ),
          ),
          SizedBox(height: 10),
          Text(
            '2026-11-11 12:00:00',
            style: theme.textTheme.bodySmall!.copyWith(),
          ),
        ],
      ),
    );
  }
}
