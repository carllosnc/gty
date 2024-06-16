import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gty/gty.dart';
import 'package:http/testing.dart';
import 'package:http/http.dart' as http;
import './user.dart';

getClient(int status, dynamic data) {
  final httpClient = MockClient(
    (request) async {
      return http.Response(
        json.encode(data),
        status,
        headers: {
          "Content-Type": "application/json",
        },
      );
    },
  );

  return httpClient;
}

main() {
  testWidgets("Check gty componentse for one item", (widgetTester) async {
    await widgetTester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Gty(
            httpClient: getClient(
              200,
              User(
                name: "test user",
                age: 25,
                email: "test@example.com",
              ),
            ),
            url: "http://localhost:8080/users/1",
            loading: const Text("Loading..."),
            error: (context, error) => Center(
              child: Text(error.message),
            ),
            onSuccess: (data) => adapt<User>(data, User.fromJson),
            child: (context, data) {
              return Text(
                (data as User).name,
              );
            },
          ),
        ),
      ),
    );

    expect(find.text("Loading..."), findsOne);
    await widgetTester.pumpAndSettle();
    expect(find.text("test user"), findsOne);
  });

  testWidgets("Check gty componentse for multiple items", (widgetTester) async {
    await widgetTester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Gty(
            httpClient: getClient(
              200,
              [
                User(
                  name: 'Pearl Phelps',
                  age: 25,
                  email: 'ben@ajoigees.lk',
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
            url: "http://localhost:8080/users",
            loading: const Text("Loading..."),
            error: (context, error) => Center(
              child: Text(error.message),
            ),
            onSuccess: (data) => adaptList<User>(data, User.fromJson),
            child: (context, data) {
              return Text(
                (data as List<User>).length.toString(),
              );
            },
          ),
        ),
      ),
    );

    expect(find.text("Loading..."), findsOne);
    await widgetTester.pumpAndSettle();
    expect(find.text("4"), findsOne);
  });

  testWidgets("Check gty componentse for error", (widgetTester) async {
    await widgetTester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Gty(
            httpClient: getClient(
              400,
              {
                "message": "Something went wrong",
              },
            ),
            url: "http://localhost:8080/users",
            loading: const Text("Loading..."),
            error: (context, error) => Center(
              child: Text(error.description["message"]),
            ),
            onSuccess: (data) => adaptList<User>(data, User.fromJson),
            child: (context, data) {
              return Text(
                (data as List<User>).length.toString(),
              );
            },
          ),
        ),
      ),
    );

    expect(find.text("Loading..."), findsOne);
    await widgetTester.pumpAndSettle();
    expect(find.text("Something went wrong"), findsOne);
  });
}
