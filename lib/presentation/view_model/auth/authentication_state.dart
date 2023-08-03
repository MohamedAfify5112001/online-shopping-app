part of 'authentication_bloc.dart';

@immutable
abstract class AuthenticationState extends Equatable {
  const AuthenticationState();

  @override
  List<Object> get props => [];
}

class AuthenticationInitial extends AuthenticationState {
  const AuthenticationInitial();
}

// Sign Up States
class SignUpLoadingState extends AuthenticationState {
  const SignUpLoadingState();
}

class SignUpSuccessState extends AuthenticationState {
  const SignUpSuccessState();
}

class SignUpFailureState extends AuthenticationState {
  final SignUpWithEmailAndPasswordFailure signUpWithEmailAndPasswordFailure;

  const SignUpFailureState({required this.signUpWithEmailAndPasswordFailure});
}

// Sign Up Google States
class SignUpWithGoogleLoadingState extends AuthenticationState {
  const SignUpWithGoogleLoadingState();
}

class SignUpWithGoogleSuccessState extends AuthenticationState {
  const SignUpWithGoogleSuccessState();
}

class SignUpWithGoogleFailureState extends AuthenticationState {
  final SignUpWithGoogleFailure signUpWithGoogleFailure;

  const SignUpWithGoogleFailureState({required this.signUpWithGoogleFailure});
}

// Sign In States
class SignInLoadingState extends AuthenticationState {
  const SignInLoadingState();
}

class SignInSuccessState extends AuthenticationState {
  final String uId;

  const SignInSuccessState({required this.uId});
}

class SignInFailureState extends AuthenticationState {
  final LogInWithEmailAndPasswordFailure logInWithEmailAndPasswordFailure;

  const SignInFailureState({required this.logInWithEmailAndPasswordFailure});
}

class ForgotPasswordLoadingState extends AuthenticationState {
  const ForgotPasswordLoadingState();
}

class ForgotPasswordSuccessState extends AuthenticationState {
  const ForgotPasswordSuccessState();
}

class ForgotPasswordFailureState extends AuthenticationState {
  final String error;

  const ForgotPasswordFailureState({required this.error});
}

// Store User  States

class StoreUserLoadingState extends AuthenticationState {
  const StoreUserLoadingState();
}

class StoreUserSuccessState extends AuthenticationState {
  const StoreUserSuccessState();
}

class StoreUserFailureState extends AuthenticationState {
  const StoreUserFailureState();
}

class InitialValidEmailState extends AuthenticationState {
  const InitialValidEmailState();
}

class ValidEmailState extends AuthenticationState {
  const ValidEmailState();
}

class NotValidEmailState extends AuthenticationState {
  const NotValidEmailState();
}

class InitialValidNameState extends AuthenticationState {
  const InitialValidNameState();
}

class ValidNameState extends AuthenticationState {
  const ValidNameState();
}

class NotValidNameState extends AuthenticationState {
  const NotValidNameState();
}

class InitialValidPasswordState extends AuthenticationState {
  const InitialValidPasswordState();
}

class ValidPasswordState extends AuthenticationState {
  const ValidPasswordState();
}

class NotValidPasswordState extends AuthenticationState {
  const NotValidPasswordState();
}

class InitialValidSignInEmailState extends AuthenticationState {
  const InitialValidSignInEmailState();
}

class ValidSignInEmailState extends AuthenticationState {
  const ValidSignInEmailState();
}

class NotValidSignInEmailState extends AuthenticationState {
  const NotValidSignInEmailState();
}

class InitialValidPasswordSignInState extends AuthenticationState {
  const InitialValidPasswordSignInState();
}

class ValidPasswordSignInState extends AuthenticationState {
  const ValidPasswordSignInState();
}

class NotValidPasswordSignInState extends AuthenticationState {
  const NotValidPasswordSignInState();
}

class InitialValidForgotPasswordEmailState extends AuthenticationState {
  const InitialValidForgotPasswordEmailState();
}

class ValidForgotPasswordEmailState extends AuthenticationState {
  const ValidForgotPasswordEmailState();
}

class NotValidForgotPasswordEmailState extends AuthenticationState {
  const NotValidForgotPasswordEmailState();
}

class GetUserLoadingState extends AuthenticationState {
  const GetUserLoadingState();
}

class GetUserSuccessState extends AuthenticationState {
  final UserModel user;

  const GetUserSuccessState(this.user);
}

class GetUserFailureState extends AuthenticationState {
  const GetUserFailureState();
}
