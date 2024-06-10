import 'package:flutter/material.dart';
import 'package:gty/gty.dart';

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
      return Center(
        child: Column(
          children: [
            Text(error!.message),
          ],
        ),
      );
    }

    return const Center(
      child: Text("Hello world!"),
    );
  }
}
