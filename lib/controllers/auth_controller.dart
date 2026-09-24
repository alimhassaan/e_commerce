import 'package:e_commerce/services/auth.dart';
import 'package:flutter/foundation.dart';

class AuthController with ChangeNotifier {
  final AuthBase auth;
  String email;
  String password;

  AuthController({required this.auth, this.email = '', this.password = ''});

  Future<void> submitSignup() async {
    try {
      await auth.signupWithEmailAndPassword(email, password);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> submitLogin() async {
    try {
      await auth.loginWithEmailAndPassword(email, password);
    } catch (e) {
      rethrow;
    }
  }

  void updateEmail(String email) => copyWith(email: email);
  void updatePassword(String password) => copyWith(password: password);

  void copyWith({String? email, String? password}) {
    this.email = email ?? this.email;
    this.password = password ?? this.password;
    notifyListeners();
  }
}
