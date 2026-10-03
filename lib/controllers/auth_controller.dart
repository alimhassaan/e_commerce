import 'package:e_commerce/controllers/database_controller.dart';
import 'package:e_commerce/models/user_data.dart';
import 'package:e_commerce/services/auth.dart';
import 'package:e_commerce/utilities/constans.dart';
import 'package:flutter/foundation.dart';

class AuthController with ChangeNotifier {
  final AuthBase auth;
  String email;
  String password;
  // todo this is a temporary solution, we will get the uid from the auth service later
  final FirestoreDatabase database = FirestoreDatabase('123');

  AuthController({required this.auth, this.email = '', this.password = ''});

  Future<void> submitSignup() async {
    try {
     final user = await auth.signupWithEmailAndPassword(email, password);
      await database.setUserData(
        UserData(uid:user?.uid ??documentIdFromLocalDatabase(), email: email),
      );
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

  Future<void> logout() async {
    try {
      await auth.logout();
    } catch (e) {
      rethrow;
    }
  }
}
