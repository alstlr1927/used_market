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
  List imageList = [
    'https://firebasestorage.googleapis.com/v0/b/usedmarket-21905.appspot.com/o/Product%2F1651043930550?alt=media&token=c9de9bef-5a61-4542-b37c-f82ae8fac328',
    'https://firebasestorage.googleapis.com/v0/b/usedmarket-21905.appspot.com/o/Product%2F1651043936602?alt=media&token=4e097862-2f8b-4994-8474-455127608fdc',
    'https://firebasestorage.googleapis.com/v0/b/usedmarket-21905.appspot.com/o/Product%2F1651043941691?alt=media&token=d61cc6a4-7646-402c-b8d2-05ba81e9afe2'
  ];
  var index = 1;
  CollectionReference product =
      FirebaseFirestore.instance.collection('products');
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      alignment: Alignment.center,
      width: size.width,
      child: Column(
        children: [
          TextButton(
            onPressed: () {},
            child: const Text('INSERT'),
          ),
          TextButton(
            onPressed: () {},
            child: const Text('READ'),
          ),
          //Expanded(child: GetProductsInfo()),
        ],
      ),
    );
  }

  Future<void> addProduct() {
    return product.add({
      'productName': 'product$index',
      'offerPrice': 10000,
      'imageUrl': imageList,
      'regDt': Timestamp.now()
    }).then((val) {
      print('product Added $index');
      setState(() {
        index++;
      });
    }).catchError((e) => {print('$e')});
  }
}

class GetProductsInfo extends StatefulWidget {
  GetProductsInfo({Key? key}) : super(key: key);
  @override
  State<GetProductsInfo> createState() => _GetProductsInfoState();
}

class _GetProductsInfoState extends State<GetProductsInfo> {
  late PaginateRefreshedChangeListener _refreshedChangeListener =
      PaginateRefreshedChangeListener();

  int pagingIdx = 0;
  final pagingRange = 5;
  late final Stream<QuerySnapshot> _productStream = FirebaseFirestore.instance
      .collection('products')
      .orderBy('regDt', descending: true)
      .limit(pagingRange)
      .snapshots();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return StreamBuilder<QuerySnapshot>(
      stream: _productStream,
      builder: ((context, snapshot) {
        if (snapshot.hasError) {
          print('Error : Error');
          return Container();
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          print('Waiting~!');
          return Container();
        }
        // return Container(
        //   width: size.width,
        //   child: ListView(
        //     scrollDirection: Axis.vertical,
        //     children: snapshot.data!.docs.map((document) {
        //       Map<String, dynamic> data =
        //           document.data()! as Map<String, dynamic>;
        //       return ListTile(
        //         title: Text(data['productName']),
        //         subtitle: Text(data['offerPrice'].toString()),
        //       );
        //     }).toList(),
        //   ),
        //   // child: CustomScrollView(),
        // );
        return Container(
          width: size.width,
          child: RefreshIndicator(
            child: PaginateFirestore(
              itemBuilderType: PaginateBuilderType.listView,
              itemBuilder: (context, docSnapshot, index) {
                final data = docSnapshot[index].data() as Map?;
                return ListTile(
                  leading: const CircleAvatar(
                    child: Icon(Icons.person),
                  ),
                  title: data == null
                      ? const Text('Error')
                      : Text(data['productName']),
                  subtitle: Text(docSnapshot[index].id),
                );
              },
              query: FirebaseFirestore.instance
                  .collection('products')
                  .orderBy('regDt', descending: true),
              listeners: [_refreshedChangeListener],
              itemsPerPage: 10,
              isLive: true,
            ),
            onRefresh: () async {
              _refreshedChangeListener.refreshed = true;
            },
          ),
        );
      }),
    );
  }
}
