import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:meta/meta.dart';

import '../exceptions/login.dart';

enum AuthStatus {
  not_determined,
  not_logged_in,
  logged_in,
}

abstract class AuthInterface extends ChangeNotifier {
  static final FirebaseAuth fireAuthInstance = FirebaseAuth.instance;

  Future<void> signInWithEmailAndPassword(
      {@required String email, @required String password});
  Future<void> signUp({@required String email, @required String password});
  Future<void> sendPasswordResetWithEmail({@required String email});
  Future<void> updateCurrentUserFromFirebase();
  Future<void> signOut();
  Future<void> deleteUser();
}

class Auth extends ChangeNotifier implements AuthInterface {
  AuthStatus _authStatus = AuthStatus.not_determined;
  FirebaseUser _user;
  String _resetEmail;
  String _errorMsg;

  Auth();

  AuthStatus get authStatus => _authStatus;
  FirebaseUser get user => _user;
  String get resetEmail => _resetEmail;
  String get errorMsg => _errorMsg;

  bool _userIsNotNull() => _user != null;
  AuthStatus _userIsLoggedInOrNot() =>
      _userIsNotNull() ? AuthStatus.logged_in : AuthStatus.not_logged_in;

  @override
  Future<void> signInWithEmailAndPassword(
      {@required String email, @required String password}) async {
    AuthResult authResult = await AuthInterface.fireAuthInstance
        .signInWithEmailAndPassword(email: email, password: password);

    _user = authResult.user;
    _authStatus = _userIsLoggedInOrNot();
  }

  @override
  Future<void> signUp(
      {@required String email, @required String password}) async {
    AuthResult authResult = await AuthInterface.fireAuthInstance
        .createUserWithEmailAndPassword(email: email, password: password);

    _user = authResult.user;
    _authStatus = _userIsLoggedInOrNot();
  }

  @override
  Future<void> sendPasswordResetWithEmail({@required String email}) async {
    await AuthInterface.fireAuthInstance
        .sendPasswordResetEmail(email: email)
        .catchError((e) {
      switch (e.code) {
        case 'ERROR_USER_NOT_FOUND':
          _errorMsg = 'user not found';
          notifyListeners();
          break;
        default:
          throw UnknownPasswordReset(
              'Unknown error for password reset with Firebase.');
      }
    });

    _resetEmail = email;
  }

  @override
  Future<void> updateCurrentUserFromFirebase() async {
    _user = await AuthInterface.fireAuthInstance.currentUser();
    _authStatus = _userIsLoggedInOrNot();
    notifyListeners();
  }

  @override
  Future<void> signOut() async {
    await AuthInterface.fireAuthInstance.signOut();
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
