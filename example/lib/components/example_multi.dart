import 'package:flutter/material.dart';
import 'package:gty/gty.dart';
import 'package:http/http.dart';
import '../models/user.dart';

class ExampleMulti extends StatefulWidget {
  final Client? httpClient;

  const ExampleMulti({
    super.key,
    this.httpClient,
  });

  @override
  State<ExampleMulti> createState() => _ExampleMultiState();
}

class _ExampleMultiState extends State<ExampleMulti> with gty {
  @override
  void initState() {
    super.initState();

    fetchData(
      httpClient: widget.httpClient,
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
      return Center(
        child: Text(error!.message),
      );
    }

    return Center(
      child: Text((viewData).length.toString()),
    );
  }
}
