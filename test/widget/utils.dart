import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/material.dart';

MaterialApp materialWrapper(Widget widget) =>
    MaterialApp(home: Material(child: widget));

// inspired by https://github.com/flutter/flutter/blob/77fb28b3da19dcf2b718ce963a23c2e4917c55f0/packages/flutter/test/widgets/stateful_components_test.dart#L47-L62
StatefulElement extractStatefulElementByType(WidgetTester tester, Type type) =>
    tester.element(find.byType(type));

St extractStateFromElement<St extends State<StatefulWidget>,
        El extends StatefulElement>(El element) =>
    element.state as St;

St extractState<St extends State<StatefulWidget>>(
    WidgetTester tester, Type type) {
  final StatefulElement element = extractStatefulElementByType(tester, type);
  return extractStateFromElement(element);
}

// from https://github.com/flutter/flutter/blob/714d579839cc306b88288e4f25dbee74bf3a4f5d/packages/flutter/test/material/text_field_test.dart#L145-L160
RenderEditable findRenderEditable(WidgetTester tester) {
  final RenderObject root = tester.renderObject(find.byType(EditableText));
  expect(root, isNotNull);

  RenderEditable renderEditable;
  void recursiveFinder(RenderObject child) {
    if (child is RenderEditable) {
      renderEditable = child;
      return;
    }
    child.visitChildren(recursiveFinder);
  }

  root.visitChildren(recursiveFinder);
  expect(renderEditable, isNotNull);
  return renderEditable;
}
