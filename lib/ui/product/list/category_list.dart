import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:used_market/ui/constraints.dart';
import 'package:used_market/ui/product/detail/product_detail.dart';

class CategoryProductList extends StatefulWidget {
  const CategoryProductList({Key? key, required this.categoryName})
      : super(key: key);
  final categoryName;
  @override
  State<CategoryProductList> createState() => _CategoryProductListState();
}

class _CategoryProductListState extends State<CategoryProductList> {
  FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  List<DocumentSnapshot> products = [];

  bool isLoading = false;
  bool hasMore = true;
  int documentLimit = 10;
  DocumentSnapshot? lastDocument = null;
  final ScrollController _scrollController = ScrollController();
  String orderCode = '001';

  @override
  void initState() {
    getProducts('001');
    _scrollController.addListener(() {
      double maxScroll = _scrollController.position.maxScrollExtent;
      double currentScroll = _scrollController.position.pixels;
      double delta = MediaQuery.of(context).size.height * 0.20;
      if (maxScroll - currentScroll <= delta) {
        getProducts(orderCode);
      }
    });
    super.initState();
  }

  getProducts(String code) async {
    String fieldName = 'regdate';
    bool descending = true;

    switch (code) {
      case '001':
        fieldName = 'regdate';
        descending = true;
        break;
      case '002':
        fieldName = 'view';
        descending = true;
        break;
      case '003':
        fieldName = 'price';
        descending = false;
        break;
      case '004':
        fieldName = 'price';
        descending = true;
        break;
      default:
    }

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
          .where('category', isEqualTo: widget.categoryName)
          .where('enable', isEqualTo: true)
          .orderBy(fieldName, descending: descending)
          .limit(documentLimit)
          .get();
    } else {
      querySnapshot = await _firebaseFirestore
          .collection('products')
          .where('category', isEqualTo: widget.categoryName)
          .where('enable', isEqualTo: true)
          .orderBy(fieldName, descending: descending)
          .startAfterDocument(lastDocument!)
          .limit(documentLimit)
          .get();
    }
    if (querySnapshot.docs.length < documentLimit) {
      hasMore = false;
    }
    lastDocument = querySnapshot.docs[querySnapshot.docs.length - 1];
    products.addAll(querySnapshot.docs);
    setState(() {
      isLoading = false;
    });
  }

  _curOrderState() {
    switch (orderCode) {
      case '001':
        return '최신순';
      case '002':
        return '인기순';
      case '003':
        return '낮은가격순';
      case '004':
        return '높은가격순';
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        centerTitle: true,
        title: BodyTextBold(
          string: widget.categoryName,
          size: 16,
        ),
      ),
      body: Container(
        color: Colors.white,
        width: size.width,
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                  border: Border(
                      bottom: BorderSide(
                          width: 1, color: Colors.black.withOpacity(0.1)))),
              width: size.width,
              height: size.width * 0.1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  PopupMenuButton(
                      child: Row(
                        children: [
                          BodyTextRegular(
                            string: _curOrderState(),
                            size: 14,
                            color: Colors.black.withOpacity(0.37),
                          ),
                          Icon(
                            Icons.keyboard_arrow_down,
                            color: Colors.black.withOpacity(0.37),
                          )
                        ],
                      ),
                      onSelected: (val) {
                        if (orderCode == val.toString()) {
                          return;
                        }
                        setState(() {
                          products.clear();
                          lastDocument = null;
                          isLoading = false;
                          hasMore = true;
                          orderCode = val.toString();
                          getProducts(val.toString());
                        });
                      },
                      itemBuilder: (context) => [
                            PopupMenuItem(
                              child: orderCode == '001'
                                  ? Row(
                                      children: [
                                        const Icon(
                                          Icons.check,
                                          size: 14,
                                        ),
                                        BodyTextRegular(
                                          string: '최신순',
                                          size: 14,
                                          color: Colors.black.withOpacity(0.87),
                                        ),
                                      ],
                                    )
                                  : BodyTextRegular(
                                      string: '최신순',
                                      size: 14,
                                      color: Colors.black.withOpacity(0.87),
                                    ),
                              value: '001',
                            ),
                            PopupMenuItem(
                              child: orderCode == '002'
                                  ? Row(
                                      children: [
                                        const Icon(
                                          Icons.check,
                                          size: 14,
                                        ),
                                        BodyTextRegular(
                                          string: '인기순',
                                          size: 14,
                                          color: Colors.black.withOpacity(0.87),
                                        ),
                                      ],
                                    )
                                  : BodyTextRegular(
                                      string: '인기순',
                                      size: 14,
                                      color: Colors.black.withOpacity(0.87),
                                    ),
                              value: '002',
                            ),
                            PopupMenuItem(
                              child: orderCode == '003'
                                  ? Row(
                                      children: [
                                        const Icon(
                                          Icons.check,
                                          size: 14,
                                        ),
                                        BodyTextRegular(
                                          string: '낮은가격순',
                                          size: 14,
                                          color: Colors.black.withOpacity(0.87),
                                        ),
                                      ],
                                    )
                                  : BodyTextRegular(
                                      string: '낮은가격순',
                                      size: 14,
                                      color: Colors.black.withOpacity(0.87),
                                    ),
                              value: '003',
                            ),
                            PopupMenuItem(
                              child: orderCode == '004'
                                  ? Row(
                                      children: [
                                        const Icon(
                                          Icons.check,
                                          size: 14,
                                        ),
                                        BodyTextRegular(
                                          string: '높은가격순',
                                          size: 14,
                                          color: Colors.black.withOpacity(0.87),
                                        ),
                                      ],
                                    )
                                  : BodyTextRegular(
                                      string: '높은가격순',
                                      size: 14,
                                      color: Colors.black.withOpacity(0.87),
                                    ),
                              value: '004',
                            ),
                          ]),
                ],
              ),
            ),
            Expanded(
              child: Container(
                margin: const EdgeInsets.only(left: 16, right: 16),
                child: CustomScrollView(
                  controller: _scrollController,
                  slivers: [
                    products.isNotEmpty
                        ? SliverList(
                            delegate:
                                SliverChildBuilderDelegate((context, idx) {
                            return GestureDetector(
                              onTap: () {
                                Get.to(ProductDetail(pid: products[idx].id));
                              },
                              child: Container(
                                padding:
                                    EdgeInsets.only(top: size.width * 0.04),
                                margin: EdgeInsets.only(
                                    top: size.width * 0.02,
                                    bottom: size.width * 0.02),
                                decoration: BoxDecoration(
                                    border: idx == 0
                                        ? null
                                        : Border(
                                            top: BorderSide(
                                                width: 1,
                                                color: Colors.black
                                                    .withOpacity(0.1)))),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Container(
                                          width: size.width * 0.3,
                                          height: size.width * 0.3,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            image: DecorationImage(
                                                image: Image.network(
                                                        products[idx]
                                                            .get('images')[0])
                                                    .image,
                                                fit: BoxFit.fill),
                                          ),
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(
                                              left: size.width * 0.04),
                                          height: size.width * 0.3,
                                          alignment: Alignment.topLeft,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              BodyTextRegular(
                                                  string:
                                                      products[idx].get('name'),
                                                  size: 16),
                                              SizedBox(
                                                height: size.width * 0.02,
                                              ),
                                              Row(
                                                children: [
                                                  BodyTextRegular(
                                                    string: '주소',
                                                    size: 14,
                                                    color: Colors.black
                                                        .withOpacity(0.37),
                                                  ),
                                                  BodyTextRegular(
                                                    string: '•',
                                                    size: 14,
                                                    color: Colors.black
                                                        .withOpacity(0.37),
                                                  ),
                                                  BodyTextRegular(
                                                    string: '시간',
                                                    size: 14,
                                                    color: Colors.black
                                                        .withOpacity(0.37),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                height: size.width * 0.02,
                                              ),
                                              BodyTextBold(
                                                  string: products[idx]
                                                          .get('price')
                                                          .toString() +
                                                      '원',
                                                  size: 16),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    Container(
                                      height: size.width * 0.3,
                                      alignment: Alignment.bottomCenter,
                                      child: SvgPicture.asset(
                                          'assets/images/icons/favorite_small_oulined.svg'),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }, childCount: products.length))
                        : const SliverToBoxAdapter(),
                    SliverToBoxAdapter(
                      child: SizedBox(
                        height: size.width * 0.1,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
