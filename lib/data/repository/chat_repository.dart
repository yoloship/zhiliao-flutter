
import 'dart:convert';

import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:web_socket_channel/io.dart';
import 'package:zhiliao/blocs/chat/bloc.dart';
import 'package:zhiliao/common/refresh_controller.dart';
import 'package:zhiliao/data/model/message_entity.dart';
import 'package:zhiliao/db/db_helper.dart';

IOWebSocketChannel channel;

class ChatRepository{


  createChannel(String myEmail,ChatBloc chatBloc) async {

  listenMessage(data) async{
    var map = json.decode(data);
    MessageEntity messageEntity = MessageEntity().fromJson(map);
    String temp= "";
    temp = messageEntity.myEmail;
    messageEntity.myEmail = messageEntity.hisEmail;
    messageEntity.hisEmail = temp;
    messageEntity.isMe = false;
    _saveMessage(messageEntity: messageEntity,chatBloc: chatBloc);
  }

  onError(error){
    print('error------------>${error}');
  }

  void onDone() async {
    print('websocket断开了');
    IOWebSocketChannel channel = IOWebSocketChannel.connect("ws://192.168.249.112:8080/chat/${myEmail}");
    channel.stream.listen((data) => listenMessage(data),onError: onError,onDone: onDone);
    print('websocket重连');
  }

  channel = IOWebSocketChannel.connect("ws://192.168.249.112:8080/chat/${myEmail}");

  channel.stream.listen((data) => listenMessage(data),onError: onError,onDone: onDone);
}

  _saveMessage({MessageEntity messageEntity,ChatBloc chatBloc}) async{
    try {
      var map = messageEntity.toJson();
      if(chatBloc == null) {
        dbHelp.saveMessage(map);
      }else{
        dbHelp.saveMessage(map).then((_){
          refreshController.requestLoading();
        });
      }
    } catch (e) {
      print(e);
    }
  }


  Future<List<MessageEntity>> getMessage(String myEmail,String hisEmail) async{
    var dbClient = await dbHelp.db;
    var result = await dbClient.rawQuery("SELECT * FROM 'Message' WHERE hisEmail='$hisEmail' and myEmail='$myEmail'");
    if (result != null) {
      List list = result.toList();
      List<MessageEntity> messages = list.map((i) => MessageEntity().fromJson(i)).toList();
      return messages;
    }
    return null;
  }

  sendMessage(MessageEntity messageEntity) async{
    String map = jsonEncode(messageEntity.toJson());
    channel.sink.add(map);
    _saveMessage(messageEntity: messageEntity);
  }
}
