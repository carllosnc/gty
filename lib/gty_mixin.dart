import 'dart:convert';
import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:gty/gty.dart';
import 'package:http/http.dart';

mixin gty<T extends StatefulWidget, DataType> on State<T> {
  bool isLoading = true;
  bool isSucess = false;
  bool isError = false;
  dynamic response;
  GtyException? error;
  dynamic data;
  DataType? viewData;

  final Map<String, String> _defaultHeaders = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };

  Future<void> fetchData({
    Client? httpClient,
    required String url,
    Map<String, String>? headers,
    Function(dynamic)? onSuccess,
  }) async {
    Map<String, String> fullHeaders = {
      ..._defaultHeaders,
      ...?headers,
    };

    httpClient ??= Client();

    try {
      final responseData = await httpClient.get(
        Uri.parse(url),
        headers: fullHeaders,
      );

      if (clientErrorRange.contains(responseData.statusCode) || serverErrorRange.contains(responseData.statusCode)) {
        throw GtyException(
          message: "Error: ${responseData.statusCode}",
          statusCode: responseData.statusCode,
          description: jsonDecode(responseData.body),
        );
      }

      setState(() {
        isLoading = false;
        isSucess = true;
        data = jsonDecode(responseData.body);
        response = responseData;

        if (onSuccess != null) {
          viewData = onSuccess(data);
        }
      });
    } on ClientException catch (e) {
      setState(() {
        isError = true;
        isLoading = false;
        isSucess = false;
        error = GtyException(
          message: e.message,
          statusCode: 000,
          description: e.uri,
        );
      });
    } on SocketException catch (e) {
      setState(() {
        isError = true;
        isLoading = false;
        isSucess = false;
        error = GtyException(
          message: e.message,
          statusCode: 000,
          description: e.address,
        );
      });
    } on GtyException catch (e) {
      setState(() {
        isError = true;
        isLoading = false;
        isSucess = false;
        error = e;
      });
    }
  }
}
