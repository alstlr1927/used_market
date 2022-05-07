import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:used_market/ui/home/main_screen.dart';
import 'package:used_market/ui/login/add_extra_data.dart';
import 'package:used_market/ui/login/select_login.dart';

class RootScreen extends StatefulWidget {
  const RootScreen({Key? key}) : super(key: key);

  @override
  State<RootScreen> createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            print('loading...');
            return LoadingScreen();
          } else {
            print('data : ${snapshot.hasData}');
            if (snapshot.hasData) {
              // 처음 로그인인지 체크
              print('uid : ${snapshot.data.uid}');
              _firstLoginCheck(snapshot.data.uid);
            } else {
              // 로그인 화면으로
              return SelectLoginRoot();
            }
            return LoadingScreen();
          }
        });
  }

  _firstLoginCheck(uid) async {
    DocumentSnapshot<Map<String, dynamic>> doc =
        await FirebaseFirestore.instance.collection('users').doc(uid).get();
    if (!doc.exists) {
      // 첫 로그인일 때
      Get.offAll(AddData());
      //Get.offAll(UsedMarketHome());
    } else {
      // 첫 로그인 아닐때
      Get.offAll(UsedMarketHome());
    }
  }
}

class LoadingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: 100,
          height: 100,
          child: Image.asset(
            'assets/images/logo.png',
            width: 100,
            height: 100,
          ),
        ),
      ),
    );
  }
}
