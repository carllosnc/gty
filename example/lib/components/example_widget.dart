import 'package:flutter/material.dart';
import 'package:gty/gty.dart';
import '../models/user.dart';

class ExampleWidget extends StatelessWidget {
  const ExampleWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Gty(
      url: "http://localhost:8080/users/1",
      loading: const CircularProgressIndicator(),
      error: const Text("Error"),
      onSuccess: (data) => adapt<User>(data, User.fromJson),
      child: (context, data) {
        return Container(
          alignment: Alignment.center,
          width: double.infinity,
          padding: const EdgeInsets.all(8.0),
          color: Colors.red,
          child: Text(
            "${(data as User).name} - From example widget",
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        );
      },
    );
  }
}
