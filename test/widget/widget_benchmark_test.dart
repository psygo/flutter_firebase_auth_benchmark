import 'package:flutter_firebase_auth_benchmark/widgets/login/authentication_textformfield.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';

class InnerWidget extends StatefulWidget {
  const InnerWidget({ Key key }) : super(key: key);

  @override
  InnerWidgetState createState() => InnerWidgetState();
}

class InnerWidgetState extends State<InnerWidget> {
  bool _didInitState = false;
  TextEditingController _textEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _didInitState = true;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Container(
              child: TextFormField(
          key: Key('texty'),
          controller: _textEditingController,
        ),
      ),
    );
  }
}

class OuterContainer extends StatefulWidget {
  const OuterContainer({ Key key, this.child }) : super(key: key);

  final InnerWidget child;

  @override
  OuterContainerState createState() => OuterContainerState();
}

class OuterContainerState extends State<OuterContainer> {
  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}

void main() {
  // testWidgets('resync stateful widget', (WidgetTester tester) async {
  //   const Key innerKey = Key('inner');
  //   const Key outerKey = Key('outer');

  //   const InnerWidget inner1 = InnerWidget(key: innerKey);
  //   InnerWidget inner2;
  //   const OuterContainer outer1 = OuterContainer(key: outerKey, child: inner1);
  //   OuterContainer outer2;

  //   await tester.pumpWidget(inner1);

  //   final StatefulElement innerElement = tester.element(find.byKey(innerKey));
  //   final InnerWidgetState innerElementState = innerElement.state as InnerWidgetState;
  //   expect(innerElementState.widget, equals(inner1));
  //   expect(innerElementState._didInitState, isTrue);
  //   expect(innerElement.renderObject.attached, isTrue);
  // });

  // testWidgets('doing the same thing as above, but with my widgets', (tester) async {
  //   const Key authFieldKey = Key('authy1');

  //   AuthenticationTextFormField authyField = AuthenticationTextFormField(
  //     key: authFieldKey,
  //     keyboardType: TextInputType.emailAddress,
  //     hintText: 'email',
  //     labelText: 'email',
  //     icon: Icons.account_circle,
  //   );

  //   await tester.pumpWidget(authyField);
  // });
}