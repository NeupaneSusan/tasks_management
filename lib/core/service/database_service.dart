import 'package:firebase_database/firebase_database.dart';
import 'package:taskmgt/model/task_model.dart';

class DatabaseService {
  DatabaseReference database = FirebaseDatabase.instance.ref('Task');

  Future createTask(TaskModel model) async {
    return await database.child(model.id).set(model.toJson());
  }

  Future updateTask(TaskModel model) async {
    return await database.child(model.id).update(model.toJson());
  }

  Future deleteTask(TaskModel model) async {
    return await database.child(model.id).remove();
  }
}
