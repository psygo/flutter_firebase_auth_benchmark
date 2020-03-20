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
  String _errorMsg;

  Auth();

  AuthStatus get authStatus => _authStatus;
  FirebaseUser get user => _user;
  String get errorMsg => _errorMsg;

  bool _userIsNotNull() => _user != null;
  AuthStatus _userIsLoggedInOrNot() =>
      _userIsNotNull() ? AuthStatus.logged_in : AuthStatus.not_logged_in;

  @override
  Future<bool> signInWithEmailAndPassword(
      {@required String email, @required String password}) async {
    bool errorOccurred;
    try {
      final AuthResult authResult = await AuthInterface.fireAuthInstance
        .signInWithEmailAndPassword(email: email, password: password);

      _user = authResult.user;
      _authStatus = _userIsLoggedInOrNot();

      return true;
    } on PlatformException catch (e) {
      errorOccurred = true;
      switch (e.code){
        case 'ERROR_WRONG_PASSWORD':
          _errorMsg = 'wrong password';
          break;
        case 'ERROR_USER_NOT_FOUND':
          _errorMsg = 'user not found';
          break;
        default:
          throw UnknownSignUpError('Unknown error for sign up with Firebase.');
      }
    } catch (e) {
      errorOccurred = true;
      rethrow;
    } finally {
      notifyListeners();
      await Future.delayed(Duration(milliseconds: 300));
      if (errorOccurred) {
        return false;
      } else {
        return true;
      }
    }
  }

  @override
  Future<bool> signUp(
      {@required String email, @required String password}) async {
    bool errorOccurred;
    try {
      final AuthResult authResult = await AuthInterface.fireAuthInstance
        .createUserWithEmailAndPassword(email: email, password: password);

      _user = authResult.user;
      _authStatus = _userIsLoggedInOrNot();

      return true;
    } on PlatformException catch(e) {
      errorOccurred = true;
      switch (e.code){
        case 'ERROR_EMAIL_ALREADY_IN_USE':
          _errorMsg = 'user already exists';
          break;
        default:
          throw UnknownSignUpError('Unknown error for sign up with Firebase.');
      }
    } catch (e) {
      errorOccurred = true;
      rethrow;
    } finally {
      notifyListeners();
      await Future.delayed(Duration(milliseconds: 300));
      if (errorOccurred) {
        return false;
      } else {
        return true;
      }
    }
  }

  @override
  Future<void> sendPasswordResetWithEmail({@required String email}) async {
    try {
      await AuthInterface.fireAuthInstance.sendPasswordResetEmail(email: email);
    } on PlatformException catch (e) {
      switch (e.code) {
        case 'ERROR_USER_NOT_FOUND':
          _errorMsg = 'user not found';
          break;
        default:
          throw UnknownPasswordResetError(
              'Unknown error for password reset with Firebase.');
      }
    } catch (e) {
      rethrow;
    } finally {
      notifyListeners();
      await Future.delayed(Duration(milliseconds: 300));
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
