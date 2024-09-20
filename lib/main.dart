import 'dart:async';
import 'dart:io';
import 'package:dart_appwrite/dart_appwrite.dart';
import 'package:dart_appwrite/models.dart';

Future<dynamic> main(final context) async {
  final String? endpoint = Platform.environment['ENDPOINT'];
  final String? projectId = Platform.environment['PROJECT_ID']; 
  final String? databaseId = Platform.environment['DATABASE_ID'];
  final String? storeItemColletionId = Platform.environment['STORE_ITEM_COLLECTION_ID'];
  final String? apiKey = Platform.environment['API_KEY'];

  // Configurando o cliente Appwrite
  final client = Client()
      .setEndpoint(endpoint!)
      .setProject(projectId)
      .setKey(apiKey); 

  final databases = Databases(client);

  if (context.req.path == "/storeItems") {
    try {
      // Listar documentos da coleção
      DocumentList result = await databases.listDocuments(
        databaseId: databaseId!,
        collectionId: storeItemColletionId!,
        queries: [],
      );

      List<Map<String, dynamic>> items = result.documents.map((doc) => doc.toMap()).toList();

      return context.res.json({
        'items': items 
      });
    } on AppwriteException catch (e) {
      return context.res.json({
        "project": projectId, 
        'code': e.code,
        "message": e.message
      });
    }
  }

  return context.res.json({
    'motto': 'Build like a team of hundreds_',
    'connect': 'https://appwrite.io/discord',
    'getInspired': 'https://builtwith.appwrite.io',
  });
}
