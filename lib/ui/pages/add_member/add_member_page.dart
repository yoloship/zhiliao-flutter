
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zhiliao/blocs/friend/bloc.dart';
import 'package:zhiliao/data/repository/friend_repository.dart';
import 'package:zhiliao/ui/widgets/app_bar.dart';

class AddMemberPage extends StatelessWidget{

  final String ledgerId;

  const AddMemberPage({Key key, this.ledgerId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:MyAppBar(
        titleWidget: Text('添加成员'),
      ),
      body: BlocProvider(
        create:(context) =>FriendBloc(),
        child:AddMemberForm(ledgerId: ledgerId,),
      ),
    );
  }
}

class AddMemberForm extends StatelessWidget{
  final _emailController = TextEditingController();
  final String ledgerId;

  AddMemberForm({Key key, this.ledgerId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    _onAddButtonPressed() {
      BlocProvider.of<FriendBloc>(context).add(
        AddMember(email: _emailController.text,ledgerId: ledgerId),
      );
    }

    return BlocBuilder<FriendBloc, FriendState>(
        builder: (context, state) {
          return Form(
            child: Column(
              children: [
                TextFormField(
                  decoration: InputDecoration(labelText: 'email'),
                  controller: _emailController,
                ),

                RaisedButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18),
                  ),
                  color: Colors.lightBlueAccent,
                  onPressed:()=> _onAddButtonPressed(),
                  child: Text('添加',style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
          );
        },
      );
  }
}
