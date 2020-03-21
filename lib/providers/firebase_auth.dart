import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:meta/meta.dart';

import '../exceptions/login.dart';

enum AuthStatus {
  not_determined,
  not_logged_in,
  logged_in,
}

abstract class AuthInterface extends ChangeNotifier {
  static final FirebaseAuth fireAuthInstance = FirebaseAuth.instance;

  Future<bool> signInWithEmailAndPassword(
      {@required String email, @required String password});
  Future<bool> signUp({@required String email, @required String password});
  Future<void> sendPasswordResetWithEmail({@required String email});
  Future<void> updateCurrentUserFromFirebase();
  Future<void> signOut();
  Future<void> deleteUser();
}

class Auth extends ChangeNotifier implements AuthInterface {
  AuthStatus _authStatus = AuthStatus.not_determined;
  FirebaseUser _user;
  String _emailErrorMsg;
  String _passwordErrorMsg;

  Auth();

  AuthStatus get authStatus => _authStatus;
  FirebaseUser get user => _user;
  String get emailErrorMsg => _emailErrorMsg;
  String get passwordErrorMsg => _passwordErrorMsg;

  bool _userIsNotNull() => _user != null;
  AuthStatus _userIsLoggedInOrNot() =>
      _userIsNotNull() ? AuthStatus.logged_in : AuthStatus.not_logged_in;
  bool _requestSuccessful(bool errorOccurred) => !errorOccurred;
  void _updateUser(AuthResult authResult){
    _user = authResult.user;
    _authStatus = _userIsLoggedInOrNot();
  }

  @override
  Future<bool> signInWithEmailAndPassword(
      {@required String email, @required String password}) async {
    bool errorOccurred;
    try {
      final AuthResult authResult = await AuthInterface.fireAuthInstance
          .signInWithEmailAndPassword(email: email, password: password);

      _updateUser(authResult);

      errorOccurred = false;
    } on PlatformException catch (e) {
      errorOccurred = true;
      _signInErrorHandler(e);
      // switch (e.code) {
      //   case 'ERROR_USER_NOT_FOUND':
      //     _emailErrorMsg = 'user not found';
      //     _passwordErrorMsg = null;
      //     break;
      //   case 'ERROR_WRONG_PASSWORD':
      //     _emailErrorMsg = null;
      //     _passwordErrorMsg = 'wrong password';
      //     break;
      //   default:
      //     throw UnknownSignInError('Unknown error for sign up with Firebase.');
      // }
    } catch (e) {
      errorOccurred = true;
      rethrow;
    } finally {
      notifyListeners();
      return _requestSuccessful(errorOccurred);
    }
  }

  void _signInErrorHandler(PlatformException platformException){
    switch (platformException.code) {
      case 'ERROR_USER_NOT_FOUND':
        _emailErrorMsg = 'user not found';
        _passwordErrorMsg = null;
        break;
      case 'ERROR_WRONG_PASSWORD':
        _emailErrorMsg = null;
        _passwordErrorMsg = 'wrong password';
        break;
      default:
        throw UnknownSignInError('Unknown error for sign up with Firebase.');
    }
  }

  @override
  Future<bool> signUp(
      {@required String email, @required String password}) async {
    bool errorOccurred;
    try {
      final AuthResult authResult = await AuthInterface.fireAuthInstance
          .createUserWithEmailAndPassword(email: email, password: password);

      _updateUser(authResult);

      errorOccurred = false;
    } on PlatformException catch (e) {
      errorOccurred = true;
      _signUpErrorHandler(e);
      // switch (e.code) {
      //   case 'ERROR_EMAIL_ALREADY_IN_USE':
      //     _emailErrorMsg = 'user already exists';
      //     _passwordErrorMsg = null;
      //     break;
      //   default:
      //     throw UnknownSignUpError('Unknown error for sign up with Firebase.');
      // }
    } catch (e) {
      errorOccurred = true;
      rethrow;
    } finally {
      notifyListeners();
      return _requestSuccessful(errorOccurred);
    }
  }

  void _signUpErrorHandler(PlatformException platformException){
    switch (platformException.code) {
      case 'ERROR_EMAIL_ALREADY_IN_USE':
        _emailErrorMsg = 'user already exists';
        _passwordErrorMsg = null;
        break;
      default:
        throw UnknownSignUpError('Unknown error for sign up with Firebase.');
    }
  }

  @override
  Future<void> sendPasswordResetWithEmail({@required String email}) async {
    try {
      await AuthInterface.fireAuthInstance.sendPasswordResetEmail(email: email);
    } on PlatformException catch (e) {
      _passwordResetWithEmailErrorHandler(e);
      // switch (e.code) {
      //   case 'ERROR_USER_NOT_FOUND':
      //     _emailErrorMsg = 'user not found';
      //     _passwordErrorMsg = null;
      //     break;
      //   default:
      //     throw UnknownPasswordResetError(
      //         'Unknown error for password reset with Firebase.');
      // }
    } catch (e) {
      rethrow;
    } finally {
      notifyListeners();
    }
  }

  void _passwordResetWithEmailErrorHandler(PlatformException platformException){
    switch (platformException.code) {
      case 'ERROR_USER_NOT_FOUND':
        _emailErrorMsg = 'user not found';
        _passwordErrorMsg = null;
        break;
      default:
        throw UnknownPasswordResetError(
            'Unknown error for password reset with Firebase.');
    }
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
