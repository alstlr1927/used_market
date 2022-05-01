import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

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
              onPressed: () => _uploadImageToStorage(ImageSource.gallery),
              child: const Text('Gallery')),
          TextButton(
              onPressed: () => _uploadImageToStorage(ImageSource.camera),
              child: const Text('Camera')),
          Container(
            height: 120,
            margin: EdgeInsets.only(top: size.width * 0.06),
            child: CustomScrollView(
              scrollDirection: Axis.horizontal,
              slivers: [
                SliverList(
                    delegate: SliverChildBuilderDelegate((context, idx) {
                  return Container(
                    margin: EdgeInsets.only(right: size.width * 0.02),
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      image: DecorationImage(
                          image: Image.network(imageList[idx]).image,
                          fit: BoxFit.fill),
                    ),
                  );
                }, childCount: imageList.length))
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _uploadImageToStorage(ImageSource source) async {
    var picker = ImagePicker();
    var image = await picker.pickImage(source: source);

    if (image == null) return;

    var imageFile = File(image.path);

    late Reference reference;

    if (source == ImageSource.gallery) {
      reference = _firebaseStorage
          .ref()
          .child('Product/${DateTime.now().millisecondsSinceEpoch}');
    } else if (source == ImageSource.camera) {
      reference = _firebaseStorage
          .ref()
          .child('Product/${DateTime.now().millisecondsSinceEpoch}_direct_');
    }

    final uploadTask = reference.putFile(imageFile);

    await uploadTask.whenComplete(() => null);

    final downloadUrl = await reference.getDownloadURL();
    setState(() {
      imageList.add(downloadUrl);
    });
    print('url : $downloadUrl');
  }
}
