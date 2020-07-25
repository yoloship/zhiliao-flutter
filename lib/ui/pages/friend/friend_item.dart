
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:zhiliao/data/model/friend_entity.dart';
import 'package:zhiliao/routers/navigator_util.dart';
import 'package:zhiliao/routers/routes.dart';

class FriendItem extends StatelessWidget{

  final FriendEntity friendEntity;

  const FriendItem({Key key, this.friendEntity}) : super(key: key);




  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          border:
          Border(bottom: BorderSide(width: 0.5, color: Color(0xffd9d9d9)))),
      height: 52.0,
      child: FlatButton(
        onPressed: () {
          NavigatorUtil.push(context, "${Routes.chat}?hisEmail=${friendEntity.email}");

        },
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Image.network(friendEntity.avatarUrl, width: 36.0, height: 36.0, scale: 0.9),
            Container(
              margin: const EdgeInsets.only(left: 12.0),
              child: Text(
                friendEntity.username,
                style: TextStyle(fontSize: 18.0, color: Color(0xff353535)),
                maxLines: 1,
              ),
            ),
          ],
        ),
      ),
    );
  }

}
