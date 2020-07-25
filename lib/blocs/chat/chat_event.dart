import 'package:equatable/equatable.dart';
import 'package:zhiliao/data/model/message_entity.dart';

abstract class ChatEvent extends Equatable {
  const ChatEvent();
  List<Object> get props => null;
}

class CreateChannel extends ChatEvent{
  final String myEmail;

  CreateChannel({this.myEmail});

}

class FetchMessage extends ChatEvent{
  final String myEmail;
  final String hisEmail;

  FetchMessage({this.myEmail,this.hisEmail});

}


class SendMessage extends ChatEvent{
  final MessageEntity messageEntity;

  SendMessage({this.messageEntity});
}
