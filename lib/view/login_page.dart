import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taskmgt/core/constant/app_color.dart';
import 'package:taskmgt/core/constant/board_radius.dart';
import 'package:taskmgt/core/constant/image_path.dart';
import 'package:taskmgt/core/constant/text_style.dart';
import 'package:taskmgt/provider/auth_provider.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          spacing: 10,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Hey There,\nWelcome Back', style: AppTextStyle.font28W5),
            Text('Login to your account to continue', style: AppTextStyle.font18),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                if (!context.read<AuthsProvider>().isLoading) {
                  context.read<AuthsProvider>().googleLogin();
                }
              },
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 10),
                backgroundColor: AppColor.whiteColor, // Blue Button Color

                fixedSize: Size(double.maxFinite, 50),
                shape: RoundedRectangleBorder(borderRadius: AppBoardRadius.borderRadius10),
              ),
              child: Consumer<AuthsProvider>(
                builder: (context, data, child) {
                  return data.isLoading
                      ? CircularProgressIndicator.adaptive()
                      : Row(
                        spacing: 10,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [Image.asset(ImagePath.googleImage), Text('Sign in with Google', style: AppTextStyle.font15)],
                      );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
