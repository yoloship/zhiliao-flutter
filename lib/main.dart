

import 'dart:io';

import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:zhiliao/blocs/authentication/authentication_bloc.dart';
import 'package:zhiliao/blocs/authentication/bloc.dart';
import 'package:zhiliao/blocs/chat/bloc.dart';
import 'package:zhiliao/blocs/friend/bloc.dart';
import 'package:zhiliao/data/repository/friend_repository.dart';
import 'package:zhiliao/data/repository/user_repository.dart';
import 'package:zhiliao/routers/application.dart';
import 'package:zhiliao/routers/routes.dart';
import 'package:zhiliao/ui/pages/home/home_page.dart';
import 'package:zhiliao/ui/pages/login/login_page.dart';
import 'package:zhiliao/ui/pages/splash_page.dart';
import 'package:zhiliao/ui/widgets/loading_Indicator.dart';


void main() {
  Provider.debugCheckInvalidValueType = null;
  Router router = Router();
  Routes.configureRoutes(router);
  Application.router = router;
  final userRepository = UserRepository();
  runApp(
    MultiBlocProvider(
        providers: [
          BlocProvider<AuthenticationBloc>(
              create: (context) {
                return AuthenticationBloc(userRepository: userRepository)
                  ..add(AppStarted());
              }
          ),

        ],
        child: ZhiLiao(userRepository: userRepository))
  );


  if(Platform.isAndroid){
    SystemUiOverlayStyle systemUiOverlayStyle = SystemUiOverlayStyle(statusBarColor: Colors.transparent);
    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
  }

}

class ZhiLiao extends StatelessWidget {

  final UserRepository userRepository;

  const ZhiLiao({Key key, this.userRepository}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: "支了",
      home: BlocBuilder<AuthenticationBloc,AuthenticationState>(
        builder: (context, state) {
          if (state is AuthenticationUninitialized) {
            return SplashPage();
          }
          if (state is AuthenticationAuthenticated) {
            return MultiBlocProvider(
                providers: [
                  BlocProvider<ChatBloc>(
                    create: (context){
                      return ChatBloc()..add(CreateChannel(myEmail: state.email));
                    },
                  ),
                  BlocProvider<FriendBloc>(
                    create: (context){
                      return FriendBloc();
                    }
                  ),
                ],
                child: HomePage());
          }

          if (state is AuthenticationUnauthenticated) {
              return LoginPage();
          }

          if (state is AuthenticationLoading) {
            return LoadingIndicator();
          }
        }
      ),
      onGenerateRoute: Application.router.generator
    );
  }
}
