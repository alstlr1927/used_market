import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../home/main_screen.dart';

class SelectLoginRoot extends StatefulWidget {
  const SelectLoginRoot({Key? key}) : super(key: key);

  @override
  State<SelectLoginRoot> createState() => _SelectLoginRootState();
}

class _SelectLoginRootState extends State<SelectLoginRoot> {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(31, 10, 31, 10),
            child: GestureDetector(
              onTap: () async {
                Get.to(UsedMarketHome());
              },
              child: Container(
                height: 63,
                decoration: BoxDecoration(
                    color: const Color(0xfff5f5f7),
                    borderRadius: BorderRadius.circular(13),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        spreadRadius: 0,
                        blurRadius: 4,
                        offset: const Offset(3, 3),
                      )
                    ]),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: size.width * 0.12,
                    ),
                    Container(
                      width: 55,
                      child: SvgPicture.asset('assets/images/google.svg'),
                    ),
                    const Text(
                      'Google로 로그인',
                      style: TextStyle(
                          fontSize: 18, fontFamily: 'AppleSDGothicNeoM'),
                    )
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(31, 10, 31, 10),
            child: GestureDetector(
              onTap: () {},
              child: Container(
                height: 63,
                decoration: BoxDecoration(
                    color: const Color(0xfff5f5f7),
                    borderRadius: BorderRadius.circular(13),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        spreadRadius: 0,
                        blurRadius: 4,
                        offset: const Offset(3, 3),
                      )
                    ]),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: size.width * 0.12,
                    ),
                    Container(
                      width: 55,
                      child: SvgPicture.asset('assets/images/apple.svg'),
                    ),
                    const Text(
                      'Apple로 로그인',
                      style: TextStyle(
                          fontSize: 18, fontFamily: 'AppleSDGothicNeoM'),
                    )
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(31, 10, 31, 10),
            child: GestureDetector(
              onTap: () {},
              child: Container(
                height: 63,
                decoration: BoxDecoration(
                    color: const Color(0xfff5f5f7),
                    borderRadius: BorderRadius.circular(13),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        spreadRadius: 0,
                        blurRadius: 4,
                        offset: const Offset(3, 3),
                      )
                    ]),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: size.width * 0.12,
                    ),
                    Container(
                      width: 55,
                      child: SvgPicture.asset('assets/images/facebook.svg'),
                    ),
                    const Text(
                      'Facebook으로 로그인',
                      style: TextStyle(
                          fontSize: 18, fontFamily: 'AppleSDGothicNeoM'),
                    )
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(31, 10, 31, 10),
            child: GestureDetector(
              onTap: () {},
              child: Container(
                height: 63,
                decoration: BoxDecoration(
                    color: const Color(0xfff5f5f7),
                    borderRadius: BorderRadius.circular(13),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        spreadRadius: 0,
                        blurRadius: 4,
                        offset: const Offset(3, 3),
                      )
                    ]),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: size.width * 0.12,
                    ),
                    Container(
                      width: 55,
                      child: SvgPicture.asset('assets/images/email.svg'),
                    ),
                    const Text(
                      '다른 이메일로 로그인',
                      style: TextStyle(
                          fontSize: 18, fontFamily: 'AppleSDGothicNeoM'),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
