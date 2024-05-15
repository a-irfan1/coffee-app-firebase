import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_firebase/Models/prefModel.dart';
import 'package:flutter_firebase/Models/userModel.dart';

class DatabaseService {
  final String uid;
  DatabaseService({required this.uid});

  final CollectionReference flutterFirebaseCollection =
      FirebaseFirestore.instance.collection('users');

  Future updateUserData(String name, String sugars, int strength) async {
    return await flutterFirebaseCollection
        .doc(uid)
        .set({'name': name, 'sugars': sugars, 'strength': strength});
  }

  List<PrefsModel> _prefsFromQuerySnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return PrefsModel(
        name: doc.get('name') ?? '',
        sugars: doc.get('sugars') ?? '',
        strength: doc.get('strength') ?? 0,
      );
    }).toList();
  }

  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserData(
      uid: uid,
      name: snapshot['name'],
      sugars: snapshot['sugars'],
      strength: snapshot['strength'],
    );
  }

  Stream<List<PrefsModel>> get prefs {
    return flutterFirebaseCollection.snapshots().map(_prefsFromQuerySnapshot);
  }

  Stream<UserData> get userData {
    return flutterFirebaseCollection
        .doc(uid)
        .snapshots()
        .map(_userDataFromSnapshot);
  }
}
