import 'package:firebase_database/firebase_database.dart';
import 'package:taskmgt/model/task_model.dart';
import 'package:taskmgt/model/user_model.dart';

class DatabaseService {
  FirebaseDatabase database = FirebaseDatabase.instance;

  Future createTask(TaskModel model) async {
    return await database.ref('Task').child(model.id).set(model.toJson());
  }

  Future updateTask(TaskModel model) async {
    return await database.ref('Task').child(model.id).update(model.toJson());
  }

  Future deleteTask(TaskModel model) async {
    return await database.ref('Task').child(model.id).remove();
  }

  Future createUser(UserModel model) async {
    return await database.ref('User').child(model.userId).set(model.toJson());
  }

  Future<DataSnapshot> getAllUser() async {
    return await database.ref('User').get();
  }
}
