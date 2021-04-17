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

class EventDatabaseService {
  final CollectionReference eventCollection =
  FirebaseFirestore.instance.collection('Events');
  Future updateEventData(
      String imageLink,
      String eventName,
      String collegeName,
      String eventCategory,
      String eventTiming,
      String description,
      DateTime startTime,
      DateTime endTime,
      String eventLink,
      String facebookLink,
      String instagramLink,
      String twitterLink,
      ) async {
    return await eventCollection.add({
      'imageLink': imageLink,
      'eventName': eventName,
      'collegeName': collegeName,
      'eventCategory': eventCategory,
      'eventTiming': eventTiming,
      'description': description,
      'startTime': startTime,
      'endTime': endTime,
      'eventLink': eventLink,
      'facebookLink': facebookLink,
      'instagramLink': instagramLink,
      'twitterLink': twitterLink,
    });
  }
}
