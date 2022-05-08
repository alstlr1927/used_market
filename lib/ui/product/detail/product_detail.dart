import 'dart:async';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:used_market/provider/used_market.dart';
import 'package:used_market/ui/constraints.dart';
import 'package:used_market/ui/home/main_screen.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class ProductDetail extends StatefulWidget {
  const ProductDetail({Key? key, required this.pid}) : super(key: key);
  final pid;
  @override
  State<ProductDetail> createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  //var pid = 'mGPXpsTF11gxzQDQYVDD';
  late DocumentSnapshot<Map<String, dynamic>> prdData;
  final ScrollController _scrollController = ScrollController();
  bool _load = true;
  double scrollOffset = 0.0;
  int imgPageIdx = 0;

  @override
  void initState() {
    init();
    _scrollController.addListener(() {
      setState(() {
        scrollOffset = _scrollController.offset;
      });
    });
    super.initState();
  }

  init() async {
    prdData = await FirebaseFirestore.instance
        .collection('products')
        .doc(widget.pid)
        .get();
    await UsedMarket.getUser();
    _load = false;
    Timer(const Duration(milliseconds: 500), () {
      setState(() {});
    });
    print(prdData.data());
    print(prdData.get('images'));
  }

  var bestProductList = [
    {
      'productNm': '쓰레기통',
      'imgUrl': 'assets/product/trash.jpg',
      'price': '5000'
    },
    {'productNm': '샴푸', 'imgUrl': 'assets/product/shamp.png', 'price': '17000'},
    {
      'productNm': '슬랙스',
      'imgUrl': 'assets/product/pants.png',
      'price': '12000'
    },
    {
      'productNm': '조거팬츠',
      'imgUrl': 'assets/product/jogger_pants.png',
      'price': '30000'
    },
    {'productNm': '의자', 'imgUrl': 'assets/product/chair.png', 'price': '35000'},
    {
      'productNm': '담요',
      'imgUrl': 'assets/product/blanket.png',
      'price': '21000'
    },
    {
      'productNm': '에어팟',
      'imgUrl': 'assets/product/airpod.jpg',
      'price': '180000'
    },
    {
      'productNm': '도넛',
      'imgUrl': 'assets/product/doughnut.png',
      'price': '8000'
    },
    {
      'productNm': '맥북',
      'imgUrl': 'assets/product/macbook.jpg',
      'price': '1400000'
    },
  ];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return _load ? loadWidget() : bodyWidget(size);
  }

  loadWidget() {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: const Center(
        child: SpinKitFadingCube(color: Colors.green),
      ),
    );
  }

  bodyWidget(Size size) {
    return Scaffold(
        body: Stack(
      children: [
        SizedBox(
          width: size.width,
          child: SingleChildScrollView(
            controller: _scrollController,
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                SizedBox(
                    width: size.width,
                    height: size.width,
                    child: Stack(alignment: Alignment.bottomCenter, children: [
                      CarouselSlider.builder(
                          itemCount: prdData.get('images').length,
                          itemBuilder: (context, i, i2) {
                            return Image.network(
                              prdData.get('images')[i],
                              fit: BoxFit.fill,
                            );
                          },
                          options: CarouselOptions(
                              initialPage: 0,
                              autoPlay: false,
                              height: size.width,
                              viewportFraction: 1.0,
                              aspectRatio: 1 / 1,
                              enableInfiniteScroll:
                                  prdData.get('images').length == 1
                                      ? false
                                      : true,
                              onPageChanged: (idx, reason) {
                                setState(() {
                                  imgPageIdx = idx;
                                });
                              })),
                      Container(
                          margin: EdgeInsets.only(bottom: size.width * 0.04),
                          width: 46,
                          height: 22,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: const Color.fromRGBO(0, 0, 0, 0.75),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Container(
                            margin: const EdgeInsets.only(bottom: 2),
                            child: BodyTextRegular(
                              string:
                                  '${imgPageIdx + 1} / ${prdData.get('images').length}',
                              size: 12,
                              color: const Color(0xffffffff),
                            ),
                          )),
                    ])),
                Container(
                  margin: const EdgeInsets.only(left: 16, right: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: size.width * 0.06,
                      ),
                      Row(
                        children: [
                          Container(
                            width: size.width * 0.1,
                            height: size.width * 0.1,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle, color: Colors.green),
                          ),
                          SizedBox(
                            width: size.width * 0.04,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              BodyTextBold(
                                string: UsedMarket
                                    .userNickname(), //UsedMarket.userNickname(),
                                size: 16,
                                color: Colors.black.withOpacity(0.87),
                              ),
                              BodyTextRegular(
                                string: '주소',
                                size: 14,
                                color: Colors.black.withOpacity(0.87),
                              )
                            ],
                          ),
                        ],
                      ),
                      Container(
                        margin: EdgeInsets.only(
                            top: size.width * 0.06, bottom: size.width * 0.06),
                        height: 1,
                        width: size.width,
                        color: Colors.black.withOpacity(0.1),
                      ),
                      BodyTextBold(
                        string: prdData.get('name'),
                        size: 20,
                        color: Colors.black.withOpacity(0.87),
                      ),
                      SizedBox(
                        height: size.width * 0.04,
                      ),
                      Row(
                        children: [
                          BodyTextRegular(
                            string: prdData.get('category'),
                            size: 14,
                            color: Colors.black.withOpacity(0.37),
                          ),
                          BodyTextRegular(
                            string: '•',
                            size: 14,
                            color: Colors.black.withOpacity(0.37),
                          ),
                          BodyTextRegular(
                            string: '16분 전',
                            size: 14,
                            color: Colors.black.withOpacity(0.37),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: size.width * 0.02,
                      ),
                      Text(
                        prdData.get('desc'),
                        style: TextStyle(
                          height: 2.5,
                          fontSize: 16,
                          color: Colors.black.withOpacity(0.87),
                          fontWeight: FontWeight.w500,
                          fontFamily: 'DefaultFont',
                        ),
                      ),
                      SizedBox(
                        height: size.width * 0.04,
                      ),
                      BodyTextRegular(
                        string: '조회 58',
                        size: 14,
                        color: Colors.black.withOpacity(0.37),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                            top: size.width * 0.06, bottom: size.width * 0.07),
                        height: 1,
                        width: size.width,
                        color: Colors.black.withOpacity(0.1),
                      ),
                      GestureDetector(
                        onTap: () {
                          // 신고하기 버튼
                        },
                        child: Container(
                          color: Colors.transparent,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              BodyTextBold(string: '이 게시글 신고하기', size: 16),
                              Icon(Icons.navigate_next)
                            ],
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                            top: size.width * 0.07, bottom: size.width * 0.06),
                        height: 1,
                        width: size.width,
                        color: Colors.black.withOpacity(0.1),
                      ),
                      BodyTextBold(string: '현성님의 판매상품', size: 16),
                      SizedBox(
                        height: size.width * 0.06,
                      ),
                      Column(
                        children: customGrid(size),
                      ),
                      SizedBox(
                        height: size.width * 0.24,
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        Container(
          height: size.width * 0.24,
          decoration: BoxDecoration(
              color: scrollOffset > 270.0 ? Colors.white : null,
              border: Border(
                  bottom: BorderSide(
                      width: 1,
                      color: scrollOffset > 270.0
                          ? Colors.black.withOpacity(0.1)
                          : Colors.transparent))),
          child: SafeArea(
            bottom: false,
            left: false,
            right: false,
            child: Container(
              margin: EdgeInsets.only(
                  left: 16, right: 16, bottom: size.width * 0.02),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Get.back();
                        },
                        child: Icon(
                          Icons.arrow_back,
                          color: scrollOffset > 270.0
                              ? Colors.black
                              : Colors.white,
                        ),
                      ),
                      SizedBox(width: size.width * 0.02),
                      GestureDetector(
                        onTap: () {
                          Get.offAll(UsedMarketHome());
                        },
                        child: Container(
                          //color: Colors.amber,
                          child: Icon(
                            Icons.home_outlined,
                            color: scrollOffset > 270.0
                                ? Colors.black
                                : Colors.white,
                          ),
                        ),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.ios_share_outlined,
                        color:
                            scrollOffset > 270.0 ? Colors.black : Colors.white,
                      ),
                      SizedBox(width: size.width * 0.02),
                      Icon(
                        Icons.more_vert,
                        color:
                            scrollOffset > 270.0 ? Colors.black : Colors.white,
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border(
                    top: BorderSide(
                        width: 1, color: Colors.black.withOpacity(0.1)))),
            width: size.width,
            height: size.width * 0.22,
            child: Align(
              alignment: Alignment.topCenter,
              child: Container(
                margin: EdgeInsets.only(
                    left: 16, right: 16, top: size.width * 0.02),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.favorite,
                          color: Colors.pink[100],
                        ),
                        Container(
                          margin: EdgeInsets.only(
                              right: size.width * 0.02,
                              left: size.width * 0.02),
                          height: size.width * 0.1,
                          width: 1,
                          color: Colors.black.withOpacity(0.2),
                        ),
                        BodyTextBold(string: '99,999원', size: 16)
                      ],
                    ),
                    TextButton(
                      style: TextButton.styleFrom(
                          primary: Colors.white, backgroundColor: Colors.green),
                      onPressed: () {},
                      child: Text('채팅하기'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    ));
  }

  List<Widget> customGrid(Size size) {
    List<Widget> gridview = [];
    List<Widget> rowChildren = [];
    for (var i = 0; i < bestProductList.length; i++) {
      Widget widget = Container(
        margin: EdgeInsets.only(bottom: size.width * 0.06),
        width: size.width * 0.43,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: size.width * 0.43,
              height: size.width * 0.3,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  image: DecorationImage(
                      image:
                          Image.asset(bestProductList[i]['imgUrl'].toString())
                              .image,
                      fit: BoxFit.cover)),
            ),
            SizedBox(height: size.width * 0.02),
            BodyTextRegular(
              string: 'sadfasdfasfasfasdfaasdfasdfassdfas',
              size: 14,
              maxLines: 1,
            ),
            BodyTextBold(
              string: '65,000원',
              size: 14,
              maxLines: 1,
            )
          ],
        ),
      );

      rowChildren.add(widget);

      if (i % 2 == 1 || i == bestProductList.length - 1) {
        Widget row = Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: rowChildren,
        );
        gridview.add(row);
        rowChildren = [];
      }
    }
    return gridview;
  }
}
