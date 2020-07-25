import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:zhiliao/data/model/friend_entity.dart';
import 'package:zhiliao/data/repository/friend_repository.dart';
import './bloc.dart';

class FriendBloc extends Bloc<FriendEvent, FriendState> {

  final FriendRepository friendRepository = new FriendRepository();


  @override
  FriendState get initialState => LoadingFriendState();

  @override
  Stream<FriendState> mapEventToState(
    FriendEvent event,
  ) async* {
    if (event is Fetch) {
      yield LoadingFriendState();
      List<FriendEntity> friends = await friendRepository.getFriendList();
      yield FriendLoaded(friends: friends);
    }
    if (event is AddButtonPressed){
      yield LoadingFriendState();
      friendRepository.addFriend(event.email);
    }
    if (event is FetchMember) {
      yield LoadingFriendState();
      List<FriendEntity> members = await friendRepository.getMemberList(event.ledgerId);
      yield FriendLoaded(friends: members);
    }
    if (event is AddMember) {
      yield LoadingFriendState();
      friendRepository.addMember(event.email,event.ledgerId);
    }
  }

}
