import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:taskmgt/core/constant/app_color.dart';
import 'package:taskmgt/core/service/auth_service.dart';
import 'package:taskmgt/core/utils/custom_alert.dart';
import 'package:taskmgt/core/utils/routes.dart';
import 'package:taskmgt/model/user_model.dart';
import 'package:taskmgt/view/home_page.dart';
import 'package:taskmgt/view/login_page.dart';

class AuthsProvider extends ChangeNotifier {
  final AuthService authService;
  final _auth = FirebaseAuth.instance;
  AuthsProvider(this.authService);

  bool _isLoading = false;

  List<UserModel> _userList = [];
  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  Future<void> googleLogin() async {
    try {
      isLoading = true;
      final googleUser = await authService.googleLogin();
      if (googleUser != null) {
        final user = await googleUser.authentication;
        final credential = GoogleAuthProvider.credential(idToken: user.idToken, accessToken: user.accessToken);

        final userData = await _auth.signInWithCredential(credential);
        if (userData.additionalUserInfo!.isNewUser) {
          await authService.createUser(UserModel(userId: _auth.currentUser!.uid, fullName: _auth.currentUser!.displayName!));
        }
        Routes.routesPushRemoveUntil(HomePage());
        CustomAlert.show(message: 'Successfully logged in.', backgroundColor: AppColor.greenColor);
      }
    } on FirebaseAuthException catch (e) {
      CustomAlert.show(message: e.message ?? 'Something went wrong');
    } on SocketException catch (_) {
      CustomAlert.show(message: 'No internet connection. Please check your network.');
    } catch (error) {
      CustomAlert.show(message: error.toString());
    } finally {
      isLoading = false;
    }
  }

  void checkLogin() {
    Future.delayed(Duration(seconds: 2), () {
      User? user = _auth.currentUser;
      if (user != null) {
        Routes.routesPushRemoveUntil(HomePage());
        return;
      }
      Routes.routesPushRemoveUntil(LoginPage());
    });
  }

  void logout() {
    _auth.signOut();
    Routes.routesPushRemoveUntil(LoginPage());
  }

  void getAllUser() async {
    try {
      final snapshot = await authService.getAllUser();
      if (snapshot.exists) {
        final data = Map<String, dynamic>.from(snapshot.value as Map);
        List<UserModel> users = [];
        data.forEach((key, value) {
          users.add(UserModel.fromJson(Map<String, dynamic>.from(value)));
        });
        _userList = users;
      }
    } on FirebaseAuthException catch (e) {
      CustomAlert.show(message: e.message ?? 'Something went wrong');
    } on SocketException catch (_) {
      CustomAlert.show(message: 'No internet connection. Please check your network.');
    } catch (error) {
      CustomAlert.show(message: error.toString());
    } finally {
      isLoading = false;
    }
  }

  bool get isLoading => _isLoading;

  List<UserModel> get userList => _userList;
}
