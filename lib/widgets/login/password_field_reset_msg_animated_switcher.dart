import 'package:flutter/material.dart';

import '../../exceptions/login.dart';
import '../../theme/auxiliary_theming.dart';
import '../../widgets/login/auth_textformfield.dart';

enum PasswordOrMsg {
  password,
  msg,
}

const AuthTextFormField _passwordField = AuthTextFormField(
  key: Key('password_field'),
  keyboardType: TextInputType.visiblePassword,
  hintText: 'password',
  hintTextOnFocus: 'your password',
  labelText: 'password',
  icon: Icons.lock,
  obscureText: true,
);

const Widget _passwordResetMsg = SizedBox(
  key: Key('password_reset_msg'),
  height: AuxiliaryTheming.textFieldHeight,
  child: Center(
    child: Text(
      'Please type your recovery email.',
    ),
  ),
);

class PasswordFieldResetMsgAnimatedSwitcher extends StatelessWidget {
  final Widget child;
  final Widget _passwordOrMsg;

  PasswordFieldResetMsgAnimatedSwitcher({
    Key key,
    this.child,
    @required PasswordOrMsg passwordOrMsg,
  }) : 
    _passwordOrMsg = _selectField(passwordOrMsg), 
    super(key: key);

  static Widget _selectField(PasswordOrMsg passwordOrMsg){
    switch (passwordOrMsg){
      case PasswordOrMsg.password:
        return _passwordField;
        break;
      case PasswordOrMsg.msg:
        return _passwordResetMsg;
      default:
        throw InvalidPassordOrResetMsg('There should only be 2 types of messages.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: Duration(milliseconds: 1500),
      switchInCurve: Curves.bounceOut,
      switchOutCurve: Curves.easeInExpo,
      child: _passwordOrMsg,
      transitionBuilder:
          (Widget child, Animation<double> animation) {
        final Animation<Offset> outOffsetAnimation =
            Tween<Offset>(
              begin: Offset(1, 0), 
              end: Offset.zero
            ).animate(animation);

        final Animation<Offset> inOffsetAnimation =
            Tween<Offset>(
              begin: Offset(-1, 0), 
              end: Offset.zero
            ).animate(animation);

        final Animation<double> inFadeAnimation =
            Tween<double>(
              begin: 0,
              end: 1
            ).animate(animation);

        if (child.key == Key('password_reset_msg')){
          // return ClipRect(
          //   child: SlideTransition(
          //     position: inOffsetAnimation,
          //     child: child,
          //   ),
          // );

          return ClipRect(
            child: FadeTransition(
              opacity: inFadeAnimation,
              child: child,
            )
          );
        }
        else if (child.key == Key('password_field')){
          return ClipRect(
            child: SlideTransition(
              position: outOffsetAnimation,
              child: child,
            ),
          );
        }
        else {
          throw InvalidAnimationAttempt('There should be only 2 animation cases.');
        }
      },
      layoutBuilder: (Widget currentChild,
          List<Widget> previousChildren) {
        return Stack(
          key: Key('password_animation_stack'),
          children: <Widget>[
            ...previousChildren,
            if (currentChild != null) currentChild,
          ],
          alignment: Alignment.center,
        );
      },
    );
  }
}