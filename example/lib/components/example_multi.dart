import 'package:flutter/material.dart';
import 'package:gty/gty.dart';
import '../models/user.dart';

class ExampleMulti extends StatefulWidget {
  const ExampleMulti({super.key});

  @override
  State<ExampleMulti> createState() => _ExampleMultiState();
}

class _ExampleMultiState extends State<ExampleMulti> with gty {
  @override
  void initState() {
    super.initState();

    fetchData(
      url: "http://localhost:8080/users/",
      onSuccess: (data) => adaptList<User>(data, User.fromJson),
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
      return const Center(
        child: Text("Error"),
      );
    }

    return Center(
      child: Text((viewData).length.toString()),
    );
  }
}
