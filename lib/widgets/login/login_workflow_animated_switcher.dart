import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../exceptions/login.dart';
import '../../providers/login_workflow_provider.dart';

class LoginWorkflowAnimatedSwitcher extends StatelessWidget {
  const LoginWorkflowAnimatedSwitcher({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<LoginWorkflowHandler>(
      builder: (context, loginWorkflowHandler, child) {
        return AnimatedSwitcher(
          duration: Duration(milliseconds: 1500),
          switchInCurve: Curves.bounceOut,
          switchOutCurve: Curves.easeInExpo,
          child: loginWorkflowHandler.widget,
          transitionBuilder: (Widget child, Animation<double> animation) {
            final Animation<Offset> outOffsetAnimation =
                Tween<Offset>(begin: Offset(1, 0), end: Offset.zero)
                    .animate(animation);

            final Animation<double> inFadeAnimation =
                Tween<double>(begin: 0, end: 1).animate(animation);

            if (child.key == Key('login_workflow')) {
              return ClipRect(
                  child: FadeTransition(
                opacity: inFadeAnimation,
                child: child,
              ));
            } else if (child.key == Key('password_reset_workflow')) {
              return ClipRect(
                child: SlideTransition(
                  position: outOffsetAnimation,
                  child: child,
                ),
              );
            } else if (child.key == Key('signup_workflow')) {
              return ClipRect(
                child: SlideTransition(
                  position: outOffsetAnimation,
                  child: child,
                ),
              );
            } else {
              throw InvalidAnimationAttempt(
                  'There should be only 2 animation cases.');
            }
          },
          layoutBuilder: (Widget currentChild, List<Widget> previousChildren) {
            return Stack(
              key: Key('login_workflow_stack'),
              children: <Widget>[
                ...previousChildren,
                if (currentChild != null) currentChild,
              ],
              alignment: Alignment.center,
            );
          },
        );
      },
    );
  }
}
