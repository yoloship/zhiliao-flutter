import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:zhiliao/blocs/authentication/authentication_bloc.dart';
import 'package:zhiliao/blocs/authentication/bloc.dart';
import 'package:zhiliao/blocs/user/bloc.dart';
import 'package:zhiliao/data/repository/user_repository.dart';
import 'package:zhiliao/routers/navigator_util.dart';
import 'package:zhiliao/routers/routes.dart';


class LoginPage extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
            backgroundColor: Colors.white,
            appBar: new AppBar(
              backgroundColor: Colors.white,
              elevation: 0,
              title: const Text(
                '',
                style: TextStyle(color: Colors.black),
              ),
              centerTitle: false,
            ),
            body: Provider(
              create:(context) => UserBloc(
                authenticationBloc: BlocProvider.of<AuthenticationBloc>(context)
              ),
              child: LoginForm(),
            )
            );
  }
}

class LoginForm extends StatelessWidget{

  TextEditingController _emailController = TextEditingController(text:"");
  TextEditingController _passwordController = TextEditingController(text:"");

  @override
  Widget build(BuildContext context) {

    _onLoginButtonPressed() {
      BlocProvider.of<UserBloc>(context).add(
        LoginButtonPressed(
          email: _emailController.text,
          password: _passwordController.text,
        ),
      );
    }

    Widget email = TextFormField(
      keyboardType: TextInputType.emailAddress,
      controller: _emailController,
      autofocus: false,
      decoration: InputDecoration(
          hintText: '邮箱',
          contentPadding: EdgeInsets.fromLTRB(10.0, 2.0, 10.0, 10.0),
          border: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.black26)),
          focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.black))),
    );

    Widget password = TextFormField(
      autofocus: false,
      controller: _passwordController,
      obscureText: true,
      decoration: InputDecoration(
          hintText: '密码',
          contentPadding: EdgeInsets.fromLTRB(10.0, 2.0, 10.0, 10.0),
          border: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.black26)),
          focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.black))),
    );
    Widget register = FlatButton(
      child: Text(
        '注册',
        style: TextStyle(color: Colors.black54),
      ),
      onPressed: () {
        NavigatorUtil.push(context,Routes.register);
      },
    );

    return BlocListener<UserBloc, UserState>(
      listener: (context, state) {
        if (state is UserFailure) {
          Scaffold.of(context).showSnackBar(
            SnackBar(
              content: Text('${state.error}'),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      child: BlocBuilder<UserBloc, UserState>(
        builder: (context, state) {
          return Center(
            child: ListView(
              padding: EdgeInsets.only(left: 24.0, right: 24.0, top: 20.0),
              children: <Widget>[
                new Text(
                  "支了",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 50.0,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 48.0),
                email,
                SizedBox(height: 28.0),
                password,
                SizedBox(height: 24.0),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 16.0),
                  child: RaisedButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                    onPressed: () {
                      state is! UserLoading ? _onLoginButtonPressed() : null;
                    },
                    padding: EdgeInsets.all(12),
                    color: Colors.lightBlueAccent,
                    child: Text('登录', style: TextStyle(color: Colors.white)),
                  ),
                ),
                Container(
                  child: state is UserLoading
                      ? CircularProgressIndicator()
                      : null,
                ),
                register
              ],
            ),
          );
        },
      ),
    );
  }

}
