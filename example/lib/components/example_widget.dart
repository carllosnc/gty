import 'package:flutter/material.dart';
import 'package:gty/gty.dart';
import '../models/user.dart';

class ExampleWidget extends StatelessWidget {
  const ExampleWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Gty(
      url: "http://localhost:8080/users/1",
      loading: const Text("Loading..."),
      error: (context, error) => Center(
        child: Text(error.message),
      ),
      onSuccess: (data) => adapt<User>(data, User.fromJson),
      child: (context, data) {
        return Text(
          "${(data as User).name} - From example widget",
        );
      },
    );
  }
}
