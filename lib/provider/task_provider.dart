import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:taskmgt/core/constant/app_color.dart';
import 'package:taskmgt/core/service/database_service.dart';
import 'package:taskmgt/core/utils/custom_alert.dart';
import 'package:taskmgt/core/utils/routes.dart';
import 'package:taskmgt/model/task_model.dart';

class TaskProvider extends ChangeNotifier {
  final DatabaseService databaseService;
  TaskProvider(this.databaseService);

  bool _isLoading = false;

  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  Future<void> createTask(TaskModel model) async {
    try {
      isLoading = true;
      await databaseService.createTask(model);
      Routes.pop();
      CustomAlert.show(message: 'Sccussfully created task.', backgroundColor: AppColor.greenColor);
    } on FirebaseException catch (e) {
      CustomAlert.show(message: e.message ?? 'Something went wrong');
    } finally {
      isLoading = false;
    }
  }

  Future<void> updateTask(TaskModel model, {bool isPop = true}) async {
    try {
      isLoading = true;
      await databaseService.updateTask(model);
      if (isPop) {
        Routes.pop();
      }
    } on FirebaseException catch (e) {
      CustomAlert.show(message: e.message ?? 'Something went wrong');
    } finally {
      isLoading = false;
    }
  }

  Future<void> deleteTask(TaskModel model) async {
    try {
      await databaseService.deleteTask(model);
    } on FirebaseException catch (e) {
      CustomAlert.show(message: e.message ?? 'Something went wrong');
    } finally {
      isLoading = false;
    }
  }

  bool get isLoading => _isLoading;
}

Query getTask() {
  final userId = FirebaseAuth.instance.currentUser!.uid;
  return FirebaseDatabase.instance.ref().child('Task').orderByChild('userId').equalTo(userId);
}
