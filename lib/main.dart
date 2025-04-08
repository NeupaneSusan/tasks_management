import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:taskmgt/core/constant/key.dart';
import 'package:taskmgt/core/service/auth_service.dart';
import 'package:taskmgt/core/service/database_service.dart';
import 'package:taskmgt/firebase_options.dart';
import 'package:taskmgt/provider/auth_provider.dart';
import 'package:taskmgt/provider/task_provider.dart';
import 'package:taskmgt/view/splash_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  GoogleSignIn googleSignIn = GoogleSignIn();
  AuthService authService = AuthService(googleSignIn);
  DatabaseService dataBaseService = DatabaseService();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthsProvider>(create: (_) => AuthsProvider(authService)),
        ChangeNotifierProvider(create: (_) => TaskProvider(dataBaseService)),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: KeyConstant.navigatorKey,
      scaffoldMessengerKey: KeyConstant.scaffoldMessengerKey,
      title: 'Task Management',
      theme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple)),
      home: SplashPage(),
    );
  }
}
