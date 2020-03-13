import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';

import 'package:flutter_firebase_auth_benchmark/providers/login_workflow_provider.dart';

abstract class WidgetWrappers {
  static MaterialApp materialWrapper(Widget widget) =>
      MaterialApp(home: Material(child: widget));

  static MultiProvider materialWrapperWithLoginWorkflowProvider(
          Widget widget) =>
      MultiProvider(providers: [
        ChangeNotifierProvider(create: (_) => LoginWorkflowHandler())
      ], child: MaterialApp(home: Material(child: widget)));
}

abstract class WidgetExtractor {
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

  static List<Element> extractElementsFromStackByKey(
      WidgetTester tester, Key key) {
    final Element stackElement = extractElementByKey(tester, key);
    final MultiChildRenderObjectElement stack =
        stackElement as MultiChildRenderObjectElement;

    final List<Element> elements = [];
    findElementsInStack(stack, elements);

    return elements;
  }

  static void findElementsInStack<El extends Element>(
      El stack, List<Element> elements) {
    if (stack is SingleChildRenderObjectElement) {
      stack.visitChildren((Element stackElement) {
        elements.add(stackElement);
      });
    } else {
      stack.visitChildren((Element stackElement) {
        findElementsInStack(stackElement, elements);
      });
    }
  }
}

abstract class RenderUtils {
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
