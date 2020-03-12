import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';

import 'package:flutter_firebase_auth_benchmark/providers/login_workflow_provider.dart';
import 'package:flutter_firebase_auth_benchmark/widgets/login/login_container.dart';

import 'utils.dart';

void main() {
  final LoginContainer loginContainer = LoginContainer(
    child: Consumer<LoginWorkflowHandler>(
        builder: (context, loginWorkflowProvider, _) {
      return AnimatedContainer(duration: Duration(milliseconds: 500));
    }),
  );
  final wrappedLoginContainer =
      WidgetWrappers.materialWrapperWithLoginWorkflowProvider(loginContainer);

  testWidgets('Tests LoginContainer Initialization', (tester) async {
    await tester.pumpWidget(wrappedLoginContainer);

    final LoginContainer extractedLoginContainer =
        WidgetExtractor.extractStatelessWidgetByType(tester, LoginContainer);

    expect(loginContainer, equals(extractedLoginContainer));
  });

  testWidgets('Tests that the LoginContainer has a child property',
      (tester) async {
    expect(loginContainer.child, isInstanceOf<Consumer>());
  });
}
