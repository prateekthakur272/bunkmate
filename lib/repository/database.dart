import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Database {
  static Future<void> addItem(String title, int total, int attended) async {
    if (total < attended) {
      throw Exception('total cannot be less than attended');
    }
    return FirebaseFirestore.instance
        .collection('attendance')
        .doc(FirebaseAuth.instance.currentUser!.uid)
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
                .collection('attendance')
                .doc(FirebaseAuth.instance.currentUser!.uid)
                .get())
            .data() ??
        {};
  }

  static double percentage(int total,int attended){
    if(total==0){
      return 1;
    }
    return attended/total;
  }
}
