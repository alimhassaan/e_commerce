import 'package:e_commerce/helper/context_extension.dart';
import 'package:e_commerce/utilities/app_routes.dart';
import 'package:e_commerce/views/widgets/custom_text_field.dart';
import 'package:e_commerce/views/widgets/login_with.dart';
import 'package:e_commerce/views/widgets/main_buttom.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 32.0),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Gap(30),
                  Text(
                    'Login',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Gap(8),
                  Text(
                    'Welcome back! Please login to your account',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const Gap(100),
                  CustomTextField(
                    controller: _emailController,
                    labelText: 'Email',
                    hintText: 'Enter your Email',
                    validator: (value) => value == null || value.trim().isEmpty
                        ? 'Please enter your email'
                        : null,
                  ),
                  const Gap(16),
                  CustomTextField(
                    controller: _passwordController,
                    labelText: 'Password',
                    hintText: 'Enter your password',
                    obscureText: true,
                    validator: (value) => value == null || value.isEmpty
                        ? 'Please enter your password'
                        : null,
                  ),
                  const Gap(32),
                  Align(
                    alignment: Alignment.topRight,
                    child: InkWell(
                      child: const Text('Forgot Password?'),
                      onTap: () {},
                    ),
                  ),
                  const Gap(32),
                  MainButtom(text: 'Login', onPressed: () {}),
                  const Gap(20),
                  Align(
                    alignment: Alignment.center,
                    child: InkWell(
                      child: RichText(
                        text: const TextSpan(
                          style: TextStyle(
                            color: Colors.black,
                          ), // اللون الأساسي للنص
                          children: [
                            TextSpan(text: "Don't have an account? "),
                            TextSpan(
                              text: 'Sign Up',
                              style: TextStyle(
                                color: Colors.red,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      onTap: () {
                        context.pushNamed(AppRoutes.signupPageRoute);
                      },
                    ),
                  ),
                  const Gap(32),
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      'Or login with',
                      style: Theme.of(
                        context,
                      ).textTheme.bodyMedium?.copyWith(color: Colors.black),
                    ),
                  ),
                  const Gap(16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      LoginWith(photo: 'assets/images/google.png'),
                      const Gap(16),
                      LoginWith(photo: 'assets/images/facebook.png'),
                      const Gap(16),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
