import 'dart:async';
import 'package:dart_appwrite/dart_appwrite.dart';
import 'package:dart_appwrite/models.dart';


const String projectId = String.fromEnvironment("PROJECT_ID"); 
const String databaseId = String.fromEnvironment("DATABASE_ID");
const String collectionId = String.fromEnvironment("COLLECTION_ID");

Future<dynamic> main(final context) async {
  final client = Client()
      .setEndpoint('https://cloud.appwrite.io/v1')
      .setProject(projectId);

  final databases = Databases(client);

  if (context.req.path == "/storeItems") {
    try {
      final DocumentList storesItems = await databases.listDocuments(
        databaseId: databaseId,
        collectionId: collectionId
      );

      dynamic items = [];

      storesItems.documents.forEach((element) {
        items.add(element);
      });

      return context.res.json({
        'items': items
      });
    } on AppwriteException catch(e) {
      return context.res.json({
        'error': e.code,
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
