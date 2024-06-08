import 'package:dart_frog/dart_frog.dart';

Response onRequest(RequestContext context) {
  return Response.json(
    statusCode: 404,
    body: {
      'message': 'Not found',
      'details': 'The requested resource could not be found',
    },
  );
}
