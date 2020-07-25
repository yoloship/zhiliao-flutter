
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zhiliao/blocs/friend/bloc.dart';
import 'package:zhiliao/data/model/friend_entity.dart';
import 'package:zhiliao/data/repository/friend_repository.dart';
import 'package:zhiliao/ui/pages/friend/friend_item.dart';
import 'package:zhiliao/ui/widgets/app_bar.dart';
import 'package:zhiliao/ui/widgets/common_cell.dart';

class FriendListPage extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        titleWidget: Text("好友"),
      ),
      body: BlocProvider.value(
          value:BlocProvider.of<FriendBloc>(context)..add(Fetch()),
          child:RefreshIndicator(
              child: FriendList(),

              onRefresh: (){BlocProvider.of<FriendBloc>(context).add(Fetch());})
      ),
    );
  }

}

class FriendList extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FriendBloc,FriendState>(
      builder: (context,state) {
        if (state is FriendLoaded){
          return ListView.builder(
              itemBuilder: (BuildContext context,int index) {
                FriendEntity friendEntity = state.friends[index];
                return FriendItem(friendEntity: friendEntity,);
              },
              itemCount: state.friends.length,);
        }
        if (state is LoadingFriendState) {
          return CircularProgressIndicator();
        }
      },
    );
  }

}
