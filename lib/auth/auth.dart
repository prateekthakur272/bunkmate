import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

Future<UserCredential> signInWithGoogle()async{
  final GoogleSignInAccount? googleSignInAccount = await GoogleSignIn().signIn();
  print(googleSignInAccount);
  final GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount!.authentication;
  final credential = GoogleAuthProvider.credential(
    accessToken: googleSignInAuthentication.accessToken,
    idToken: googleSignInAuthentication.idToken
  );
  return await FirebaseAuth.instance.signInWithCredential(credential);
}