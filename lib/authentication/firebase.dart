import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:meta/meta.dart';

enum AuthStatus { not_determined, not_logged_in, logged_in }

abstract class BaseAuth extends ChangeNotifier {
  static final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  Future<void> signInWithEmailAndPassword(
      {@required String email, @required String password});
  Future<void> signUp({@required String email, @required String password});
  Future<FirebaseUser> getCurrentUser();
  Future<void> signOut();
}

class Auth extends ChangeNotifier implements BaseAuth {
  AuthStatus _authStatus = AuthStatus.not_determined;

  Auth();

  AuthStatus get authStatus => _authStatus;

  AuthStatus userIsNullOrNot(FirebaseUser user) =>
      user != null ? AuthStatus.logged_in : AuthStatus.not_logged_in;

  @override
  Future<void> signInWithEmailAndPassword(
      {String email, String password}) async {
    AuthResult authResult = await BaseAuth.firebaseAuth
        .signInWithEmailAndPassword(email: email, password: password);
    FirebaseUser user = authResult.user;
    _authStatus = userIsNullOrNot(user);
  }

  @override
  Future<void> signUp({String email, String password}) async {
    AuthResult authResult = await BaseAuth.firebaseAuth
        .createUserWithEmailAndPassword(email: email, password: password);
    FirebaseUser user = authResult.user;
    _authStatus = userIsNullOrNot(user);
  }

  @override
  Future<FirebaseUser> getCurrentUser() async =>
      await BaseAuth.firebaseAuth.currentUser();

  @override
  Future<void> signOut() async => await BaseAuth.firebaseAuth.signOut();
}
