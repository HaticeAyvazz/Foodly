import 'package:cloud_firestore/cloud_firestore.dart';

class FavoriteService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final String collection = "1";
  // Favori ekleme
  Future<void> addFavorite({
    required String id,
    required String name,
    required String imageUrl,
  }) async {
    await _db.collection('1').doc(id).set({
      'id': id,
      'name': name,
      'imageUrl': imageUrl,
      'createdAt': Timestamp.now(),
    });
  }

  // Favorileri çek (stream)
  Stream<List<Map<String, dynamic>>> getFavorites() {
    return _db
        .collection('1')
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) => doc.data()).toList());
  }

  // Favori silme
  Future<void> removeFavorite(String id) async {
    await _db.collection('1').doc(id).delete();
  }
}
