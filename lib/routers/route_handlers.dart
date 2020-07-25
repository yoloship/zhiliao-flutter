
import 'package:fluro/fluro.dart';
import 'package:flutter/cupertino.dart';
import 'package:zhiliao/ui/pages/add_friend/add_friend_page.dart';
import 'package:zhiliao/ui/pages/add_ledger/add_ledger_page.dart';
import 'package:zhiliao/ui/pages/add_member/add_member_page.dart';
import 'package:zhiliao/ui/pages/bill/bill_list_page.dart';
import 'package:zhiliao/ui/pages/add_bill/add_bill_page.dart';
import 'package:zhiliao/ui/pages/chat/chat_page.dart';
import 'package:zhiliao/ui/pages/home/home_page.dart';
import 'package:zhiliao/ui/pages/member/member_page.dart';
import 'package:zhiliao/ui/pages/publish_moment/publish_moment_page.dart';
import 'package:zhiliao/ui/pages/register/register_page.dart';
import 'package:zhiliao/ui/pages/splash_page.dart';
import 'package:zhiliao/ui/pages/login/login_page.dart';

var splashHandler = new Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      return new SplashPage();
    });
var loginHandler = new Handler(
  handlerFunc: (BuildContext context, Map<String, List<String>> params) {
    return LoginPage();
  });
var registerHandler = Handler(
    handlerFunc: (BuildContext context, Map<String,List<String>> params){
      return RegisterPage();
    }
);
/// 跳转到主页
var homeHandler = new Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      return HomePage();
    });
var simpleRecordHandler = new Handler(
    handlerFunc: (BuildContext context, Map<String,List<String>> params){
      return AddBillPage();
    });
var addFriendHandler = new Handler(
  handlerFunc: (BuildContext context, Map<String,List<String>> params){
    return AddFriendPage();
  });
var billListHandler = new Handler(
    handlerFunc: (BuildContext context, Map<String,dynamic> params){
      return BillListPage(ledgerId: params['ledgerId'][0]);
    });
var chatHandler = Handler(
  handlerFunc: (BuildContext context, Map<String,List<String>> params){
    return ChatPage(hisEmail : params["hisEmail"][0]);
}
);
var addLedgerHandler = Handler(
    handlerFunc: (BuildContext context, Map<String,List<String>> params){
      return AddLedgerPage();
    }
);
var publishMomentHandler = Handler(
    handlerFunc: (BuildContext context, Map<String,List<String>> params){
      return PublishMomentPage(billId: params["billId"][0],);
    }
);
var memberListHandler = Handler(
    handlerFunc: (BuildContext context, Map<String,List<String>> params){
      return MemberListPage(ledgerId: params["ledgerId"][0],);
    }
);
var addMemberHandler = Handler(
    handlerFunc: (BuildContext context, Map<String,List<String>> params){
      return AddMemberPage(ledgerId: params["ledgerId"][0],);
    }
);

