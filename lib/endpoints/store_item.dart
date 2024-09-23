import 'package:dart_appwrite/dart_appwrite.dart';
import 'package:dart_appwrite/models.dart';

import '../env_config.dart';

class StoreItem {
  static getStoreItems({
    required dynamic context,  
    required Databases databases
  }) async{
    try {
      DocumentList result = await databases.listDocuments(
        databaseId: databaseId!,
        collectionId: storeItemColletionId!,
        queries: [],
      );

      List<Map<String, dynamic>> items = result.documents.map((doc) => doc.toMap()).toList();
      List<Map<String, dynamic>> activeItems = items.where((item) => item['data']?['status'] == true).toList();

      return context.res.json({
        'items': activeItems 
      });
    } on AppwriteException catch (e) {
      return context.res.json({
        'code': e.code,
        "message": e.message
      });
    }
  }

  static getStoreItemById({
    required dynamic context,  
    required Databases databases,
    required String itemId
  }) async{
    try {
      Document result = await databases.getDocument(
        databaseId: databaseId!,
        collectionId: storeItemColletionId!,
        documentId: itemId
      );
      
      return context.res.json({
        'item': result.toMap()
      });
    } on AppwriteException catch (e) {
      return context.res.json({
        'code': e.code,
        "message": e.message
      });
    }
  }
}