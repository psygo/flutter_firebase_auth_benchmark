import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/material.dart';

class WidgetWrappers {
  static MaterialApp materialWrapper(Widget widget) =>
      MaterialApp(home: Material(child: widget));
}

class WidgetExtractor {
  // inspired by https://github.com/flutter/flutter/blob/77fb28b3da19dcf2b718ce963a23c2e4917c55f0/packages/flutter/test/widgets/stateful_components_test.dart#L47-L62
  static T extractElementByType<T extends Element>(
          WidgetTester tester, Type type) =>
      tester.element(find.byType(type));

  static St extractStateFromElement<St extends State<StatefulWidget>,
          El extends StatefulElement>(El element) =>
      element.state as St;

  static Stless extractStatelessWidgetFromElement<
          Stless extends StatelessWidget,
          El extends StatelessElement>(El element) =>
      element.widget as Stless;

  static St extractState<St extends State<StatefulWidget>>(
      WidgetTester tester, Type type) {
    final StatefulElement element = extractElementByType(tester, type);
    return extractStateFromElement(element);
  }

  static StatelessWidget extractStatelessWidget(
      WidgetTester tester, Type type) {
    final StatelessElement element = extractElementByType(tester, type);
    return extractStatelessWidgetFromElement(element);
  }
}

class RenderUtils {
  // from https://github.com/flutter/flutter/blob/714d579839cc306b88288e4f25dbee74bf3a4f5d/packages/flutter/test/material/text_field_test.dart#L145-L160
  static RenderEditable findRenderEditable(WidgetTester tester) {
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
}
