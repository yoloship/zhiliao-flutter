
import 'dart:convert';

import 'package:zhiliao/data/model/friend_entity.dart';
import 'package:zhiliao/util/http_util.dart';

class FriendRepository{
  Future<List<FriendEntity>> getFriendList() async {
    var result = await httpUtil.get("/friend");
    List list = json.decode(result) as List;
    List<FriendEntity> friends = list.map((i) => FriendEntity().fromJson(i)).toList();
    return friends;

  }

  Future<bool> addFriend(String email) async{
    httpUtil.post("/friend",data: {"email":"${email}"});

  }

  Future<List<FriendEntity>> getMemberList(String ledgerId) async{
    var result = await httpUtil.get("/friend/$ledgerId");
    List list = json.decode(result) as List;
    List<FriendEntity> friends = list.map((i) => FriendEntity().fromJson(i)).toList();
    return friends;
  }

  Future<bool> addMember(String email, String ledgerId) async{
    bool result = await httpUtil.post("/member",data: {"email":email,"ledgerId":ledgerId});
    return result;
  }

}
