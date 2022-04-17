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
            // 무료나눔 상품 영역
            FreePrdArea(),
            Container(
              height: size.width * 0.02,
              color: Colors.grey,
            )
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
            return Image.asset(bannerList[i]);
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
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      height: size.width * 0.5,
      margin:
          EdgeInsets.only(left: size.width * 0.02, right: size.width * 0.02),
      child: CustomScrollView(
        scrollDirection: Axis.horizontal,
        slivers: [
          SliverList(delegate: SliverChildBuilderDelegate((context, idx) {
            return Container();
          })),
        ],
      ),
    );
  }
}
