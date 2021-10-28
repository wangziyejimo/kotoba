import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kotoba/common/my_styles.dart';

class ReciteWordsPage extends StatefulWidget {
  @override
  _ReciteWordsPage createState() => _ReciteWordsPage();

}

class _ReciteWordsPage extends State<ReciteWordsPage> {

  List<String> _myBooks = ['other0', '1', '2'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ListView.builder(
          itemCount: _myBooks.length + 1,
          itemBuilder: (BuildContext context, int index) {
            if (0 == index) {
              return Container(
                height: 80,
                color: Colors.yellow,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 20),
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
            } else {
              return _bookItem(context, index);
            }
          },
        ),
      ),
    );
  }

  _bookItem(BuildContext context, int index) {
    return Container(
      height: 140,
      child: Padding(
        padding: EdgeInsets.only(top: 10, left: 10, right: 10),
        child: Material(
          borderRadius: BorderRadius.circular(10.0),
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [MyColors.gradientStartColor, MyColors.gradientEndColor],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight
              )
            ),
            child: Column(
              children: [
                Container(
                  child: Text('other' + index.toString()),
                ),
                Row(
                  children: [
                    Column(
                      children: [
                        Text('64/300'),
                        Container(
                          width: 200,
                          child: LinearProgressIndicator(
                            value: 30/100,
                            backgroundColor: Colors.yellow,
                            valueColor: AlwaysStoppedAnimation(Colors.red),
                            minHeight: 10,
                          ),
                        )
                      ],
                    ),
                    Container(
                      child: Text('30%'),
                    )
                  ],
                ),
                Row(
                  children: [
                    OutlinedButton(
                        onPressed: () => {
                          print('练习 button clicked')
                        },
                        child: Text('练习')
                    ),
                    OutlinedButton(
                        onPressed: () => {},
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

}