import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_test/flutter_test.dart';

class WidgetWrappers {
  static MaterialApp materialWrapper(Widget widget) =>
      MaterialApp(home: Material(child: widget));
}

class WidgetExtractor {
  // inspired by https://github.com/flutter/flutter/blob/77fb28b3da19dcf2b718ce963a23c2e4917c55f0/packages/flutter/test/widgets/stateful_components_test.dart#L47-L62
  static T extractElementByType<T extends Element>(
          WidgetTester tester, Type type) =>
      tester.element(find.byType(type));

  static T extractElementByKey<T extends Element>(
          WidgetTester tester, Key key) =>
      tester.element(find.byKey(key));

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

  static StatelessWidget extractStatelessWidgetByType(
      WidgetTester tester, Type type) {
    final StatelessElement element = extractElementByType(tester, type);
    return extractStatelessWidgetFromElement(element);
  }

  static StatelessWidget extractStatelessWidgetByKey(
      WidgetTester tester, Key key) {
    final StatelessElement element = extractElementByKey(tester, key);
    return extractStatelessWidgetFromElement(element);
  }

  static List<Widget> extractWidgetsFromStackByKey(
      WidgetTester tester, Key key) {
    final Element stackElement = extractElementByKey(tester, key);
    final MultiChildRenderObjectElement stack =
        stackElement as MultiChildRenderObjectElement;

    final List<Widget> widgets = [];
    findWidgetsInStack(stack, widgets);

    return widgets;
  }

  static void findWidgetsInStack<El extends Element>(
      El stack, List<Widget> widgets) {
    if (stack is SingleChildRenderObjectElement) {
      stack.visitChildren((Element stackElement) {
        widgets.add(stackElement.widget);
      });
    } else {
      stack.visitChildren((Element stackElement) {
        findWidgetsInStack(stackElement, widgets);
      });
    }
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
