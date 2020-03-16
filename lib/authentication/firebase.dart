import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

abstract class BaseAuth {
  static final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  Future<bool> signIn({@required String email, @required String password});
  Future<bool> signUp({@required String email, @required String password});
  Future<FirebaseUser> getCurrentUser();
  Future<void> signOut();
}

class Auth implements BaseAuth {
  @override
  Future<bool> signIn({String email, String password}) async {
    AuthResult authResult = await BaseAuth.firebaseAuth
        .signInWithEmailAndPassword(email: email, password: password);
    FirebaseUser user = authResult.user;
    return user != null;
  }

  @override
  Future<bool> signUp({String email, String password}) async {
    AuthResult authResult = await BaseAuth.firebaseAuth
        .createUserWithEmailAndPassword(email: email, password: password);
    FirebaseUser user = authResult.user;
    return user != null;
  }

  @override
  Future<FirebaseUser> getCurrentUser() async =>
      await BaseAuth.firebaseAuth.currentUser();

  @override
  Future<void> signOut() async => await BaseAuth.firebaseAuth.signOut();
}
