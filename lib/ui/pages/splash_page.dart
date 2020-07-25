import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:zhiliao/data/repository/user_repository.dart';

class SplashPage extends StatelessWidget {
  final UserRepository userRepository = UserRepository();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
          child: Container(
            child: Text('我是欢迎页面'),
          ),
        )
    );
  }

}
