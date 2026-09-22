import 'package:e_commerce/utilities/app_routes.dart';
import 'package:e_commerce/views/pages/login_page.dart';
import 'package:e_commerce/views/pages/signup_page.dart';
import 'package:flutter/cupertino.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case AppRoutes.signupPageRoute:
      return CupertinoPageRoute(builder: (_) => const SignupPage());
    case AppRoutes.loginPageRoute:
      return CupertinoPageRoute(builder: (_) => const LoginPage());

    default:
      return CupertinoPageRoute(
        builder: (_) =>
            Center(child: Text('No route defined for ${settings.name}')),
      );
  }
}
