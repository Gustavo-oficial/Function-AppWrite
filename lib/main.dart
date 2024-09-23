import 'dart:async';
import 'package:dart_appwrite/dart_appwrite.dart';
import 'package:starter_template/endpoints/store_item.dart';
import 'package:starter_template/env_config.dart';

Future<dynamic> main(final context) async {
  final client = Client()
      .setEndpoint(endpoint!)
      .setProject(projectId)
      .setKey(apiKey); 

  final databases = Databases(client);

  switch (context.req.path) {
    case "/storeItems":
      final itemId = context.req.query['id'];

      if (itemId == null || itemId.isEmpty) {
        return await StoreItem.getStoreItems(
          context: context, 
          databases: databases
        );
      }else{
        return await StoreItem.getStoreItemById(
          context: context, 
          databases: databases,
          itemId: itemId
        );
      }
    default:
      return context.res.json({
        'motto': 'Build like a team of hundreds_',
        'connect': 'https://appwrite.io/discord',
        'getInspired': 'https://builtwith.appwrite.io',
      });
  }
}
