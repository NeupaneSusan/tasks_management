import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taskmgt/core/constant/key.dart';
import 'package:taskmgt/provider/auth_provider.dart';

class CustomDialog {
  static BuildContext context = KeyConstant.navigatorKey.currentState!.context;
  static showLogoutDialog() {
    // Show the alert dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirm Logout'),
          content: Text('Are you sure you want to log out?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('Cancel'),
            ),

            TextButton(
              onPressed: () {
                context.read<AuthsProvider>().logout();
              },
              child: Text('Logout'),
            ),
          ],
        );
      },
    );
  }
}
