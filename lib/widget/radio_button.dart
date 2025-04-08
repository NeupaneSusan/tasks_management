import 'package:flutter/material.dart';
import 'package:taskmgt/core/constant/app_color.dart';
import 'package:taskmgt/core/constant/text_style.dart';
import 'package:taskmgt/core/utils/extesion.dart';
import 'package:taskmgt/model/status.dart';

class StatusRadioButton extends StatelessWidget {
  final Status? selectedStatus;
  final Function(Status?) onChanged;

  const StatusRadioButton({super.key, required this.selectedStatus, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Status', style: AppTextStyle.font15W5),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children:
              Status.values.map((status) {
                return RadioListTile<Status>(
                  activeColor: AppColor.getColorByStatus(status),
                  radioScaleFactor: 1,
                  contentPadding: EdgeInsets.zero,
                  title: Text(status.name.capitalizeFirstLetter(), style: AppTextStyle.font18), // uses extension
                  value: status,
                  groupValue: selectedStatus,
                  onChanged: onChanged,
                );
              }).toList(),
        ),
      ],
    );
  }
}
