import 'package:flutter/material.dart';
import 'package:used_market/ui/constraints.dart';

class ProductCategoryList extends StatefulWidget {
  const ProductCategoryList({Key? key}) : super(key: key);

  @override
  State<ProductCategoryList> createState() => _ProductCategoryListState();
}

class _ProductCategoryListState extends State<ProductCategoryList> {
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
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.black,
        backgroundColor: Colors.white,
        elevation: 1,
        centerTitle: true,
        title: BodyTextBold(
          string: '카테고리',
          size: 20,
        ),
      ),
      body: CustomScrollView(
        scrollDirection: Axis.vertical,
        slivers: [
          SliverList(
              delegate: SliverChildBuilderDelegate((context, idx) {
            return Container(
              decoration: BoxDecoration(),
              alignment: Alignment.centerLeft,
              width: size.width,
              height: size.width * 0.15,
              child: Container(
                margin: const EdgeInsets.only(left: 16),
                child: BodyTextBold(
                  string: categoryList[idx],
                  size: 16,
                  color: Colors.black.withOpacity(0.6),
                ),
              ),
            );
          }, childCount: categoryList.length))
        ],
      ),
    );
  }
}
