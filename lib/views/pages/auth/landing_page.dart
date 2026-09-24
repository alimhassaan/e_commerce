import 'package:e_commerce/controllers/auth_controller.dart';
import 'package:e_commerce/services/auth.dart';
import 'package:e_commerce/views/pages/auth/login_page.dart';
import 'package:e_commerce/views/pages/bottom_navbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthBase>(context, listen: false);
    return StreamBuilder<User?>(
      stream: auth.authStateChanges(),
      builder: (context, asyncSnapshot) {
        if (asyncSnapshot.connectionState == ConnectionState.active) {
          final user = asyncSnapshot.data;
          if (user == null) {
            return ChangeNotifierProvider<AuthController>(
              create: (_) => AuthController(auth: auth),
              child: const LoginPage(),
            );
          }
          return const BottomNavbar();
        }
        return Scaffold(body: Center(child: CircularProgressIndicator()));
      },
    );
  }
}
