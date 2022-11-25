import 'package:cloud_firestore/cloud_firestore.dart';

import '../Data/dataCall.dart';
import '../Model/Model.dart';

class baseCall {
  static Future addCalls(
  ) async {
    final docCall = await FirebaseFirestore.instance.collection('calls');
    final allCalls = await docCall.get();
    if (allCalls.size != 0) {
      return;
    } else {
      for (final call in calls) {
        final userDoc = docCall.doc();
        final newCall = call.copyWith(id: userDoc.id);
        await userDoc.set(newCall.toJson());
        print('ADD: ${newCall.toJson()}');
      }
    }
  }

  static Stream<List<CallModel>> readCalls() => FirebaseFirestore.instance
      .collection('calls')
      .snapshots()
      .map((snapshot) =>
          snapshot.docs.map((doc) => CallModel.fromJson(doc.data())).toList());
}
