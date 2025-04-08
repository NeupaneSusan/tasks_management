import 'package:flutter/material.dart';
import 'package:taskmgt/core/constant/app_color.dart';
import 'package:taskmgt/core/constant/board_radius.dart';
import 'package:taskmgt/core/constant/text_style.dart';

class CommonButton extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  const CommonButton({super.key, required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 50,
        width: 100,
        alignment: Alignment.center,
        decoration: BoxDecoration(color: AppColor.primaryColor, borderRadius: AppBoardRadius.borderRadius20, boxShadow: kElevationToShadow[1]),
        child: Text(title, style: AppTextStyle.font16W6.copyWith(color: AppColor.whiteColor)),
      ),
    );
  }
}
