import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:meta/meta.dart';

enum AuthStatus {
  not_determined,
  not_logged_in,
  logged_in,
}

abstract class BaseAuth extends ChangeNotifier {
  static final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  Future<void> signInWithEmailAndPassword(
      {@required String email, @required String password});
  Future<void> signUp({@required String email, @required String password});
  Future<void> sendPasswordResetWithEmail({@required String email});
  Future<FirebaseUser> getCurrentUserFromFirebase();
  Future<void> signOut();
  Future<void> deleteUser();
}

class Auth extends ChangeNotifier implements BaseAuth {
  AuthStatus _authStatus = AuthStatus.not_determined;
  FirebaseUser _user;
  String _resetEmail;

  Auth();

  AuthStatus get authStatus => _authStatus;
  FirebaseUser get user => _user;
  String get resetEmail => _resetEmail;

  bool _userIsNotNull() => _user != null;
  AuthStatus _userIsLoggedInOrNot() =>
      _userIsNotNull() ? AuthStatus.logged_in : AuthStatus.not_logged_in;

  @override
  Future<void> signInWithEmailAndPassword(
      {@required String email, @required String password}) async {
    AuthResult authResult = await BaseAuth.firebaseAuth
        .signInWithEmailAndPassword(email: email, password: password);

    _user = authResult.user;
    _authStatus = _userIsLoggedInOrNot();
  }

  @override
  Future<void> signUp(
      {@required String email, @required String password}) async {
    AuthResult authResult = await BaseAuth.firebaseAuth
        .createUserWithEmailAndPassword(email: email, password: password);

    _user = authResult.user;
    _authStatus = _userIsLoggedInOrNot();
  }

  @override
  Future<void> sendPasswordResetWithEmail({@required String email}) async {
    await BaseAuth.firebaseAuth.sendPasswordResetEmail(email: email);
    _resetEmail = email;
  }

  @override
  Future<FirebaseUser> getCurrentUserFromFirebase() async =>
      await BaseAuth.firebaseAuth.currentUser();

  @override
  Future<void> signOut() async {
    await BaseAuth.firebaseAuth.signOut();
    _user = null;
    _authStatus = _userIsLoggedInOrNot();
  }

  @override
  Future<void> deleteUser() async {
    await _user?.delete();
    _user = null;
    _authStatus = AuthStatus.not_determined;
  }
}
