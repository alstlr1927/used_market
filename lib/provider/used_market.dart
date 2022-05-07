import 'package:firebase_auth/firebase_auth.dart';

class UsedMarket {
  //uid
  static String getUid() {
    return FirebaseAuth.instance.currentUser!.uid;
  }
}
