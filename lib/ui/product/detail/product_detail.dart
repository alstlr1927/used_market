import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:used_market/ui/constraints.dart';

class ProductDetail extends StatefulWidget {
  const ProductDetail({Key? key}) : super(key: key);

  @override
  State<ProductDetail> createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
        body: Stack(
      children: [
        SizedBox(
          width: size.width,
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                SizedBox(
                  width: size.width,
                  height: size.width,
                  child: Image.asset(
                    'assets/product/airpod.jpg',
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(
                  width: size.width,
                  height: size.width,
                  child: Image.asset(
                    'assets/product/airpod.jpg',
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(
                  width: size.width,
                  height: size.width,
                  child: Image.asset(
                    'assets/product/airpod.jpg',
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(
                  width: size.width,
                  height: size.width,
                  child: Image.asset(
                    'assets/product/airpod.jpg',
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(
                  width: size.width,
                  height: size.width,
                  child: Image.asset(
                    'assets/product/airpod.jpg',
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            ),
          ),
        ),
        Container(
          height: size.width * 0.24,
          child: SafeArea(
            child: Container(
              margin: const EdgeInsets.only(left: 16, right: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                      ),
                      SizedBox(width: size.width * 0.02),
                      const Icon(
                        Icons.home,
                        color: Colors.white,
                      )
                    ],
                  ),
                  Row(
                    children: [
                      const Icon(
                        Icons.ios_share_outlined,
                        color: Colors.white,
                      ),
                      SizedBox(width: size.width * 0.02),
                      const Icon(
                        Icons.more_vert,
                        color: Colors.white,
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
            width: size.width,
            height: size.width * 0.25,
            color: Colors.white,
            child: Container(
              margin: const EdgeInsets.only(left: 16, right: 16),
              child: Row(
                children: [
                  Row(
                    children: [
                      SvgPicture.asset('assets/icons/favorite_filled.svg'),
                      SvgPicture.asset('/assets/icons/favorite_filled.svg')
                    ],
                  ),
                  TextButton(
                    style: TextButton.styleFrom(
                        primary: Colors.white, backgroundColor: Colors.green),
                    onPressed: () {},
                    child: Text('채팅하기'),
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    ));
  }
}
