part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class LoggedIn extends AuthEvent {
  final UserResponseModel userData;
  const LoggedIn({required this.userData});
}

class LoggedOut extends AuthEvent {
  final dynamic whenSuccess;
  const LoggedOut({this.whenSuccess});
}

class AppStarted extends AuthEvent {}
