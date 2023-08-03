part of 'authentication_bloc.dart';

@immutable
sealed class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();
}

final class SignInAuthEvent extends AuthenticationEvent {
  final SignInAuthenticationRequest authenticationRequest;
  const SignInAuthEvent({required this.authenticationRequest});

  @override
  List<Object?> get props => [authenticationRequest];
}

final class SignUpAuthEvent extends AuthenticationEvent {
  final SignUpAuthenticationRequest authenticationRequest;
  const SignUpAuthEvent({required this.authenticationRequest});

  @override
  List<Object?> get props => [authenticationRequest];
}

final class SignUpWithGoogleEvent extends AuthenticationEvent {
  const SignUpWithGoogleEvent();

  @override
  List<Object?> get props => [];
}

final class ForgotPasswrodEvent extends AuthenticationEvent {
  final String email;
  const ForgotPasswrodEvent({required this.email});

  @override
  List<Object> get props => [email];
}

final class StoreUserEvent extends AuthenticationEvent {
  final StoreUserRequest storeUserRequest;
  const StoreUserEvent({required this.storeUserRequest});

  @override
  List<Object?> get props => [storeUserRequest];
}

final class ValidateEmailEvent extends AuthenticationEvent {
  final String email;
  const ValidateEmailEvent({required this.email});
  @override
  List<Object?> get props => [email];
}

final class ValidateEmailSignInEvent extends AuthenticationEvent {
  final String email;
  const ValidateEmailSignInEvent({required this.email});
  @override
  List<Object?> get props => [email];
}

final class ValidatePasswordSignInEvent extends AuthenticationEvent {
  final String password;
  const ValidatePasswordSignInEvent({required this.password});
  @override
  List<Object?> get props => [password];
}

final class ValidateNameEvent extends AuthenticationEvent {
  final String name;
  const ValidateNameEvent({required this.name});
  @override
  List<Object?> get props => [name];
}

final class ValidatePasswordEvent extends AuthenticationEvent {
  final String password;
  const ValidatePasswordEvent({required this.password});
  @override
  List<Object?> get props => [password];
}

final class ValidateEmailForgotPasswordEvent extends AuthenticationEvent {
  final String email;
  const ValidateEmailForgotPasswordEvent({required this.email});
  @override
  List<Object?> get props => [email];
}

final class FetchUserEvent extends AuthenticationEvent {
  const FetchUserEvent();

  @override
  List<Object?> get props => [];
}
