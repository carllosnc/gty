import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'example_one.dart';

void main() {
  testWidgets("Check gty Mixin", (widgetTester) async {
    await widgetTester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: ExampleOne(),
        ),
      ),
    );

    expect(find.text("Loading..."), findsOne);
    await widgetTester.pumpAndSettle();
    expect(find.text("User: 1"), findsOne);
  });
}
