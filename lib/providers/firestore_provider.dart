import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:habo/constants.dart';

import '../model/user_action.dart';

class FirestoreProvider {
  final CollectionReference actionsCollection =
      FirebaseFirestore.instance.collection('actions');

  Future<void> addAction(ActionType action) async {
    try {
      UserAction dto = UserAction(action: action);
      await actionsCollection.add(dto.toMap());
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      rethrow;
    }
  }
}
