import 'dart:async';
import 'package:dart_appwrite/dart_appwrite.dart';


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
      final storesItems = databases.listDocuments(
        databaseId: databaseId,
        collectionId: collectionId
      );

      print(storesItems);
    } on AppwriteException catch(e) {
        print(e);
    }
  }

  return context.res.json({
    'motto': 'Build like a team of hundreds_',
    'learn': context.process.env.API_KEY,
    'connect': 'https://appwrite.io/discord',
    'getInspired': 'https://builtwith.appwrite.io',
  });
}
