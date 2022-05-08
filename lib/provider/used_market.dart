import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UsedMarket {
  static Map<String, dynamic> userProfile = {};
  //uid
  static String getUid() {
    return FirebaseAuth.instance.currentUser!.uid;
  }

  static Future<Map<String, dynamic>> getUser() async {
    userProfile.clear();
    DocumentSnapshot<Map<String, dynamic>> character = await FirebaseFirestore
        .instance
        .collection('users')
        .doc(getUid())
        .get();
    if (character.exists) {
      userProfile = character.data()!;
    }
    print('userProfile = ${userProfile.toString()}');
    return userProfile;
  }

  static String userNickname() {
    return userProfile['nickname'];
  }
}
