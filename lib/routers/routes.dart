import 'package:fluro/fluro.dart';
import 'package:flutter/cupertino.dart';
import 'package:zhiliao/routers/route_handlers.dart';

class Routes {
  static String root = "/";
  static String login = "/login";
  static String register = "/register";
  static String home = "/home";
  static String simpleRecord="/simpleRecord";
  static String billList="/billList";
  static String addFriend="/addFriend";
  static String chat = "/chat";
  static String addLedger = "/addLedger";
  static String publishMoment = "/publishMoment";
  static String memberList = "/memberList";
  static String addMember = "/addMember";

  static void configureRoutes(Router router) {

    router.notFoundHandler = new Handler(
        handlerFunc: (BuildContext context, Map<String, List<String>> params) {
          print("ROUTE WAS NOT FOUND !!!");
        });
    /// 第一个参数是路由地址，第二个参数是页面跳转和传参，第三个参数是默认的转场动画，可以看上图
    /// 我这边先不设置默认的转场动画，转场动画在下面会讲，可以在另外一个地方设置（可以看NavigatorUtil类）
    router.define(root, handler: splashHandler);
    router.define(login, handler: null);
    router.define(home, handler: homeHandler);
    router.define(simpleRecord, handler: simpleRecordHandler);
    router.define(addFriend, handler: addFriendHandler);
    router.define(billList, handler: billListHandler);
    router.define(chat, handler: chatHandler);
    router.define(addLedger, handler: addLedgerHandler);
    router.define(register, handler: registerHandler);
    router.define(publishMoment, handler: publishMomentHandler);
    router.define(memberList, handler: memberListHandler);
    router.define(addMember, handler: addMemberHandler);
  }
}
