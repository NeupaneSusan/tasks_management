import 'package:firebase_database/firebase_database.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:taskmgt/core/service/database_service.dart';
import 'package:taskmgt/model/user_model.dart';

class AuthService {
  final GoogleSignIn googleSignIn;
  final DatabaseService databaseService;
  AuthService(this.googleSignIn, this.databaseService);
  Future<GoogleSignInAccount?> googleLogin() async {
    final googleUser = await googleSignIn.signIn();
    return googleUser;
  }

  Future createUser(UserModel userModel) async {
    return await databaseService.createUser(userModel);
  }

  Future<DataSnapshot> getAllUser() async {
    return await databaseService.getAllUser();
  }
}
