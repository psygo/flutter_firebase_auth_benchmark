import 'package:flutter_firebase_auth_benchmark/screens/login_screen.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';

class DummyStateless extends StatelessWidget {
  const DummyStateless({
    Key key
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      
    );
  }
}

class SimpleTextFormField extends StatefulWidget {
  const SimpleTextFormField({
    Key key
  }) : super(key: key);
  
  @override
  _SimpleTextFormFieldState createState() => _SimpleTextFormFieldState();
}

class _SimpleTextFormFieldState extends State<SimpleTextFormField> {
  TextEditingController _textEditingController = TextEditingController();
  bool _didInitState = false;

  @override
  void initState() {
    super.initState();
    _didInitState = true;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Container(
          child: TextFormField(
            key: Key('first_textformfield'),
            controller: _textEditingController,
          ),
        ),
      ),
    );
  }
}

void main(){
  final TestWidgetsFlutterBinding binding =
      TestWidgetsFlutterBinding.ensureInitialized();

  binding.window.physicalSizeTestValue = Size(1000, 1000);

  testWidgets('', (tester) async {
    const Key simpleKey = Key('simple_key');

    const SimpleTextFormField simpleTextFormField = SimpleTextFormField(
      key: simpleKey,
    );

    await tester.pumpWidget(simpleTextFormField);

    final StatefulElement simpleTextFormFieldElement = tester.element(find.byKey(simpleKey));
    final _SimpleTextFormFieldState _simpleTextFormFieldState = simpleTextFormFieldElement.state as _SimpleTextFormFieldState;

    expect(_simpleTextFormFieldState.widget, simpleTextFormField);
    expect(_simpleTextFormFieldState.widget, equals(simpleTextFormField));
    expect(_simpleTextFormFieldState._didInitState, isTrue);
    expect(simpleTextFormFieldElement.renderObject.attached, isTrue);
  });

  testWidgets('', (tester) async {
    const Key dummyKey = Key('simple_key');

    const DummyStateless dummyStateless = DummyStateless(
      key: dummyKey
    );

    await tester.pumpWidget(dummyStateless);

    final StatelessElement dummyElement = tester.element(find.byKey(dummyKey));
    final DummyStateless extractedDummyWidget = dummyElement.widget as DummyStateless;

    expect(dummyStateless, extractedDummyWidget);
    expect(dummyStateless, equals(extractedDummyWidget));
  });

  testWidgets('testing the LoginScreen widget', (tester) async {
    const LoginScreen loginScreen = LoginScreen();

    MaterialApp wrappedScreen = MaterialApp(home: loginScreen);

    await tester.pumpWidget(wrappedScreen);

    
  });
}