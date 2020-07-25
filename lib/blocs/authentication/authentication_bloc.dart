


import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:zhiliao/blocs/authentication/authentication_event.dart';
import 'package:zhiliao/blocs/authentication/authentication_state.dart';
import 'package:zhiliao/data/repository/user_repository.dart';
import 'package:zhiliao/util/http_util.dart';

  class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {


  final UserRepository userRepository;

  AuthenticationBloc({@required this.userRepository})
      : assert(userRepository != null);


  @override
  AuthenticationState get initialState => AuthenticationUninitialized();

  @override
  Stream<AuthenticationState> mapEventToState(
      AuthenticationEvent event,
      ) async* {
    if (event is AppStarted) {
      final bool hasToken = await userRepository.hasToken();

      if (hasToken) {
        yield AuthenticationAuthenticated();
      } else {
        yield AuthenticationUnauthenticated();
      }
    }

    if (event is LoggedIn) {
      yield AuthenticationLoading();
      await userRepository.persistToken(event.tokenEntity.token);

      yield AuthenticationAuthenticated(email: event.email,tokenEntity: event.tokenEntity);
    }

    if (event is LoggedOut) {
      yield AuthenticationLoading();
      await userRepository.deleteToken();
      yield AuthenticationUnauthenticated();
    }
  }
}
