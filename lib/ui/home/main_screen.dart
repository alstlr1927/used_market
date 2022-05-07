import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:used_market/ui/home/test.dart';
import 'package:used_market/ui/product/detail/product_detail.dart';
import 'used_home.dart';
import 'used_chat.dart';
import 'used_profile.dart';
import '../constraints.dart';
import '../product/regist/prd_regist.dart';

final List<Widget> _items = [Home(), Chat(), Profile()];

class UsedMarketHome extends StatefulWidget {
  const UsedMarketHome({Key? key}) : super(key: key);

  @override
  State<UsedMarketHome> createState() => _UsedMarketHomeState();
}

class _UsedMarketHomeState extends State<UsedMarketHome> {
  int _selectedIdx = 0;
  PageController _pageController = PageController();

  void modifyIdx(idx) {
    _pageController.jumpToPage(idx);
  }

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
          'assets/logo/char_white.png',
          fit: BoxFit.cover,
        ),
        //title: BodyTextBold(string: '잔디 마켓', size: 20),
        actions: [
          GestureDetector(
            onTap: () {
              Get.to(ProductDetail());
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
      body: PageView(
        controller: _pageController,
        children: _items,
        onPageChanged: (idx) {
          setState(() {
            _selectedIdx = idx;
          });
        },
        physics: const NeverScrollableScrollPhysics(),
      ),
      floatingActionButton: Container(
        child: _selectedIdx == 0
            ? FloatingActionButton(
                onPressed: () {
                  Get.offAll(RegistProduct());
                  //Get.to(App());
                },
                backgroundColor: Colors.green,
                child: const Icon(Icons.add),
              )
            : null,
      ),
      bottomNavigationBar: GNB(selectedIdx: _selectedIdx, modifyIdx: modifyIdx),
    );
  }
}

// 중고마켓 홈 content
class UsedHomeBody extends StatefulWidget {
  const UsedHomeBody({Key? key}) : super(key: key);

  @override
  State<UsedHomeBody> createState() => _UsedHomeBodyState();
}

class _UsedHomeBodyState extends State<UsedHomeBody> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class GNB extends StatefulWidget {
  GNB({Key? key, required this.selectedIdx, this.modifyIdx}) : super(key: key);
  int selectedIdx;
  var modifyIdx;

  @override
  State<GNB> createState() => _GNBState();
}

class _GNBState extends State<GNB> {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      backgroundColor: Colors.white,
      selectedItemColor: Colors.black,
      unselectedItemColor: Colors.grey,
      selectedFontSize: 14,
      unselectedFontSize: 14,
      currentIndex: widget.selectedIdx,
      onTap: (idx) {
        widget.modifyIdx(idx);
      },
      showUnselectedLabels: false,
      showSelectedLabels: true,
      items: const [
        BottomNavigationBarItem(
          label: '홈',
          icon: Icon(Icons.home_outlined),
        ),
        BottomNavigationBarItem(
          label: '채팅',
          icon: Icon(Icons.chat_outlined),
        ),
        BottomNavigationBarItem(
          label: '내정보',
          icon: Icon(Icons.person),
        ),
      ],
    );
  }
}
