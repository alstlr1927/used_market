import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class UsedMarketHome extends StatefulWidget {
  const UsedMarketHome({Key? key}) : super(key: key);

  @override
  State<UsedMarketHome> createState() => _UsedMarketHomeState();
}

class _UsedMarketHomeState extends State<UsedMarketHome> {
  List<Widget> _items = [Text1(), Text2(), Text3()];
  int _selectedIdx = 0;

  void modifyIdx(idx) {
    setState(() {
      _selectedIdx = idx;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: _items[_selectedIdx],
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

class Text1 extends StatelessWidget {
  const Text1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: const Text('Text1'),
    );
  }
}

class Text2 extends StatelessWidget {
  const Text2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: const Text('Text2'),
    );
  }
}

class Text3 extends StatelessWidget {
  const Text3({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: const Text('Text3'),
    );
  }
}
