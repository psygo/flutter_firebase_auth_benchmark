import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/login_workflow_provider.dart';
import '../../theme/auxiliary_theming.dart';
import '../../theme/colors.dart';

class LoginContainer extends StatelessWidget {
  final Widget child;

  const LoginContainer({
    Key key,
    @required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<LoginWorkflowHandler>(
      builder: (context, loginWorkflowProvider, _) {
        return AnimatedContainer(
          duration: Duration(milliseconds: 600),
          height: loginWorkflowProvider.workflowHeight,
          width: 275,
          margin: EdgeInsets.all(
            10,
          ),
          padding: EdgeInsets.symmetric(
            horizontal: 15,
          ),
          decoration: BoxDecoration(
            color: BasicColors.white,
            boxShadow: [
              AuxiliaryTheming.containerBoxShadow,
            ],
            borderRadius: AuxiliaryTheming.containerBorderRadius,
          ),
          child: child,
        );
      },
    );
  }
}
