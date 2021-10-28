import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ThesaurusPage extends StatefulWidget {
  @override
  _ThesaurusPage createState() => _ThesaurusPage();

}

class _ThesaurusPage extends State<ThesaurusPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ListView.builder(
          itemCount: 50,
          itemExtent: 50.0,
          itemBuilder: (BuildContext context, int index) {
            if (0 == index) {
              return Text('第一行');
            } else {
              return Text('other' + index.toString());
            }
          },
        ),
      ),
    );
  }

}