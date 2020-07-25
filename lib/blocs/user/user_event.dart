import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();
  List<Object> get props => null;
}

class LoginButtonPressed extends UserEvent {
  final String email;
  final String password;

  const LoginButtonPressed({
    @required this.email,
    @required this.password,
  });

  @override
  List<Object> get props => [email, password];

  @override
  String toString() =>
      'LoginButtonPressed { email: $email, password: $password }';
}

class RegisterButtonPressed extends UserEvent{
  final String username;
  final String email;
  final String password;

  RegisterButtonPressed({this.username, this.email, this.password});

}
