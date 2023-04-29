import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Database {

  static const attendanceCollection = 'attendance';
  static final uid = FirebaseAuth.instance.currentUser!.uid;

  static Future<void> addItem(String title, int total, int attended) async {
    if (total < attended) {
      throw Exception('total cannot be less than attended');
    }
    return FirebaseFirestore.instance
        .collection(attendanceCollection)
        .doc(uid)
        .update({
      title: {'total': total, 'attended': attended},
    }).onError((error, stackTrace) {
      if ((error as FirebaseException).code == 'not-found') {
        FirebaseFirestore.instance
            .collection('attendance')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .set({
          title: {'total': total, 'attended': attended},
        });
      }
    });
  }

  static Future<Map<String, dynamic>?> get items async {
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
}
