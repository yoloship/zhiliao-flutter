
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zhiliao/blocs/chat/bloc.dart';
import 'package:zhiliao/data/repository/user_repository.dart';
import 'package:zhiliao/routers/navigator_util.dart';
import 'package:zhiliao/routers/routes.dart';
import 'package:zhiliao/ui/pages/friend/friend_list_page.dart';
import 'package:zhiliao/ui/pages/ledger/ledger_list_page.dart';
import 'package:zhiliao/ui/pages/login/login_page.dart';
import 'package:zhiliao/ui/pages/mine/mine_page.dart';
import 'package:zhiliao/ui/pages/moment/moment_page.dart';

class HomePage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => HomePageState();
}

class HomePageState extends State{

  int _currentIndex = 0;
  final UserRepository userRepository = UserRepository();

  final _pageController = PageController();

  final _pages = [ FriendListPage(), LedgerListPage(), MomentPage(), MinePage()];


  void chooseRecordMode(BuildContext context){
      showDialog(
        context: context,
        builder: (BuildContext context){
          return SimpleDialog(
            title : Text("选择记账模式"),
            children: <Widget>[
              SimpleDialogOption(
                child : Text("添加账单"),
                onPressed: () {
                  NavigatorUtil.goBack(context);
                  NavigatorUtil.push(context, Routes.simpleRecord);
                  },
              ),
              SimpleDialogOption(
                child: Text("添加账本"),
                onPressed: (){
                  NavigatorUtil.goBack(context);
                  NavigatorUtil.push(context, Routes.addLedger);
                },
              ),
              SimpleDialogOption(
                child: Text("添加好友"),
                onPressed: (){
                  NavigatorUtil.goBack(context);
                  NavigatorUtil.push(context, Routes.addFriend);
                },
              )
            ],
          );
        }
      );
  }


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return BlocBuilder<ChatBloc,ChatState>(
        builder: (context,state){
          return Scaffold(
            floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
            floatingActionButton: FloatingActionButton(
              child: const Icon(Icons.add),
              onPressed: () => chooseRecordMode(context),
            ),
            bottomNavigationBar: BottomAppBar(
              shape: CircularNotchedRectangle(),
              notchMargin: 10.0,
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  IconButton(
                      icon: Icon(Icons.people),
                      onPressed: () {
                        onTap(0);
                      }),
                  IconButton(
                      icon: Icon(Icons.description),
                      onPressed: () {
                        onTap(1);
                      }),
                  IconButton(
                      icon: Icon(Icons.camera),
                      onPressed: () {
                        onTap(2);
                      }),
                  IconButton(
                      icon: Icon(Icons.perm_identity),
                      onPressed: () {
                        onTap(3);
                      })
                ],
              ),
            ),
            body: PageView(
              controller: _pageController,
              onPageChanged: _onPageChanged,
              children: _pages,
              physics: defaultTargetPlatform == TargetPlatform.iOS
                  ? NeverScrollableScrollPhysics()
                  : AlwaysScrollableScrollPhysics(), // 禁止滑动
            ),
          );
        }
    );
  }

  void onTap(int index) {
    if (index != _currentIndex) {
      _pageController.jumpToPage(index);
    }
  }

  void _onPageChanged(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

}
