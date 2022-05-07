import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:used_market/ui/home/main_screen.dart';
import 'package:used_market/ui/login/sign_up.dart';

class EmailLogin extends StatefulWidget {
  const EmailLogin({Key? key}) : super(key: key);

  @override
  State<EmailLogin> createState() => _EmailLoginState();
}

class _EmailLoginState extends State<EmailLogin> {
  final auth = FirebaseAuth.instance;
  String userId = '';
  String userPw = '';
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        margin: const EdgeInsets.only(left: 16, right: 16),
        child: Column(
          children: [
            TextField(
              onChanged: (val) {
                userId = val;
              },
            ),
            TextField(
              onChanged: (val) {
                userPw = val;
              },
            ),
            Row(
              children: [
                TextButton(
                  onPressed: () => _emailLogin(),
                  child: const Text('로그인'),
                ),
                TextButton(
                  onPressed: () {
                    Get.to(SignUp());
                  },
                  child: const Text('회원가입'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  _emailLogin() async {
    try {
      await auth.signInWithEmailAndPassword(email: userId, password: userPw);
    } catch (e) {
      print(e.toString());
    }

    if (auth.currentUser?.uid != null) {
      print('login success');
      Get.offAll(UsedMarketHome());
    } else {
      print('login failed');
    }
  }
}
