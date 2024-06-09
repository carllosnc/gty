import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import '../gty_status_code.dart';
import '../gty_exception.dart';

mixin gty<T extends StatefulWidget> on State<T> {
  bool isLoading = true;
  bool isSucess = false;
  bool isError = false;
  dynamic response;
  dynamic error;
  dynamic data;
  dynamic viewData;

  Map<String, String> defaultHeaders = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };

  Future<void> fetchData({
    required String url,
    Map<String, String>? headers,
    Function(dynamic)? onSuccess,
  }) async {
    Map<String, String> fullHeaders = {
      ...defaultHeaders,
      ...?headers,
    };

    try {
      final responseData = await http.get(
        Uri.parse(url),
        headers: fullHeaders,
      );

      if (clientErrorRange.contains(responseData.statusCode) || serverErrorRange.contains(responseData.statusCode)) {
        throw GtyException(
          message: "Error ${responseData.statusCode}",
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
    } on http.ClientException catch (e) {
      setState(() {
        isError = true;
        isLoading = false;
        isSucess = false;
        error = e;
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
