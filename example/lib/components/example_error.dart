import 'package:flutter/material.dart';
import 'package:gty/gty.dart';
import 'package:gty/gty_exception.dart';

class ExampleError extends StatefulWidget {
  const ExampleError({super.key});

  @override
  State<ExampleError> createState() => _ExampleErrorState();
}

class _ExampleErrorState extends State<ExampleError> with gty {
  @override
  void initState() {
    super.initState();

    fetchData(
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
      var errorData = error as GtyException;

      return Center(
        child: Column(
          children: [
            Text(errorData.message),
            Text(errorData.description['message']),
            Text(errorData.description['details']),
            Text(errorData.statusCode.toString()),
          ],
        ),
      );
    }

    return const Center(
      child: Text("Hello world!"),
    );
  }
}
