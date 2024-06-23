// ignore_for_file: avoid_relative_lib_imports
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/testing.dart';
import 'package:http/http.dart' as http;
import './user.dart';
import '../example/lib/components/example_one.dart';
import '../example/lib/components/example_multi.dart';
import '../example/lib/components/example_error.dart';
import '../example/lib/components/example_generic.dart';

getClient(dynamic data) {
  final httpClient = MockClient(
    (request) async {
      return http.Response(
        json.encode(data),
        200,
        headers: {
          "Content-Type": "application/json",
        },
      );
    },
  );

  return httpClient;
}

getHttpClientWithError(int statusCode, dynamic data) {
  final httpClient = MockClient(
    (request) async {
      return http.Response(
        json.encode(data),
        statusCode,
        headers: {
          "Content-Type": "application/json",
        },
      );
    },
  );

  return httpClient;
}

void main() {
  testWidgets("Check gty Mixin for one item", (widgetTester) async {
    await widgetTester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: ExampleOne(
            httpClient: getClient(
              User(
                name: "User: 1",
                age: 25,
                email: "user1@example.com",
              ),
            ),
          ),
        ),
      ),
    );

    expect(find.text("Loading..."), findsOne);
    await widgetTester.pumpAndSettle();
    expect(find.text("User: 1"), findsOne);
  });

  testWidgets("Check gty Mixin for multiple items", (widgetTester) async {
    await widgetTester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: ExampleMulti(
            httpClient: getClient(
              [
                User(
                  name: 'Pearl Phelps',
                  age: 25,
                  email: 'bekan@ajoigees.lk',
                ),
                User(
                  name: 'Benjamin Huff',
                  age: 30,
                  email: 'ew@riowihod.cu',
                ),
                User(
                  name: 'Lina Hicks',
                  age: 25,
                  email: 'jo@pet.mu',
                ),
                User(
                  name: 'Franklin Burns',
                  age: 30,
                  email: 'fodiem@emodozjil.bi',
                ),
              ],
            ),
          ),
        ),
      ),
    );

    expect(find.text("Loading..."), findsOne);
    await widgetTester.pumpAndSettle();
    expect(find.text("4"), findsOne);
  });

  testWidgets("Check gty Mixin for error", (widgetTester) async {
    await widgetTester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: ExampleError(
            httpClient: getHttpClientWithError(404, {
              'message': 'Not found',
              'details': 'The requested resource could not be found',
            }),
          ),
        ),
      ),
    );

    expect(find.text("Loading..."), findsOne);
    await widgetTester.pumpAndSettle();
    expect(find.text("Error: 404"), findsOne);
    expect(find.text("404"), findsOne);
    expect(find.text("Not found"), findsOne);
    expect(find.text("The requested resource could not be found"), findsOne);
  });

  testWidgets("Check gty Mixin for generic", (widgetTester) async {
    await widgetTester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: ExampleGeneric(
            httpClient: getClient(
              User(
                name: "User: 1",
                age: 25,
                email: "user1@example.com",
              ),
            ),
          ),
        ),
      ),
    );

    expect(find.text("Loading..."), findsOne);
    await widgetTester.pumpAndSettle();
    expect(find.text("User: 1"), findsOne);
  });
}
