import 'package:cloud_firestore/cloud_firestore.dart';
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
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  List<DocumentSnapshot> products = [];
  List ids = [];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
      ),
      body: Container(
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
            TextButton(
                onPressed: () async {
                  QuerySnapshot querySnapshot =
                      await _firebaseFirestore.collection('products').get();
                  products.addAll(querySnapshot.docs);
                  print(products.length);
                  products.forEach((item) {
                    ids.add(item.id);
                  });
                  print(ids);
                },
                child: const Text('get')),
            TextButton(
                onPressed: () {
                  ids.forEach((item) async {
                    await _firebaseFirestore
                        .collection('products')
                        .doc(item)
                        .update({'view': 0});
                  });
                },
                child: const Text('update')),
          ],
        ),
      ),
    );
  }
}
