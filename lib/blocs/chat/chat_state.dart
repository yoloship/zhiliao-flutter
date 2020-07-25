import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:zhiliao/data/model/friend_entity.dart';
import 'package:zhiliao/data/model/message_entity.dart';

abstract class ChatState extends Equatable {
  const ChatState();
  List<Object> get props => null;
}

class InitialChatState extends ChatState {
}

class ChatLoaded extends ChatState{
  final List<MessageEntity> messageEntitys;
  final ScrollController scrollController = ScrollController();

  ChatLoaded({this.messageEntitys});

}

class LoadingChatState extends ChatState{}

