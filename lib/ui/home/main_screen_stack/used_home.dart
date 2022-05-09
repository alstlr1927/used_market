import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:used_market/ui/product/detail/product_detail.dart';
import 'package:used_market/ui/product/list/category_list.dart';
import '../../constraints.dart';
import 'package:carousel_slider/carousel_slider.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  ScrollController _scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        centerTitle: true,
        foregroundColor: Colors.white,
        backgroundColor: Colors.green,
        automaticallyImplyLeading: false,
        title: Image.asset(
          'assets/images/logo/char_white_horizontal.png',
          width: size.width * 0.5,
          height: size.width * 0.1,
        ),
        //title: BodyTextBold(string: '잔디 마켓', size: 20),
        actions: [
          GestureDetector(
            onTap: () {
              //
            },
            child: Container(
              child: const Icon(Icons.search),
              margin: EdgeInsets.only(right: size.width * 0.04),
            ),
          ),
          GestureDetector(
            onTap: () {},
            child: Container(
              child: const Icon(Icons.notifications_active_outlined),
              margin: const EdgeInsets.only(right: 16),
            ),
          )
        ],
      ),
      body: Container(
        width: size.width,
        child: SingleChildScrollView(
          controller: _scrollController,
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              SizedBox(
                height: size.width * 0.02,
              ),
              // 로고 && 검색, 알림 로고
              //const HeaderArea(),
              SizedBox(
                height: size.width * 0.02,
              ),
              // 카테고리 영역
              CategoryArea(),
              // 배너 영역
              const BannerArea(),
              Container(
                margin: EdgeInsets.only(
                    top: size.width * 0.05, bottom: size.width * 0.05),
                //color: Colors.black.withOpacity(0.1),
                height: size.width * 0.01,
              ),
              // 무료나눔 상품 영역
              FreePrdArea(),
              Container(
                margin: EdgeInsets.only(
                    top: size.width * 0.05, bottom: size.width * 0.01),
                color: Colors.black.withOpacity(0.05),
                height: size.width * 0.01,
              ),
              // 인기 상품
              BestPrdArea(),
              Container(
                margin: EdgeInsets.only(
                    top: size.width * 0.05, bottom: size.width * 0.06),
                color: Colors.black.withOpacity(0.05),
                height: size.width * 0.01,
              ),
              // 인기 검색어
              SearchWordArea(),
              Container(
                margin: EdgeInsets.only(
                    top: size.width * 0.08, bottom: size.width * 0.06),
                color: Colors.black.withOpacity(0.05),
                height: size.width * 0.01,
              ),
              // 최신 상품
              RecentlyPrdArea(scrollController: _scrollController)
            ],
          ),
        ),
      ),
    );
  }
}

// 헤더 영역
class HeaderArea extends StatelessWidget {
  const HeaderArea({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SizedBox(
      width: size.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            child: BodyTextBold(string: '중고 마켓', size: 20),
            margin: const EdgeInsets.only(left: 16),
          ),
          Row(
            children: [
              GestureDetector(
                onTap: () {},
                child: Container(
                  child: const Icon(Icons.search),
                  margin: EdgeInsets.only(right: size.width * 0.04),
                ),
              ),
              GestureDetector(
                onTap: () {},
                child: Container(
                  child: const Icon(Icons.notifications_active_outlined),
                  margin: const EdgeInsets.only(right: 16),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}

class CategoryArea extends StatelessWidget {
  CategoryArea({Key? key}) : super(key: key);
  final categoryList = [
    '여성의류',
    '패션잡화',
    '디지털/가전',
    '남성의류',
    '유아동/출산',
    '생활/식품',
    '뷰티',
    '스포츠/레저',
    '가구/인테리어',
    '도서/문구',
    '취미/게임',
    '티켓/쿠폰',
    '서비스/재능',
    '기타'
  ];
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      height: size.width * 0.1,
      margin: EdgeInsets.only(top: size.width * 0.02),
      child: CustomScrollView(
        scrollDirection: Axis.horizontal,
        slivers: [
          SliverList(
              delegate: SliverChildBuilderDelegate((context, idx) {
            return GestureDetector(
              onTap: () {
                Get.to(CategoryProductList(
                  categoryName: categoryList[idx],
                ));
              },
              child: Container(
                margin: EdgeInsets.only(right: size.width * 0.03),
                child: BodyTextBold(
                  string: categoryList[idx],
                  size: 16,
                  color: const Color(0xff000000).withOpacity(0.68),
                ),
              ),
            );
          }, childCount: categoryList.length))
        ],
      ),
    );
  }
}

// 배너영역
class BannerArea extends StatelessWidget {
  const BannerArea({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bannerList = [
      'assets/banner/main_bnn01.png',
      'assets/banner/main_bnn02.png',
      'assets/banner/main_bnn03.png'
    ];
    final size = MediaQuery.of(context).size;
    return SizedBox(
      width: size.width,
      height: size.width * 0.2,
      child: CarouselSlider.builder(
          itemCount: bannerList.length,
          itemBuilder: (context, i, i2) {
            return Image.asset(
              bannerList[i],
              fit: BoxFit.fill,
            );
          },
          options: CarouselOptions(
            autoPlay: true,
            initialPage: 0,
          )),
    );
  }
}

// 무료나눔 상품 영역
class FreePrdArea extends StatefulWidget {
  const FreePrdArea({Key? key}) : super(key: key);

  @override
  State<FreePrdArea> createState() => _FreePrdAreaState();
}

class _FreePrdAreaState extends State<FreePrdArea> {
  final freeProductList = [
    {'productNm': '쓰레기통', 'imgUrl': 'assets/product/trash.jpg'},
    {'productNm': '샴푸', 'imgUrl': 'assets/product/shamp.png'},
    {'productNm': '슬랙스', 'imgUrl': 'assets/product/pants.png'},
    {'productNm': '조거팬츠', 'imgUrl': 'assets/product/jogger_pants.png'},
    {'productNm': '의자', 'imgUrl': 'assets/product/chair.png'},
    {'productNm': '담요', 'imgUrl': 'assets/product/blanket.png'},
  ];
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            child: BodyTextBold(
              string: '무료 나눔',
              size: 18,
            ),
            margin: EdgeInsets.only(left: 16, bottom: size.width * 0.04),
          ),
          Container(
            width: size.width,
            height: size.width * 0.35,
            margin: const EdgeInsets.only(left: 16, right: 16),
            child: CustomScrollView(
              scrollDirection: Axis.horizontal,
              slivers: [
                SliverList(
                    delegate: SliverChildBuilderDelegate((context, idx) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(
                            right: size.width * 0.04,
                            bottom: size.width * 0.02),
                        width: size.width * 0.25,
                        height: size.width * 0.25,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            image: DecorationImage(
                                image: Image.asset(freeProductList[idx]
                                            ['imgUrl']
                                        .toString())
                                    .image)),
                      ),
                      BodyTextBold(
                        string: freeProductList[idx]['productNm'].toString(),
                        size: 14,
                        color: const Color(0xff000000).withOpacity(0.68),
                      ),
                    ],
                  );
                }, childCount: freeProductList.length)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class BestPrdArea extends StatefulWidget {
  const BestPrdArea({Key? key}) : super(key: key);

  @override
  State<BestPrdArea> createState() => _BestPrdAreaState();
}

class _BestPrdAreaState extends State<BestPrdArea> {
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
    var data = [];
    var tempData = [];
    for (var i = 0; i < bestProductList.length; i++) {
      tempData.add(bestProductList[i]);
      if (i % 3 == 2 || i == bestProductList.length - 1) {
        // i == 2, 5, 8
        data.add(tempData);
        tempData = [];
      }
    }
    return SizedBox(
      width: size.width,
      height: size.width * 1.2,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            child: BodyTextBold(string: '인기 상품', size: 18),
            margin: EdgeInsets.only(left: 16, bottom: size.width * 0.02),
          ),
          CarouselSlider.builder(
              itemCount: data.length,
              itemBuilder: (context, i, i2) {
                return ListView.builder(
                    itemCount: data[i].length,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, idx) {
                      return Container(
                        margin: EdgeInsets.only(
                            left: 16, bottom: size.width * 0.04),
                        width: size.width,
                        height: size.width * 0.3,
                        child: Row(
                          children: [
                            Container(
                              width: size.width * 0.3,
                              height: size.width * 0.3,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                image: DecorationImage(
                                  fit: BoxFit.fill,
                                  image: Image.asset(
                                    data[i][idx]['imgUrl'].toString(),
                                  ).image,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                margin:
                                    EdgeInsets.only(left: size.width * 0.04),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    BodyTextBold(
                                      string: data[i][idx]['productNm'],
                                      size: 16,
                                    ),
                                    Row(
                                      children: [
                                        BodyTextBold(
                                            string: data[i][idx]['price'],
                                            size: 16),
                                        BodyTextRegular(string: '원', size: 16)
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      );
                    });
              },
              options: CarouselOptions(
                  autoPlay: false,
                  height: size.width,
                  viewportFraction: 1.0,
                  aspectRatio: 1 / 1)),
        ],
      ),
    );
  }
}

// 인기 검색어 영역
class SearchWordArea extends StatefulWidget {
  const SearchWordArea({Key? key}) : super(key: key);

  @override
  State<SearchWordArea> createState() => _SearchWordAreaState();
}

class _SearchWordAreaState extends State<SearchWordArea> {
  List<Map> searchWordList = [
    {'word': '맥북 프로'},
    {'word': '아이패드'},
    {'word': '에어팟'},
    {'word': '그램 360'},
    {'word': '아이폰14'},
    {'word': '키보드'},
    {'word': '마우스'},
    {'word': '스피커'},
  ];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.only(right: 16, left: 16),
      child: Column(
        children: [
          Container(
            alignment: Alignment.centerLeft,
            margin: EdgeInsets.only(bottom: size.width * 0.04),
            child: BodyTextBold(
              string: '인기 검색어',
              size: 16,
            ),
          ),
          SizedBox(
            width: size.width,
            height: size.width * 0.1,
            child: CustomScrollView(
              scrollDirection: Axis.horizontal,
              slivers: [
                SliverList(
                    delegate: SliverChildBuilderDelegate((context, idx) {
                  return Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.only(right: size.width * 0.04),
                    padding: EdgeInsets.all(size.width * 0.02),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: const Color.fromARGB(255, 237, 235, 235)),
                    child: BodyTextBold(
                      string: searchWordList[idx]['word'],
                      size: 14,
                    ),
                  );
                }, childCount: searchWordList.length))
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// 최신 상품 영역
class RecentlyPrdArea extends StatefulWidget {
  RecentlyPrdArea({Key? key, required this.scrollController}) : super(key: key);
  ScrollController scrollController;
  @override
  State<RecentlyPrdArea> createState() => _RecentlyPrdAreaState();
}

class _RecentlyPrdAreaState extends State<RecentlyPrdArea> {
  FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  List<DocumentSnapshot> products = [];

  bool isLoading = false;
  bool hasMore = true;
  int documentLimit = 10;
  DocumentSnapshot? lastDocument = null;

  @override
  void initState() {
    getProducts();
    widget.scrollController.addListener(() {
      double maxScroll = widget.scrollController.position.maxScrollExtent;
      double currentScroll = widget.scrollController.position.pixels;
      double delta = MediaQuery.of(context).size.height * 0.20;
      print('max : $maxScroll');
      print('cur : $currentScroll');
      if (maxScroll - currentScroll <= delta) {
        getProducts();
      }
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

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.only(left: 16, right: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: customGrid(size),
      ),
    );
  }

  List<Widget> customGrid(Size size) {
    List<Widget> gridview = [];
    List<Widget> rowChildren = [];
    Widget container = Container(
      margin: EdgeInsets.only(bottom: size.width * 0.06),
      child: BodyTextBold(
        string: '최근 등록된 상품',
        size: 18,
      ),
    );
    gridview.add(container);
    for (var i = 0; i < products.length; i++) {
      Widget widget = GestureDetector(
          onTap: () {
            Get.to(ProductDetail(pid: products[i].id));
          },
          child: Container(
            margin: EdgeInsets.only(bottom: size.width * 0.04),
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
                              Image.network(products[i].get('images')[0]).image,
                          fit: BoxFit.cover)),
                ),
                SizedBox(height: size.width * 0.02),
                BodyTextRegular(
                  string: products[i].get('name'),
                  size: 14,
                  maxLines: 1,
                ),
                BodyTextBold(
                  string: '${products[i].get('price')}원',
                  size: 14,
                  maxLines: 1,
                ),
              ],
            ),
          ));

      rowChildren.add(widget);

      if (i % 2 == 1 || i == products.length - 1) {
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
