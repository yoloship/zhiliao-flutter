import 'package:flutter/material.dart';

class MeCell extends StatelessWidget {
  final VoidCallback onPressed;
  final Icon icon;
  final String title;

  MeCell({this.title, this.icon, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        color: Colors.white,
        child: Column(
          children: <Widget>[
            Container(
              color: Colors.white,
              height: 50,
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: <Widget>[
                  icon,
                  SizedBox(width: 20),
                  Text(title, style: TextStyle(fontSize: 18)),
                  Expanded(child: Container()),
                  Image.asset('img/arrow_right.png'),
                ],
              ),
            ),
            Container(
              height: 1,
              color: Colors.grey,
              margin: EdgeInsets.only(left: 60),
            ),
          ],
        ),
      ),
    );
  }
}
