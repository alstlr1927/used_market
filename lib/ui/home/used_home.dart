import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../constraints.dart';
import 'package:carousel_slider/carousel_slider.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      width: size.width,
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            SizedBox(
              height: size.width * 0.02,
            ),
            // 로고 && 검색, 알림 로고
            const HeaderArea(),
            SizedBox(
              height: size.width * 0.02,
            ),
            // 카테고리 영역
            CategoryArea(),
            // 배너 영역
            const BannerArea(),
            SizedBox(
              height: size.width * 0.1,
            ),
            // 무료나눔 상품 영역
            FreePrdArea(),
            Container(
              height: size.width * 0.06,
            ),
            // 인기 상품
            BestPrdArea(),
          ],
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
            margin: EdgeInsets.only(left: size.width * 0.02),
          ),
          Container(
            child: Row(
              children: [
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    child: const Icon(Icons.search),
                    margin: EdgeInsets.only(right: size.width * 0.02),
                  ),
                ),
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    child: const Icon(Icons.notifications_active_outlined),
                    margin: EdgeInsets.only(right: size.width * 0.02),
                  ),
                )
              ],
            ),
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
      margin: EdgeInsets.only(
          left: size.width * 0.02,
          right: size.width * 0.02,
          top: size.width * 0.02),
      child: CustomScrollView(
        scrollDirection: Axis.horizontal,
        slivers: [
          SliverList(
              delegate: SliverChildBuilderDelegate((context, idx) {
            return Container(
              margin: EdgeInsets.only(right: size.width * 0.03),
              child: BodyTextRegular(
                string: categoryList[idx],
                size: 14,
                color: Color(0xff000000).withOpacity(0.6),
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
    return Container(
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
            child: BodyTextBold(string: '무료 나눔', size: 16),
            margin: EdgeInsets.only(
                left: size.width * 0.02, bottom: size.width * 0.02),
          ),
          Container(
            width: size.width,
            height: size.width * 0.35,
            margin: EdgeInsets.only(
                left: size.width * 0.02, right: size.width * 0.02),
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
                        // child: Image.asset(
                        //   freeProductList[idx]['imgUrl'].toString(),
                        //   fit: BoxFit.fill,
                        // ),
                      ),
                      Container(
                        child: BodyTextRegular(
                          string: freeProductList[idx]['productNm'].toString(),
                          size: 14,
                        ),
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
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    var bestProductList = [
      {
        'productNm': '쓰레기통',
        'imgUrl': 'assets/product/trash.jpg',
        'price': '5000'
      },
      {
        'productNm': '샴푸',
        'imgUrl': 'assets/product/shamp.png',
        'price': '17000'
      },
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
      {
        'productNm': '의자',
        'imgUrl': 'assets/product/chair.png',
        'price': '35000'
      },
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
    return Container(
      width: size.width,
      height: size.width * 1.2,
      //color: Colors.grey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            child: BodyTextBold(string: '인기 상품', size: 16),
            margin: EdgeInsets.only(
                left: size.width * 0.02, bottom: size.width * 0.02),
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
                            left: size.width * 0.04, bottom: size.width * 0.04),
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
                                    Container(
                                      child: BodyTextBold(
                                        string: data[i][idx]['productNm'],
                                        size: 16,
                                      ),
                                    ),
                                    Container(
                                      child: Row(
                                        children: [
                                          BodyTextBold(
                                              string: data[i][idx]['price'],
                                              size: 16),
                                          BodyTextRegular(string: '원', size: 16)
                                        ],
                                      ),
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
