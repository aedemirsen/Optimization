import 'package:firebase_auth/firebase_auth.dart';

final FirebaseAuth auth = FirebaseAuth.instance;

class Authentication {
  //sign in
  Future<User?> signInWithEmail(
      {required String mail, required String password}) async {
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
          email: mail, password: password);
      print("Giriş yapıldı.${userCredential.user!.email}");
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == "user-not-found") {
        print("Kullanıcı bulunamadı.");
      } else {
        print("Hatalı şifre.");
      }
    }
  }
}
