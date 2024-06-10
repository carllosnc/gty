import 'package:flutter/material.dart';
import 'package:http/http.dart';
import './gty_mixin.dart';
import './gty_exception.dart';

class Gty extends StatefulWidget {
  final String? url;
  final Widget Function(BuildContext context, dynamic data) child;
  final Widget Function(BuildContext context, GtyException error)? error;
  final Widget loading;
  final Function(dynamic)? onSuccess;
  final Client? httpClient;

  const Gty({
    super.key,
    this.url,
    required this.child,
    this.error,
    this.loading = const Text('Loading...'),
    this.onSuccess,
    this.httpClient,
  });

  @override
  State<Gty> createState() => _GtyState();
}

class _GtyState extends State<Gty> with gty {
  @override
  void initState() {
    super.initState();

    fetchData(
      httpClient: widget.httpClient,
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
      return widget.error!(context, error!);
    }

    return widget.child(context, viewData);
  }
}
