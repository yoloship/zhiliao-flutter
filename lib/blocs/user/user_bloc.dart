import 'dart:async';

import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';
import 'package:zhiliao/blocs/authentication/bloc.dart';
import 'package:zhiliao/blocs/user/bloc.dart';
import 'package:zhiliao/data/repository/user_repository.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepository userRepository = new UserRepository();
  final AuthenticationBloc authenticationBloc;

  UserBloc({
    @required this.authenticationBloc,
  })  :assert(authenticationBloc != null);

  UserState get initialState => UserInitial();

  @override
  Stream<UserState> mapEventToState(UserEvent event) async* {
    if (event is LoginButtonPressed) {
      yield UserLoading();

      try {
        final token = await userRepository.authenticate(
          email: event.email,
          password: event.password,
        );
        if(token.token != ""){
          authenticationBloc.add(LoggedIn(tokenEntity: token,email: event.email));
          yield UserInitial();
        }else{
          yield UserFailure(error: "账号或密码错误");
        }
      } catch (error) {
        yield UserFailure(error: error.toString());
      }
    }
    if (event is RegisterButtonPressed) {
      yield UserLoading();
      try {
        final token = await userRepository.register(
          username: event.username,
          email: event.email,
          password: event.password,
        );
        if(token.token != ""){
          authenticationBloc.add(LoggedIn(tokenEntity: token,email: event.email));
          yield ReigsterTrue();
        }else{
          yield UserFailure(error: "email已存在");
        }
      } catch (error) {
        yield UserFailure(error: error.toString());
      }
    }
  }
}
