
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zhiliao/blocs/authentication/bloc.dart';
import 'package:zhiliao/data/model/token_entity.dart';
import 'package:zhiliao/ui/widgets/app_bar.dart';

import 'me_cell.dart';

class MinePage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: MyAppBar(
        titleWidget: Text("我的"),
      ),
      body: BlocProvider.value(
          value:BlocProvider.of<AuthenticationBloc>(context),
          child:Mine(),
      )
    );
  }
}

class Mine extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
          if (state is AuthenticationAuthenticated) {
            TokenEntity tokenEntity = state.tokenEntity;
            return Column(
              children: <Widget>[

                Container(
                  color: Colors.blue,
                  height: 200.0,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          width: 60.0,
                          height: 60.0,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.transparent,
                            image: DecorationImage(
                                image: NetworkImage(tokenEntity.avatarUrl),
                                fit: BoxFit.cover),
                            border: Border.all(
                              color: Colors.white,
                              width: 2.0,
                            ),
                          ),
                        ),
                        Text(
                          tokenEntity.username,
                          style: TextStyle(color: Colors.white, fontSize: 16.0),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 10),
                buildCells(context),
              ],
            );

          }
        }
    );
  }

  Widget buildCells(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[

          SizedBox(height: 24.0),
          MeCell(
            title: '退出登录',
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              BlocProvider.of<AuthenticationBloc>(context).add(LoggedOut());

            },
          ),
        ],
      ),
    );
  }

}
