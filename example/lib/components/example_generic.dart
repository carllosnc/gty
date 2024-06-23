import 'package:flutter/material.dart';
import 'package:gty/gty.dart';
import '../models/user.dart';
import 'package:http/http.dart';

class ExampleGeneric extends StatefulWidget {
  final Client? httpClient;

  const ExampleGeneric({
    super.key,
    this.httpClient,
  });

  @override
  State<ExampleGeneric> createState() => _ExampleGenericState();
}

class _ExampleGenericState extends State<ExampleGeneric> with gty<ExampleGeneric, User> {
  @override
  void initState() {
    super.initState();

    fetchData(
      httpClient: widget.httpClient,
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
      child: Text(viewData!.name),
    );
  }
}
