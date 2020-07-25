import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import 'package:zhiliao/data/model/token_entity.dart';

abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object> get props => [];
}

class AppStarted extends AuthenticationEvent {}

class LoggedIn extends AuthenticationEvent {
  final TokenEntity tokenEntity;
  final String email;

  const LoggedIn({@required this.tokenEntity,this.email});

  @override
  List<Object> get props => [tokenEntity];

  @override
  String toString() => 'LoggedIn { token: $tokenEntity }';
}

class LoggedOut extends AuthenticationEvent {}
