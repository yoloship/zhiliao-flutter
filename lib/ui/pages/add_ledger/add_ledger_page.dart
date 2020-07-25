
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zhiliao/blocs/ledger/bloc.dart';
import 'package:zhiliao/ui/widgets/app_bar.dart';

class AddLedgerPage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: MyAppBar(
        titleWidget: Text("添加账本"),
      ),
      body: BlocProvider(
        create: (context) => LedgerBloc(),
        child: AddLedgerForm(),
      ),
    );
  }

}

class AddLedgerForm extends StatelessWidget{

  TextEditingController ledgerNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    _onAddButtonPressed() {
      BlocProvider.of<LedgerBloc>(context).add(
        AddButtonPressed( ledgerName: ledgerNameController.text)
      );
    }
    // TODO: implement build
    return BlocBuilder<LedgerBloc,LedgerState>(
        builder: (context,state){
          return Column(
            children: <Widget>[
              TextField(
                controller: ledgerNameController,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(10.0),
                  labelText: "请输入账本名"
                ),
              ),
              RaisedButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18),
                ),
                color: Colors.lightBlueAccent,
                onPressed: ()=> _onAddButtonPressed(),
                child: Text('添加',style: TextStyle(color: Colors.white)),
              ),
            ],
          );
        }
    );
  }

}
