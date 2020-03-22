import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:meta/meta.dart';

import 'login_workflow_provider.dart';
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
  Future<void> signInWithGoogle(
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
  String _emailErrorMsg;
  String _passwordErrorMsg;

  Auth();

  AuthStatus get authStatus => _authStatus;
  FirebaseUser get user => _user;
  String get emailErrorMsg => _emailErrorMsg;
  String get passwordErrorMsg => _passwordErrorMsg;
  bool get errorOccurred => _emailErrorMsg != null || _passwordErrorMsg != null;
  bool get noErrorOccurred => !errorOccurred;

  @override
  Future<void> signInWithEmailAndPassword({
    @required String email,
    @required String password,
  }) async {
    _resetErrorMsgs();
    try {
      final AuthResult authResult = await AuthInterface.fireAuthInstance
          .signInWithEmailAndPassword(email: email, password: password);

      _updateUser(authResult);
    } on PlatformException catch (e) {
      _errorHandler(e, LoginSubWorkflow.signIn);
    } catch (e) {
      rethrow;
    } finally {
      notifyListeners();
    }
  }

  @override
  Future<void> signInWithGoogle({
    @required String email,
    @required String password,
  }) async {
    try {
      final GoogleSignIn googleSignIn = GoogleSignIn();
      final GoogleSignInAccount googleAccount = await googleSignIn.signIn();
      final GoogleSignInAuthentication googleAuth =
          await googleAccount.authentication;

      final AuthCredential googleCredential = GoogleAuthProvider.getCredential(
          idToken: googleAuth.idToken, accessToken: googleAuth.accessToken);

      final AuthResult authResult = await AuthInterface.fireAuthInstance
          .signInWithCredential(googleCredential);

      _updateUser(authResult);
    } catch (e) {
      rethrow;
    } finally {
      notifyListeners();
    }
  }

  @override
  Future<void> signUp({
    @required String email,
    @required String password,
  }) async {
    _resetErrorMsgs();
    try {
      final AuthResult authResult = await AuthInterface.fireAuthInstance
          .createUserWithEmailAndPassword(email: email, password: password);

      _updateUser(authResult);
    } on PlatformException catch (e) {
      _errorHandler(e, LoginSubWorkflow.signUp);
    } catch (e) {
      rethrow;
    } finally {
      notifyListeners();
    }
  }

  @override
  Future<void> sendPasswordResetWithEmail({@required String email}) async {
    _resetErrorMsgs();
    try {
      await AuthInterface.fireAuthInstance.sendPasswordResetEmail(email: email);
    } on PlatformException catch (e) {
      _errorHandler(e, LoginSubWorkflow.passwordReset);
    } catch (e) {
      rethrow;
    } finally {
      notifyListeners();
    }
  }

  void _updateUser(AuthResult authResult) {
    _user = authResult.user;
    _authStatus = _userIsLoggedInOrNot();
  }

  AuthStatus _userIsLoggedInOrNot() =>
      _userIsNotNull() ? AuthStatus.logged_in : AuthStatus.not_logged_in;
  bool _userIsNotNull() => _user != null;

  void _resetErrorMsgs() {
    _emailErrorMsg = null;
    _passwordErrorMsg = null;
  }

  void _errorHandler(
    PlatformException platformException,
    LoginSubWorkflow loginSubWorkflow,
  ) {
    switch (platformException.code) {
      case 'ERROR_USER_NOT_FOUND':
        _emailErrorMsg = 'user not found';
        break;
      case 'ERROR_WRONG_PASSWORD':
        _passwordErrorMsg = 'wrong password';
        break;
      case 'ERROR_EMAIL_ALREADY_IN_USE':
        _emailErrorMsg = 'user already exists';
        break;
      default:
        switch (loginSubWorkflow) {
          case LoginSubWorkflow.signIn:
            throw UnknownSignInError(
                'Unknown error for sign up with Firebase.');
            break;
          case LoginSubWorkflow.passwordReset:
            throw UnknownPasswordResetError(
                'Unknown error for password reset with Firebase.');
            break;
          case LoginSubWorkflow.signUp:
            throw UnknownSignUpError(
                'Unknown error for sign up with Firebase.');
            break;
          default:
            throw InvalidLoginWorkFlow(
                'There should only be 3 types of login sub workflows.');
        }
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
