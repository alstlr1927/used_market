import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:paginate_firestore/bloc/pagination_listeners.dart';
import 'package:paginate_firestore/paginate_firestore.dart';

class Chat extends StatefulWidget {
  const Chat({Key? key}) : super(key: key);

  @override
  State<Chat> createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  List<DocumentSnapshot> products = [];

  bool isLoading = false;
  bool hasMore = true;
  int documentLimit = 5;
  DocumentSnapshot? lastDocument = null;
  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    _scrollController.addListener(() {
      double maxScroll = _scrollController.position.maxScrollExtent;
      double currentScroll = _scrollController.position.pixels;
      double delta = MediaQuery.of(context).size.height * 0.20;
      // if (maxScroll - currentScroll <= delta) {
      //   getProducts();
      // }
    });
    super.initState();
  }

  getProducts() async {
    if (!hasMore) {
      print('no more products');
      return;
    }
    if (isLoading) {
      return;
    }
    setState(() {
      isLoading = true;
    });
    QuerySnapshot querySnapshot;
    if (lastDocument == null) {
      querySnapshot = await _firebaseFirestore
          .collection('products')
          .orderBy('regdate', descending: true)
          .limit(documentLimit)
          .get();
    } else {
      querySnapshot = await _firebaseFirestore
          .collection('products')
          .orderBy('regdate', descending: true)
          .startAfterDocument(lastDocument!)
          .limit(documentLimit)
          .get();
      print(1);
    }
    if (querySnapshot.docs.length < documentLimit) {
      hasMore = false;
    }
    lastDocument = querySnapshot.docs[querySnapshot.docs.length - 1];
    products.addAll(querySnapshot.docs);
    setState(() {
      isLoading = false;
    });
    products.forEach((item) {
      print(item.get(''));
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
      ),
      body: Container(
        alignment: Alignment.center,
        width: size.width,
        child: Column(
          children: [
            TextButton(
              onPressed: () {},
              child: const Text('INSERT'),
            ),
            TextButton(
              onPressed: () => getProducts(),
              child: const Text('READ'),
            ),
            //Expanded(child: GetProductsInfo()),
          ],
        ),
      ),
    );
  }
}
