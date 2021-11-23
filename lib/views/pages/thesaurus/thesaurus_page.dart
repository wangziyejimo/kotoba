import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kotoba/common/my_styles.dart';

class ThesaurusPage extends StatefulWidget {
  @override
  _ThesaurusPage createState() => _ThesaurusPage();

}

class _ThesaurusPage extends State<ThesaurusPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyColors.mainColor,
        title: Text(
            '词库'
        ),
        centerTitle: true,
      ),
      body: Center(
        child: ListView.separated(
          itemCount: 50,
          itemBuilder: (BuildContext context, int index) => _thesaurusItem(context, index),
          separatorBuilder: (BuildContext context, int index) => _getSeparatorItem(context, index),
        ),
      ),
    );
  }
  
  _getSeparatorItem(BuildContext context, int index) {
    return Divider(height: 2.0, color: MyColors.mainBackgroundColor,);
  }

  _thesaurusItem(BuildContext context, int index) {
    return Container(
      color: Colors.white,
      margin: EdgeInsets.only(left: 10, right: 10),
      height: 90,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            child: Image(
              image: AssetImage('assets/images/dev/JAP.png'),
              width: 50,
              height: 70,
            ),
          ),
          Expanded(
            child: Container(
              margin: EdgeInsets.only(left: 20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    child: Text('标准日本语'),
                  ),
                  Container(
                    child: Text('共100词'),
                  )
                ],
              )
            )
          ),
          Container(
            child: Image(
              image: AssetImage('assets/images/icons/arrow_right.png'),
              width:20,
              height: 20,
            ),
          )
        ],
      ),
    );
  }

}