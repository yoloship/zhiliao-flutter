import 'package:equatable/equatable.dart';
import 'package:zhiliao/data/model/friend_entity.dart';

abstract class FriendState extends Equatable {
  const FriendState();
  @override
  List<Object> get props => [];
}

class InitialFriendState extends FriendState {}

class FriendError extends FriendState{}

class FriendLoaded extends FriendState{
  final List<FriendEntity> friends;

  const FriendLoaded({this.friends});

  List<Object> get props => [friends];
}

class LoadingFriendState extends FriendState{}
