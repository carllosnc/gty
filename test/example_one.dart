import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:gty/gty.dart';
import 'package:http/testing.dart';
import 'package:http/http.dart' as http;
import './user.dart';

final httpClient = MockClient(
  (request) async {
    return http.Response(
      json.encode(
        User(
          name: "User: 1",
          age: 25,
          email: "user1@example.com",
        ),
      ),
      200,
      headers: {
        "Content-Type": "application/json",
      },
    );
  },
);

class ExampleOne extends StatefulWidget {
  const ExampleOne({super.key});

  @override
  State<ExampleOne> createState() => _ExampleOneState();
}

class _ExampleOneState extends State<ExampleOne> with gty {
  @override
  void initState() {
    super.initState();

    fetchData(
      httpClient: httpClient,
      url: "http://localhost:8080/users/1",
      onSuccess: (data) => adapt<User>(data, User.fromJson),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(
        child: Text("Loading..."),
      );
    }

    if (isError) {
      return Center(
        child: Text(error!.message),
      );
    }

    return Center(
      child: Text((viewData as User).name),
    );
  }
}
