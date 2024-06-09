import 'package:flutter/material.dart';
import './gty_mixin.dart';

class Gty extends StatefulWidget {
  final String? url;
  final Widget Function(BuildContext context, dynamic data) child;
  final Widget error;
  final Widget loading;
  final Function(dynamic)? onSuccess;

  const Gty({
    super.key,
    this.url,
    required this.child,
    this.error = const Text('Error'),
    this.loading = const CircularProgressIndicator(),
    this.onSuccess,
  });

  @override
  State<Gty> createState() => _GtyState();
}

class _GtyState extends State<Gty> with gty {
  @override
  void initState() {
    super.initState();

    fetchData(
      url: widget.url!,
      onSuccess: widget.onSuccess,
    );
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return widget.loading;
    }

    if (isError) {
      return widget.error;
    }

    return widget.child(context, viewData);
  }
}
