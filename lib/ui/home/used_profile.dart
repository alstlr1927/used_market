import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import 'package:used_market/ui/login/select_login.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;
  List imageList = [
    'https://firebasestorage.googleapis.com/v0/b/usedmarket-21905.appspot.com/o/Product%2F1651043930550?alt=media&token=c9de9bef-5a61-4542-b37c-f82ae8fac328',
    'https://firebasestorage.googleapis.com/v0/b/usedmarket-21905.appspot.com/o/Product%2F1651043936602?alt=media&token=4e097862-2f8b-4994-8474-455127608fdc',
    'https://firebasestorage.googleapis.com/v0/b/usedmarket-21905.appspot.com/o/Product%2F1651043941691?alt=media&token=d61cc6a4-7646-402c-b8d2-05ba81e9afe2'
  ];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.only(right: 16, left: 16),
      alignment: Alignment.center,
      width: size.width,
      child: Column(
        children: [
          TextButton(
              onPressed: () {
                FirebaseAuth.instance.signOut();
                Get.offAll(SelectLoginRoot());
              },
              child: const Text('log out')),
        ],
      ),
    );
  }
}
