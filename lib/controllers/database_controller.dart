import 'package:e_commerce/models/add_to_cart_model.dart';
import 'package:e_commerce/models/product.dart';
import 'package:e_commerce/models/user_data.dart';
import 'package:e_commerce/services/firestore_services.dart';
import 'package:e_commerce/utilities/api_path.dart';


abstract class Database {
  Stream<List<Product>> salesProductsSteam();
  Stream<List<Product>> newProductsSteam();
  Future<void>setUserData(UserData userData);
  Future<void>addToCart(AddToCartModel product);
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

  @override
  Future<void> setUserData(UserData userData)async=>  await _service.setData(
    path: ApiPath.user(userData.uid),
    data: userData.toMap(),
  );

  @override
  Future<void> addToCart(AddToCartModel product) async=> await _service.setData(
    path: ApiPath.addToCart(uid,product.id),
    data: product.toMap(),
  );
}
