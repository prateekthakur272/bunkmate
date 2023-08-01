import 'package:firebase_storage/firebase_storage.dart';

class Storage {
  static getFile() {
    print(FirebaseStorage.instance.bucket);
  }
}
