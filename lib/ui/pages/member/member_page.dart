import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zhiliao/blocs/friend/friend_bloc.dart';
import 'package:zhiliao/blocs/friend/friend_event.dart';
import 'package:zhiliao/blocs/friend/friend_state.dart';
import 'package:zhiliao/data/model/friend_entity.dart';
import 'package:zhiliao/data/repository/friend_repository.dart';
import 'package:zhiliao/routers/navigator_util.dart';
import 'package:zhiliao/routers/routes.dart';
import 'package:zhiliao/ui/pages/friend/friend_item.dart';
import 'package:zhiliao/ui/widgets/app_bar.dart';

class MemberListPage extends StatelessWidget{

  final String ledgerId;

  const MemberListPage({Key key, this.ledgerId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        titleWidget: Text("成员"),
      ),
      body: BlocProvider(
          create:(BuildContext context)=>FriendBloc()..add(FetchMember(ledgerId: ledgerId)),
          child:RefreshIndicator(
              child: MemberList(ledgerId: ledgerId,),
              onRefresh: (){BlocProvider.of<FriendBloc>(context).add(FetchMember(ledgerId: ledgerId));})
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: ()=>{
          NavigatorUtil.push(context, "${Routes.addMember}?ledgerId=$ledgerId")
        },
      ),
    );
  }

}

class MemberList extends StatelessWidget{
  final String ledgerId;

  const MemberList({Key key, this.ledgerId}) : super(key: key);
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
