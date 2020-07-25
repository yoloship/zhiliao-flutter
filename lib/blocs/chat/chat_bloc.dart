import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:web_socket_channel/io.dart';
import 'package:zhiliao/data/model/message_entity.dart';
import 'package:zhiliao/data/repository/chat_repository.dart';
import './bloc.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {

  final ChatRepository chatRepository = ChatRepository();


  @override
  ChatState get initialState => LoadingChatState();

  @override
  Stream<ChatState> mapEventToState(
    ChatEvent event,
  ) async* {
    if( event is CreateChannel) {
      chatRepository.createChannel(event.myEmail,this);
    }
    if( event is FetchMessage) {
      yield LoadingChatState();
      try {
        List<MessageEntity> messageEntitys = await chatRepository.getMessage(event.myEmail,event.hisEmail);
        yield ChatLoaded(messageEntitys: messageEntitys);
      } catch (e) {
        List<MessageEntity> messageEntitys= List();
        yield ChatLoaded(messageEntitys: messageEntitys);
      }
    }
    if( event is SendMessage) {
      chatRepository.sendMessage(event.messageEntity);
      this.add(FetchMessage(myEmail:event.messageEntity.myEmail,hisEmail: event.messageEntity.hisEmail));
    }
  }






}
