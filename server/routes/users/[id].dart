import 'package:dart_frog/dart_frog.dart';
import '../../models/user.dart';

Response onRequest(RequestContext context, String id) {
  return Response.json(
    headers: {
      'Access-Control-Allow-Origin': '*',
      'Access-Control-Allow-Methods': 'GET, POST, PUT, DELETE, OPTIONS',
      'Access-Control-Allow-Headers': 'X-Requested-With',
    },
    body: User(
      name: 'User: $id',
      age: 25,
      email: 'user$id@gmail.com',
    ),
  );
}
