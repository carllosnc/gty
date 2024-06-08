import 'package:dart_frog/dart_frog.dart';
import '../../models/user.dart';

Response onRequest(RequestContext context) {
  return Response.json(
    headers: {
      'Access-Control-Allow-Origin': '*',
      'Access-Control-Allow-Methods': 'GET, POST, PUT, DELETE, OPTIONS',
      'Access-Control-Allow-Headers': 'X-Requested-With',
    },
    body: [
      User(
        name: 'Pearl Phelps',
        age: 25,
        email: 'bekan@ajoigees.lk',
      ),
      User(
        name: 'Benjamin Huff',
        age: 30,
        email: 'ew@riowihod.cu',
      ),
      User(
        name: 'Lina Hicks',
        age: 25,
        email: 'jo@pet.mu',
      ),
      User(
        name: 'Franklin Burns',
        age: 30,
        email: 'fodiem@emodozjil.bi',
      ),
    ],
  );
}
