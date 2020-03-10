import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_firebase_auth_benchmark/widgets/login/login_container.dart';

import 'utils.dart';

void main() {
  final LoginContainer loginContainer = LoginContainer(child: Container());

  testWidgets('Tests LoginContainer Initialization', (tester) async {
    await tester.pumpWidget(loginContainer);

    final LoginContainer extractedLoginContainer =
        WidgetExtractor.extractStatelessWidgetByType(tester, LoginContainer);

    expect(loginContainer, equals(extractedLoginContainer));
  });

  testWidgets('Tests that the LoginContainer has a child property',
      (tester) async {
    expect(loginContainer.child, isInstanceOf<Container>());
  });
}
