import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Database {

  static const attendanceCollection = 'attendance';
  static const historyCollection = 'history';
  static const totalKey = 'total';
  static const attendedKey = 'attended';
  static final uid = FirebaseAuth.instance.currentUser!.uid;

  static Future<void> addItem(String title, int total, int attended) async {
    if (total < attended) {
      throw Exception('total cannot be less than attended');
    }
    return FirebaseFirestore.instance
        .collection(attendanceCollection)
        .doc(uid)
        .update({
      title: {totalKey: total, attendedKey: attended},
    }).onError((error, stackTrace) {
      if ((error as FirebaseException).code == 'not-found') {
        FirebaseFirestore.instance
            .collection(attendanceCollection)
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .set({
          title: {totalKey: total, attendedKey: attended},
        });
      }
    });
  }

  static Future<Map<String, dynamic>> get items async {
    return (await FirebaseFirestore.instance
                .collection(attendanceCollection)
                .doc(uid)
                .get())
            .data() ??
        {};
  }

  static double percentage(int total, int attended) {
    if (total == 0) {
      return 1;
    }
    return attended / total;
  }

  static Stream<DocumentSnapshot<Map<String, dynamic>>> get itemsStream {
    return FirebaseFirestore.instance
        .collection(attendanceCollection)
        .doc(uid)
        .snapshots();
  }

  static Future<void> addAttendance(String title,bool isAttended) async {
    items.then((value){
      final data= value[title];
      int total = data[totalKey]??0;
      int attended = data[attendedKey]??0;
      addItem(title, total+1, isAttended?attended+1:attended);
    });
  }

  static Future<void> deleteItem(String title) async {
    items.then((value){
      value.remove(title);
      FirebaseFirestore.instance.collection(attendanceCollection).doc(uid).set(value);
    });
  }


  static Future<DocumentSnapshot<Map<String, dynamic>>> getHistory() async {
    return await(FirebaseFirestore.instance.collection(historyCollection).doc(uid).get());
  }

  static Future<void> addHistory(String title,bool attended) async {
    FirebaseFirestore.instance.collection(historyCollection).doc(uid).set({
      '${DateTime.now().toLocal()}': {
        'title':title,
        'attended':attended
      }
    },SetOptions(merge: true,));
  }

}
