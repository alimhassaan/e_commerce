import 'package:e_commerce/models/product.dart';
import 'package:e_commerce/services/firestore_services.dart';
import 'package:e_commerce/utilities/api_path.dart';

abstract class Database {
  Stream<List<Product>> salesProductsSteam();
  Stream<List<Product>> newProductsSteam();
}

class FirestoreDatabase implements Database {
  final String uid;
  final _service = FirestoreServices.instance;
  FirestoreDatabase(this.uid);

  @override
  Stream<List<Product>> salesProductsSteam() => _service.collectionsStream(
    path: ApiPath.product(),
    builder: (data, documentId) => Product.fromMap(data!, documentId),
    queryBuilder: (query) => query.where('discountValue', isNotEqualTo: 0),
  );

  @override
  Stream<List<Product>> newProductsSteam() => _service.collectionsStream(
    path: ApiPath.product(),
    builder: (data, documentId) => Product.fromMap(data!, documentId),
  );
}
