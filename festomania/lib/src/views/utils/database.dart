import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});
  final CollectionReference userCollection =
  FirebaseFirestore.instance.collection('Users');
  Future updateUserData(
      String name,
      String email,
      String userUid,
      List<String> saved,
      ) async {
    return await userCollection.doc(uid).set({
      'userUid': userUid,
      'name': name,
      'email': email,
      'saved': saved,
    });
  }

  Stream<QuerySnapshot> get users {
    return userCollection.snapshots();
  }
}

