import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

final GoogleSignIn _googleSignIn = GoogleSignIn.instance;
final Future<void> _googleSignInInitialization = _googleSignIn.initialize();

Future<UserCredential?> signInWithGoogle() async {
  try {
    await _googleSignInInitialization;
    final GoogleSignInAccount googleUser = await _googleSignIn.authenticate();
    final GoogleSignInAuthentication googleAuth = googleUser.authentication;
    final OAuthCredential credential = GoogleAuthProvider.credential(
      idToken: googleAuth.idToken,
    );
    return await FirebaseAuth.instance.signInWithCredential(credential);
  } on GoogleSignInException catch (error) {
    if (error.code == GoogleSignInExceptionCode.canceled) {
      return null;
    }
    rethrow;
  }
}
