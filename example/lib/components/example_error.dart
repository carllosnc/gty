import 'package:flutter/material.dart';
import 'package:gty/gty.dart';
import 'package:http/http.dart';

class ExampleError extends StatefulWidget {
  final Client? httpClient;

  const ExampleError({
    super.key,
    this.httpClient,
  });

  @override
  State<ExampleError> createState() => _ExampleErrorState();
}

class _ExampleErrorState extends State<ExampleError> with gty {
  @override
  void initState() {
    super.initState();

    fetchData(
      httpClient: widget.httpClient,
      url: "http://localhost:8080/error",
      onSuccess: (data) {},
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
        child: Column(
          children: [
            Text(error!.message),
            Text(error!.statusCode.toString()),
            Text(error!.description['message']),
            Text(error!.description['details']),
          ],
        ),
      );
    }

    return const Center(
      child: Text("Hello world!"),
    );
  }
}
