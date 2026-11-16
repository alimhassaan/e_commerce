import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreServices {
  FirestoreServices._();
  static final instance = FirestoreServices._();
  final _firestore = FirebaseFirestore.instance;

  Future<void> setData({
    required String path,
    required Map<String, dynamic> data,
  }) async {
    final reference = _firestore.doc(path);
    await reference.set(data);
  }

  Future<void> setDataBatch({
    required Map<String, Map<String, dynamic>> dataByPath,
  }) async {
    final batch = _firestore.batch();
    for (final entry in dataByPath.entries) {
      batch.set(_firestore.doc(entry.key), entry.value);
    }
    await batch.commit();
  }

  Future<void> deleteData({required String path}) async {
    final reference = _firestore.doc(path);
    await reference.delete();
  }

  Stream<T> documentsStream<T>({
    required String path,
    required T Function(Map<String, dynamic>? data, String documentId) builder,
  }) {
    final reference = _firestore.doc(path);
    final snapshots = reference.snapshots();
    return snapshots.map((snapshot) => builder(snapshot.data(), snapshot.id));
  }

  Stream<List<T>> collectionsStream<T>({
    required String path,
    required T Function(Map<String, dynamic>? data, String documentId) builder,
    Query Function(Query query)? queryBuilder,
    int Function(T lhs, T rhs)? sort,
  }) {
    Query query = _firestore.collection(path);
    if (queryBuilder != null) {
      query = queryBuilder(query);
    }
    final snapshots = query.snapshots();
    return snapshots.map((snapshot) {
      final result = snapshot.docs
          .map(
            (snapshot) =>
                builder(snapshot.data() as Map<String, dynamic>, snapshot.id),
          )
          .where((value) => value != null)
          .toList();
      if (sort != null) {
        result.sort(sort);
      }
      return result;
    });
  }

  Future<T> getDocument<T>({
    required String path,
    required T Function(Map<String, dynamic>? data, String documentId) builder,
  }) async {
    final reference = _firestore.doc(path);
    final snapshot = await reference.get();
    return builder(snapshot.data(), snapshot.id);
  }

  Future<List<T>> getCollection<T>({
    required String path,
    required T Function(Map<String, dynamic>? data, String documentId) builder,
    Query Function(Query query)? queryBuilder,
    int Function(T lhs, T rhs)? sort,
  }) async {
    Query query = _firestore.collection(path);
    if (queryBuilder != null) {
      query = queryBuilder(query);
    }
    final snapshot = await query.get();
    final result = snapshot.docs
        .map(
          (snapshot) =>
              builder(snapshot.data() as Map<String, dynamic>, snapshot.id),
        )
        .where((value) => value != null)
        .toList();
    if (sort != null) {
      result.sort(sort);
    }
    return result;
  }
}
