import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taskmgt/core/constant/app_color.dart';
import 'package:taskmgt/core/constant/text_style.dart';
import 'package:taskmgt/core/utils/get_date.dart';
import 'package:taskmgt/core/utils/routes.dart';
import 'package:taskmgt/model/status.dart';
import 'package:taskmgt/model/task_model.dart';
import 'package:taskmgt/provider/task_provider.dart';
import 'package:taskmgt/view/create_task.dart';
import 'package:taskmgt/widget/button.dart';
import 'package:taskmgt/widget/card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 30, bottom: 10, left: 10, right: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          spacing: 10,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                PhysicalModel(
                  color: AppColor.whiteColor,
                  shape: BoxShape.circle,
                  elevation: 2,
                  child: Padding(
                    padding: EdgeInsets.all(1.0),
                    child: CircleAvatar(radius: 21, backgroundImage: NetworkImage('${FirebaseAuth.instance.currentUser?.photoURL}')),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(DateFormatter().formattedCurrentDate, style: AppTextStyle.font20Bold.copyWith(color: AppColor.lightColor)),
                CommonButton(
                  title: '+ Add',
                  onTap: () {
                    Routes.routesPush(CreateTaskPage());
                  },
                ),
              ],
            ),
            Expanded(
              child: StreamBuilder<DatabaseEvent>(
                stream: getTask().onValue,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    if (snapshot.data?.snapshot.value == null) {
                      return Center(child: Text('There is no task avaliable', style: AppTextStyle.font18));
                    }
                    final data = (snapshot.data!.snapshot.value) as Map<dynamic, dynamic>;
                    List<TaskModel> taskList = [];
                    data.forEach((key, value) {
                      final task = TaskModel.fromJson(Map<String, dynamic>.from(value));
                      taskList.add(task);
                    });
                    return Column(
                      children: [
                        Expanded(
                          child: ListView.builder(
                            padding: EdgeInsets.zero,
                            itemCount: taskList.length,
                            itemBuilder: (context, i) {
                              return Dismissible(
                                background: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    color: AppColor.redColor,
                                    alignment: Alignment.centerLeft,
                                    padding: const EdgeInsets.only(left: 20),
                                    child: const Icon(Icons.delete, color: Colors.white),
                                  ),
                                ),
                                secondaryBackground: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    color: AppColor.getNextColorByStaus(taskList[i].status),
                                    alignment: Alignment.centerRight,
                                    padding: const EdgeInsets.only(right: 20),
                                    child: const Icon(Icons.arrow_forward_ios_outlined, color: Colors.white),
                                  ),
                                ),
                                key: Key(taskList[i].id),
                                confirmDismiss: (direction) async {
                                  if (direction == DismissDirection.endToStart && taskList[i].status != Status.completed) {
                                    context.read<TaskProvider>().updateTask(taskList[i].changeStatus(), isPop: false);
                                  }
                                  if (direction == DismissDirection.startToEnd) {
                                    context.read<TaskProvider>().deleteTask(taskList[i]);
                                  }

                                  return false;
                                },
                                child: CardPage(data: taskList[i]),
                              );
                            },
                          ),
                        ),
                      ],
                    );
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Something went wrong.'));
                  } else {
                    return Center(child: CircularProgressIndicator());
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
