import 'package:flutter/material.dart';
import './components/example_one.dart';
import './components/example_multi.dart';
import './components/example_widget.dart';
import './components/example_error.dart';
import './components/example_generic.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Gty Example',
      home: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ExampleOne(),
            Divider(),
            ExampleMulti(),
            Divider(),
            ExampleError(),
            Divider(),
            ExampleWidget(),
            Divider(),
            ExampleGeneric(),
          ],
        ),
      ),
    );
  }
}
