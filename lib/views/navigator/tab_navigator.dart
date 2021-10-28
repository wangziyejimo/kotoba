import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kotoba/common/my_styles.dart';
import 'package:kotoba/views/pages/local/local_page.dart';
import 'package:kotoba/views/pages/my/my_page.dart';
import 'package:kotoba/views/pages/recitewords/recite_words_page.dart';
import 'package:kotoba/views/pages/thesaurus/thesaurus_page.dart';

class TabNavigator extends StatefulWidget {
  @override
  _TabNavigatorState createState() => _TabNavigatorState();

}

class _TabNavigatorState extends State<TabNavigator> {

  final PageController _controller = PageController(initialPage: 0);
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _controller,
        physics: NeverScrollableScrollPhysics(),
        children: [
          ReciteWordsPage(),
          ThesaurusPage(),
          LocalPage(),
          MyPage()
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          _controller.jumpToPage(index);
          setState(() {
            _currentIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        items: [
          _bottomNavigationBarItem(Icons.book_online, MyColors.unActiveTabColor, MyColors.mainColor, '背词'),
          _bottomNavigationBarItem(Icons.library_books, MyColors.unActiveTabColor, MyColors.mainColor, '词库'),
          _bottomNavigationBarItem(Icons.local_activity, MyColors.unActiveTabColor, MyColors.mainColor, '本地'),
          _bottomNavigationBarItem(Icons.people_alt, MyColors.unActiveTabColor, MyColors.mainColor, '我的')
        ],
      ),
    );
  }

  _bottomNavigationBarItem (IconData icon, Color defaultColor, Color activeColor, String labelText) {
    return BottomNavigationBarItem(
      icon: Icon(
        icon,
        color: defaultColor,
      ),
      activeIcon: Icon(
        icon,
        color: activeColor,
      ),
      label: labelText
    );
  }

}