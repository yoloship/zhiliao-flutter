import 'package:equatable/equatable.dart';
import 'package:zhiliao/data/model/token_entity.dart';

abstract class AuthenticationState extends Equatable {
  @override
  List<Object> get props => [];
}

class AuthenticationUninitialized extends AuthenticationState {}

class AuthenticationAuthenticated extends AuthenticationState {
  final String email;
  final TokenEntity tokenEntity;

  AuthenticationAuthenticated({this.email,this.tokenEntity});
}

class AuthenticationUnauthenticated extends AuthenticationState {}

class AuthenticationLoading extends AuthenticationState {}
