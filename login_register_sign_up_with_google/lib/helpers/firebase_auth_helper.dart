import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseAuthHelper {
  FirebaseAuthHelper._();
  static final FirebaseAuthHelper firebaseAuthHelper = FirebaseAuthHelper._();

  static final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  static final GoogleSignIn googleSignIn = GoogleSignIn();

  Future<User?> SignInAnonymously() async {
    try {
      UserCredential userCredential = await firebaseAuth.signInAnonymously();

      User? user = userCredential.user;

      return user;
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'admin-restricted-operation':
          print("================================");
          print(" This operation is restricted to administrators only.");
          print("================================");
          break;
        case 'operation-not-allowed':
          print("================================");
          print("operation-not-allowed");
          print("================================");
          break;
      }
    }
  }

  Future<User?> SignUPUser(
      {required String email, required String password}) async {
    try {
      UserCredential userCredential = await firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);

      User? user = userCredential.user;

      return user;
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'weak-password':
          print("===========================");
          print("Password at least 6 character");
          print("===========================");
          break;
        case 'email-already-in-use':
          print("===========================");
          print("This User in already exists");
          print("===========================");
          break;
      }
    }
  }

  Future<User?> SignINUser(
      {required String email, required String password}) async {
    // UserCredential userCredential = await firebaseAuth
    //     .signInWithEmailAndPassword(email: email, password: password);
    //
    // User? user = userCredential.user;
    //
    // return user;

    try {
      UserCredential userCredential = await firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);

      User? user = userCredential.user;

      return user;
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'wrong-password':
          print("===========================");
          print("wrong-password");
          print("===========================");
          break;
        case 'user-not-found':
          print("===========================");
          print("This User is not Created yet");
          print("===========================");
          break;
      }
    }
  }

  Future<User?> SignWithGoogle() async {
    final GoogleSignInAccount? googleUser = await googleSignIn.signIn();

    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    UserCredential userCredential =
        await firebaseAuth.signInWithCredential(credential);
    User? user = userCredential.user;
    return user;
  }

  Future<void> SignOut() async {
    await firebaseAuth.signOut();
    await googleSignIn.signOut();
  }
}
