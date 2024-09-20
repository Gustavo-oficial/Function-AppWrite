import 'dart:async';
import 'dart:io';
import 'package:dart_appwrite/dart_appwrite.dart';
import 'package:dart_appwrite/models.dart';

Future<dynamic> main(final context) async {
  final String? projectId = Platform.environment['PROJECT_ID']; 
  final String? databaseId = Platform.environment['DATABASE_ID'];
  final String? collectionId = Platform.environment['COLLECTION_ID'];
  final String? apiKey = Platform.environment['API_KEY'];

  final client = Client()
      .setEndpoint('https://cloud.appwrite.io/v1')
      .setProject(projectId)
      .setKey(apiKey);

  final databases = Databases(client);

  if (context.req.path == "/storeItems") {
    try {
      DocumentList result = await databases.listDocuments(
        databaseId: databaseId!,
        collectionId: collectionId!,
        queries: [],
      );

      return context.res.json({
        "result": result,
        "database": databaseId,
        "collection": collectionId,
        'items': result.documents
      });
    } on AppwriteException catch(e) {
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
