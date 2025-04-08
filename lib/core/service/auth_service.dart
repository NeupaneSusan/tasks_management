import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  final GoogleSignIn googleSignIn;
  AuthService(this.googleSignIn);
  Future<GoogleSignInAccount?> googleLogin() async {
    final googleUser = await googleSignIn.signIn();
    return googleUser;
  }
}
