
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zhiliao/blocs/ledger/bloc.dart';
import 'package:zhiliao/data/model/ledger_entity.dart';
import 'package:zhiliao/routers/navigator_util.dart';
import 'package:zhiliao/routers/routes.dart';
import 'package:zhiliao/ui/widgets/app_bar.dart';
import 'package:zhiliao/ui/widgets/common_cell.dart';

class LedgerListPage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        titleWidget: Text("账本"),
      ),
      body: BlocProvider(
        create:(context) => LedgerBloc()..add(Fetch("aa")),
        child:LedgerList(),
      ),
    );
  }

}

class LedgerList extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LedgerBloc,LedgerState>(
      builder: (context,state) {
        if (state is LedgerLoaded){
          List<Widget> ledgerList = List();
          List<LedgerEntity> ledgers = state.ledgers;
          for(var ledger in  ledgers){
            ledgerList.add(
                CommonCell(
                  title: ledger.name,
                  subtitle: ledger.role,
                  onPressed:(){ NavigatorUtil.push(context,"${Routes.billList}?ledgerId=${ledger.ledgerId}&ledgerBloc=${BlocProvider.of<LedgerBloc>(context)}");},
                )
            );
          }
          return Column(
              children: ledgerList
          );
        }
        if (state is LoadingLedgerState) {
          return CircularProgressIndicator();
        }
      },
    );
  }

}
