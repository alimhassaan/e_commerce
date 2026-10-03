import 'package:e_commerce/controllers/auth_controller.dart';
import 'package:e_commerce/services/auth.dart';
import 'package:e_commerce/utilities/app_routes.dart';
import 'package:e_commerce/utilities/context_extension.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            final authController = AuthController(auth: Auth());
            await authController.logout();
            if (!context.mounted) return;
            // Navigate to the login page or any other page after logout
            context.pushReplacementNamed(AppRoutes.loginPageRoute);
          },
          child: const Text('Logout'),
        ),
      )
    );
  }
}
