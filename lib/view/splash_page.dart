import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taskmgt/core/constant/app_color.dart';
import 'package:taskmgt/core/constant/text_style.dart';
import 'package:taskmgt/provider/auth_provider.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<AuthsProvider>().checkLogin();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            spacing: 10,
            children: [
              Text('Easy Task Creation', style: AppTextStyle.font28W5),
              Text(
                'Quickly add task,set due dates,add description with ease using our task manager app.Simplify your workflow and stay organized.',
                textAlign: TextAlign.center,
                style: AppTextStyle.font14.copyWith(color: AppColor.lightColor),
              ),
              SizedBox(height: 10),
              CircularProgressIndicator.adaptive(),
            ],
          ),
        ),
      ),
    );
  }
}
