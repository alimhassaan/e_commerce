// ignore_for_file: use_build_context_synchronously

import 'package:e_commerce/controllers/auth_controller.dart';
import 'package:e_commerce/services/auth.dart';
import 'package:e_commerce/utilities/context_extension.dart';
import 'package:e_commerce/utilities/app_routes.dart';
import 'package:e_commerce/views/widgets/custom_text_field.dart';
import 'package:e_commerce/views/widgets/login_with.dart';
import 'package:e_commerce/views/widgets/main_buttom.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _emailFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthBase>(context);

    return ChangeNotifierProvider<AuthController>(
      create: (_) => AuthController(auth: auth),
      child: Consumer<AuthController>(
        builder: (_, model, _) {
          return Scaffold(
            resizeToAvoidBottomInset: true,
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 32.0,
                  vertical: 32.0,
                ),
                child: Form(
                  key: _formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Gap(30),
                        Text(
                          'Sign Up',
                          style: Theme.of(context).textTheme.headlineSmall
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                        const Gap(8),
                        Text(
                          'Create a new account',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        const Gap(100),
                        CustomTextField(
                          controller: _emailController,
                          labelText: 'Email',
                          hintText: 'Enter your Email',
                          validator: (value) => value.isNullOrEmpty()
                              ? 'Please Enter your Email'
                              : null,
                          focusNode: _emailFocusNode,
                          onEditingComplete: () => FocusScope.of(
                            context,
                          ).requestFocus(_passwordFocusNode),
                          textInputAction: TextInputAction.next,
                          onChanged: model.updateEmail,
                        ),
                        const Gap(16),
                        CustomTextField(
                          controller: _passwordController,
                          labelText: 'Password',
                          hintText: 'Enter your password',
                          obscureText: true,

                          validator: (value) => value.isNullOrEmpty()
                              ? 'Please Enter your password'
                              : null,
                          focusNode: _passwordFocusNode,
                          onEditingComplete: () =>
                              FocusScope.of(context).unfocus(),
                          textInputAction: TextInputAction.done,
                          onChanged: model.updatePassword,
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
                        MainButtom(
                          text: 'Sign Up',
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              _submit(model,context);
                            }
                          },
                        ),
                        const Gap(20),
                        Align(
                          alignment: Alignment.center,
                          child: InkWell(
                            child: RichText(
                              text: const TextSpan(
                                style: TextStyle(color: Colors.black),
                                children: [
                                  TextSpan(text: "Already have an account? "),
                                  TextSpan(
                                    text: 'Login',
                                    style: TextStyle(
                                      color: Colors.red,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            onTap: () {
                              context.pushReplacementNamed(
                                AppRoutes.loginPageRoute,
                              );
                            },
                          ),
                        ),
                        const Gap(50),

                        Align(
                          alignment: Alignment.center,
                          child: Text(
                            'Or Sign Up with',
                            style: Theme.of(context).textTheme.bodyMedium
                                ?.copyWith(color: Colors.black),
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
        },
      ),
    );
  }
}

Future<void> _submit(AuthController model, BuildContext context) async {
  try {
    await model.submitSignup();

    context.pushNamed(AppRoutes.bottomNavBar);
  } catch (e) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(
          'Error!',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        content: Text(
          e.toString(),
          style: Theme.of(context).textTheme.titleMedium,
        ),
        actions: [
          TextButton(onPressed: () => context.pop(), child: Text('Ok')),
        ],
      ),
    );
  }
}
