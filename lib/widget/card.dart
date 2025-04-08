import 'package:flutter/material.dart';
import 'package:taskmgt/core/constant/app_color.dart';
import 'package:taskmgt/core/constant/text_style.dart';
import 'package:taskmgt/core/utils/extesion.dart';
import 'package:taskmgt/core/utils/routes.dart';
import 'package:taskmgt/model/task_model.dart';
import 'package:taskmgt/view/create_task.dart';

class CardPage extends StatelessWidget {
  final TaskModel data;
  const CardPage({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Routes.routesPush(CreateTaskPage(task: data));
      },
      child: Container(
        margin: const EdgeInsetsDirectional.symmetric(vertical: 5),
        decoration: BoxDecoration(
          color: AppColor.getColorByStatus(data.status),
          borderRadius: BorderRadius.circular(10),
          boxShadow: kElevationToShadow[1],
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: IntrinsicHeight(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 5,
                  children: [
                    Text(data.title, style: AppTextStyle.font16W5.copyWith(color: AppColor.whiteColor)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      spacing: 5,
                      children: [
                        const Icon(Icons.access_time, size: 22, color: Colors.white),
                        Text('${data.startTime} - ${data.endTime} ${data.date}', style: AppTextStyle.font14W6.copyWith(color: AppColor.whiteColor)),
                      ],
                    ),
                    Text(data.note, overflow: TextOverflow.ellipsis, maxLines: 2, style: AppTextStyle.font16W6.copyWith(color: AppColor.whiteColor)),
                  ],
                ),
                Row(
                  children: [
                    const VerticalDivider(indent: 18, color: Colors.white, thickness: 0.5, endIndent: 15),
                    RotatedBox(
                      quarterTurns: 1,
                      child: Text(data.status.name.capitalizeFirstLetter(), style: AppTextStyle.font14W6.copyWith(color: Colors.white)),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
