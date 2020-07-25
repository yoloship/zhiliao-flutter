
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zhiliao/blocs/moment/bloc.dart';
import 'package:zhiliao/data/model/moment_entity.dart';
import 'package:zhiliao/ui/pages/moment/momenty_item.dart';
import 'package:zhiliao/ui/widgets/app_bar.dart';

class MomentPage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        titleWidget: Text("动态"),
      ),
      body: BlocProvider(
          create:(BuildContext context) => MomentBloc()..add(FetchMoment()),
          child:RefreshIndicator(
              child: MomentList(),
              onRefresh: (){})
      ),
    );
  }

}

class MomentList extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MomentBloc,MomentState>(
      builder: (context,state) {
        if (state is MomentLoadedState){
          return ListView.builder(
            itemBuilder: (BuildContext context,int index) {
              MomentEntity momentEntity = state.moments[index];
              return MomentItem(momentEntity: momentEntity,);
            },
            itemCount: state.moments.length,);
        }
        if (state is MomentLoadingState) {
          return CircularProgressIndicator();
        }
      },
    );
  }

}
