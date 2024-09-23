import 'dart:async';
import 'package:dart_appwrite/dart_appwrite.dart';
import 'package:dart_appwrite/models.dart';
import 'package:starter_template/env_config.dart';

Future<dynamic> main(final context) async {
  final client = Client()
      .setEndpoint(endpoint!)
      .setProject(projectId)
      .setKey(apiKey); 

  final databases = Databases(client);

  if (context.req.path == "/storeItems") {
    try {
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
        "storeCollectionId": storeItemColletionId,
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
