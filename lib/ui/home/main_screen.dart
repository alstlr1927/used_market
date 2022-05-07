import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:used_market/ui/home/test.dart';
import 'used_home.dart';
import 'used_chat.dart';
import 'used_profile.dart';
import '../constraints.dart';
import '../regist/prd_regist.dart';

class UsedMarketHome extends StatefulWidget {
  const UsedMarketHome({Key? key}) : super(key: key);

  @override
  State<UsedMarketHome> createState() => _UsedMarketHomeState();
}

class _UsedMarketHomeState extends State<UsedMarketHome> {
  List<Widget> _items = [Home(), Chat(), Profile()];
  int _selectedIdx = 0;

  void modifyIdx(idx) {
    setState(() {
      _selectedIdx = idx;
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        centerTitle: true,
        foregroundColor: Colors.black,
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        title: BodyTextBold(string: '중고 마켓', size: 20),
        actions: [
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
      body: Container(
        child: _items[_selectedIdx],
        color: Colors.white,
      ),
      floatingActionButton: Container(
        child: _selectedIdx == 0
            ? FloatingActionButton(
                onPressed: () {
                  Get.to(RegistProduct());
                  //Get.to(App());
                },
                backgroundColor: Colors.blue,
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
