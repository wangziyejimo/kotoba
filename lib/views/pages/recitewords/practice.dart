import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kotoba/common/my_styles.dart';

class Practice extends StatefulWidget {
  @override
  _Practice createState() => _Practice();

}

class _Practice extends State<Practice> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyColors.mainColor,
        title: Text(
          '练习'
        ),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: 3,
        itemBuilder: (BuildContext context, int index) {
          return _getPracticeItem(context, index);
        },
      ),
    );
  }

  _getPracticeItem(BuildContext context, int index) {
    return Container(
      height: 140,
      child: Container(
        color: Colors.white,
        margin: EdgeInsets.only(left: 10, right: 10),
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: 10.0),
              child: Text(
                '小李爱学习',
                style: TextStyle(
                  fontSize: 24.0,
                  color: MyColors.titleHHColor
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 20.0, bottom: 10.0),
              alignment: Alignment.centerRight,
              child: Text(
                  '未练习'
              ),
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    '共30词',
                    style: TextStyle(
                      fontSize: 16
                    ),
                  ),
                  Text(
                      '选择10/20'
                  ),
                  Text(
                      '默写20/30'
                  ),
                  Text(
                    '听写0/0'
                  )
                ],
              ),
            )
          ],
        )
      ),
      decoration: BoxDecoration(
        color: MyColors.mainBackgroundColor,
        border: Border(
          bottom: BorderSide(
            width: 10,
            color: MyColors.mainBackgroundColor
          )
        )
      ),
    );
  }

}