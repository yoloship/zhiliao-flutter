import 'package:equatable/equatable.dart';

abstract class FriendEvent extends Equatable {
  const FriendEvent();

  @override
  List<Object> get props => null;
}

class Fetch extends FriendEvent {
}

class AddButtonPressed extends FriendEvent{
  final String email;

  AddButtonPressed(this.email);

}

class FetchMember extends FriendEvent {
  final String ledgerId;

  FetchMember({this.ledgerId});

}

class AddMember extends FriendEvent{
  final String email;
  final String ledgerId;

  AddMember({this.email, this.ledgerId});
}

