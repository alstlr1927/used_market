import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'main_screen_stack/used_home.dart';
import 'main_screen_stack/used_chat.dart';
import 'main_screen_stack/used_profile.dart';
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
      selectedItemColor: Colors.green,
      unselectedItemColor: Colors.green[200],
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
