import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:used_market/provider/used_market.dart';
import 'package:used_market/ui/home/main_screen.dart';

class AddData extends StatefulWidget {
  const AddData({Key? key}) : super(key: key);

  @override
  State<AddData> createState() => _AddDataState();
}

class _AddDataState extends State<AddData> {
  String userNickname = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        margin: const EdgeInsets.only(left: 16, right: 16),
        child: Column(
          children: [
            TextField(
              onChanged: (val) {
                userNickname = val;
              },
              decoration: const InputDecoration(hintText: '닉네임'),
            ),
            TextButton(
                onPressed: () => _registFireStore(), child: const Text('확인'))
          ],
        ),
      ),
    );
  }

  _registFireStore() async {
    if (userNickname.isEmpty) {
      return;
    }
    await FirebaseFirestore.instance
        .collection('users')
        .doc(UsedMarket.getUid())
        .set({'uid': UsedMarket.getUid(), 'nickname': userNickname})
        .onError((error, stackTrace) => {print('error : $error')})
        .then((val) {
          Get.offAll(UsedMarketHome());
        });
  }
}
