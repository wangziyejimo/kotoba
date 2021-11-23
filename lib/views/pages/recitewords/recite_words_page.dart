import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kotoba/common/my_styles.dart';
import 'package:kotoba/data/database/my_book.dart';
import 'package:kotoba/views/pages/recitewords/practice.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class ReciteWordsPage extends StatefulWidget {
  @override
  _ReciteWordsPage createState() => _ReciteWordsPage();

}

class _ReciteWordsPage extends State<ReciteWordsPage> {

  List<String> _myBooks = ['other0', '1', '2'];
  RefreshController _refreshController = RefreshController(initialRefresh: false);

  void _onRefresh() async {
    await Future.delayed(Duration(milliseconds: 1000));
    _refreshController.refreshCompleted();
  }

  void _onLoading() async {
    await Future.delayed(Duration(milliseconds: 1000));
    _myBooks.add('111');
    _refreshController.loadComplete();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SmartRefresher(
          enablePullDown: true,
          enablePullUp: false,
          header: ClassicHeader(),
          controller: _refreshController,
          onRefresh: _onRefresh,
          onLoading: _onLoading,
          child: ListView.builder(
            itemCount: _myBooks.length + 1,
            itemBuilder: (BuildContext context, int index) {
              if (0 == index) {
                return Container(
                  height: 70,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 20, top: 30),
                        child: Text('勉強を初めましょう！',
                          style: TextStyle(
                              color: MyColors.titleHColor,
                              fontSize: 24.0
                          ),
                        ),
                      ),
                      Container(
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(right: 10),
                              child: TextButton(
                                onPressed: () => {
                                  print("edit button clicked")
                                },
                                child: Text('编辑'),
                                style: ButtonStyle(
                                    textStyle: MaterialStateProperty.all(
                                        TextStyle(fontSize: 18.0, color: MyColors.mainColor)
                                    )
                                ),
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                );
              } else if (index == _myBooks.length) {
                return _addButton(context, index);
              } else {
                return _bookItem(context, index);
              }
            },
          ),
        ),
      ),
    );
  }

  _bookItem(BuildContext context, int index) {
    return Container(
      height: 150,
      child: Padding(
        padding: EdgeInsets.only(top: 10, left: 10, right: 10),
        child: Material(
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [MyColors.gradientStartColor, MyColors.gradientEndColor],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight
              ),
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.only(left: 20, top: 10),
                  child: Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                            text: '我的词库',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white
                          )
                        ),
                        TextSpan(
                          text: '(在"本地"中编辑)',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.white
                          )
                        )
                      ]
                    )
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 10),
                          child: Text(
                            '64/300',
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.white
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 5),
                          width: MediaQuery.of(context).size.width - 105,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10.0),
                            child: LinearProgressIndicator(
                              value: 98/100,
                              backgroundColor: Colors.white,
                              valueColor: AlwaysStoppedAnimation(MyColors.progressActiveColor),
                              minHeight: 10,
                            ),
                          )
                        )
                      ],
                    ),
                    Container(
                      margin: EdgeInsets.only(right: 20, left: 15),
                      child: Text(
                        '30%',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white
                        ),
                      ),
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    OutlinedButton(
                      style: ButtonStyle(
                        foregroundColor: MaterialStateProperty.resolveWith((states) => Colors.white),
                        side: MaterialStateProperty.all(BorderSide(color: Colors.white, width: 2)),
                        minimumSize: MaterialStateProperty.all(Size(90, 30))
                      ),
                      onPressed: () => {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => Practice()))
                      },
                      child: Text('练习'),
                    ),
                    OutlinedButton(
                        style: ButtonStyle(
                          foregroundColor: MaterialStateProperty.resolveWith((states) => Colors.white),
                          side: MaterialStateProperty.all(BorderSide(color: Colors.white, width: 2)),
                          minimumSize: MaterialStateProperty.all(Size(90, 30))
                        ),
                        onPressed: () => {
                          _connectToTheDB()
                        },
                        child: Text('复习')
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  _addButton(BuildContext context, int index) {
    return Container(
      margin: EdgeInsets.only(left: 10, right: 10, top: 5),
      child: OutlinedButton(
        onPressed: () => {
          print('add add')
        },
        child: Text(
          '添加更多内容',
          style: TextStyle(
            fontSize: 16.0
          ),
        ),
      ),
    );
  }

  _pullUpFooter(BuildContext context) {
    return CustomFooter(
      builder: (BuildContext context, LoadStatus? mode) {
        return Container(
          child: Text('aaaaa'),
        );
      },
    );
  }

  _connectToTheDB () async {
    print('复习 button clicked');
    MyBookSqlite sq = MyBookSqlite();
    await sq.openSqlite();
    MyBook book = MyBook(3,'标准日本语','田中','Trial');
    // await sq.insert(book);
    List<MyBook>? a = await sq.queryAll();
    print(a.toString());
    sq.close();
  }

}