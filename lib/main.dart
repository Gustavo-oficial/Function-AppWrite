import 'dart:async';
import 'dart:io';
import 'package:dart_appwrite/dart_appwrite.dart';
import 'package:dart_appwrite/models.dart';

Future<dynamic> main(final context) async {
  final String? projectId = Platform.environment['PROJECT_ID']; 
  final String? databaseId = Platform.environment['DATABASE_ID'];
  final String? collectionId = Platform.environment['COLLECTION_ID'];

  final client = Client()
      .setEndpoint('https://cloud.appwrite.io/v1')
      .setProject(projectId);

  final databases = Databases(client);

  if (context.req.path == "/storeItems") {
    try {
      final DocumentList storesItems = await databases.listDocuments(
        databaseId: databaseId!,
        collectionId: collectionId!
      );

      dynamic items = [];

      storesItems.documents.where((element) {
        items.add(element.data);

        return true;
      }).toList();

      return context.res.json({
        'items': items
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
