import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  String userId = '';
  String userPw = '';
  String userName = '';
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
                userName = val;
              },
              decoration: const InputDecoration(hintText: '이름'),
            ),
            TextField(
              onChanged: (val) {
                userId = val;
              },
              decoration: const InputDecoration(hintText: '아이디(이메일)'),
            ),
            TextField(
              onChanged: (val) {
                userPw = val;
              },
              decoration: const InputDecoration(hintText: '비밀번호'),
            ),
            TextButton(
              onPressed: () => _signUp(),
              child: const Text('확인'),
            ),
          ],
        ),
      ),
    );
  }

  _signUp() async {
    if (userName.isEmpty ||
        userId.isEmpty ||
        userPw.isEmpty ||
        userPw.length < 6) {
      return;
    }
    try {
      var result = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: userId, password: userPw);
      result.user?.updateDisplayName(userName);
    } catch (e) {
      print(e.toString());
    }
  }
}
