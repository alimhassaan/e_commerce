import 'package:e_commerce/utilities/app_routes.dart';
import 'package:e_commerce/views/pages/auth/landing_page.dart';
import 'package:e_commerce/views/pages/bottom_navbar.dart';
import 'package:e_commerce/views/pages/auth/login_page.dart';
import 'package:e_commerce/views/pages/auth/signup_page.dart';
import 'package:flutter/cupertino.dart';

Route<dynamic>? generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case AppRoutes.signupPageRoute:
      return CupertinoPageRoute(builder: (_) => const SignupPage());
    case AppRoutes.loginPageRoute:
      return CupertinoPageRoute(builder: (_) => const LoginPage());
    case AppRoutes.bottomNavBar:
      return CupertinoPageRoute(builder: (_) => const BottomNavbar());
    case AppRoutes.landingPageRoute:
       return CupertinoPageRoute(builder: (_) => const LandingPage());  

    default:
      return null;
  }
}
