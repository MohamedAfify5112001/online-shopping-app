import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:online_shopping/data/network/requests.dart';
import 'package:online_shopping/model/user.dart';
import 'package:online_shopping/token/extensions.dart';
import 'package:stream_transform/stream_transform.dart';

import '../../../data/cache/caching_comp.dart';
import '../../../domain/auth-repo/auth_repo.dart';
import '../../../model/failure.dart';

part 'authentication_event.dart';

part 'authentication_state.dart';

const _duration = Duration(milliseconds: 600);

EventTransformer<Event> debounce<Event>(Duration duration) {
  return (events, mapper) => events.debounce(duration).switchMap(mapper);
}

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final AuthenticationRepository authenticationRepository;
  String uId = '';

  AuthenticationBloc({required this.authenticationRepository})
      : super(const AuthenticationInitial()) {
    on<SignUpAuthEvent>(_onSignUp);
    on<SignUpWithGoogleEvent>(_onSignUpWithGoogle);
    on<SignInAuthEvent>(_onSignIn);
    on<ForgotPasswrodEvent>(_onForgotPassword);
    on<StoreUserEvent>(_onStoreUser);
    on<ValidateEmailEvent>(_onValidEmail, transformer: debounce(_duration));
    on<ValidateNameEvent>(_onValidName, transformer: debounce(_duration));
    on<ValidateEmailSignInEvent>(_onValidEmailSign,
        transformer: debounce(_duration));
    on<ValidateEmailForgotPasswordEvent>(_onValidEmailForgotPassword,
        transformer: debounce(_duration));
    on<ValidatePasswordEvent>(_onValidPassword,
        transformer: debounce(_duration));
    on<ValidatePasswordSignInEvent>(_onValidPasswordSignIn,
        transformer: debounce(_duration));
    on<FetchUserEvent>(_onFetchUser);
  }

  Future<void> _onValidEmail(ValidateEmailEvent validateEmailEvent,
      Emitter<AuthenticationState> emit) async {
    if (validateEmailEvent.email.isEmpty) {
      emit(const InitialValidEmailState());
    }
    if (validateEmailEvent.email.isValidEmail()) {
      emit(const ValidEmailState());
    } else {
      if (validateEmailEvent.email.isNotEmpty) {
        emit(const NotValidEmailState());
      }
    }
  }

  Future<void> _onValidEmailSign(
      ValidateEmailSignInEvent validateEmailSignInEvent,
      Emitter<AuthenticationState> emit) async {
    if (validateEmailSignInEvent.email.isEmpty) {
      emit(const InitialValidSignInEmailState());
    }
    if (validateEmailSignInEvent.email.isValidEmail()) {
      emit(const ValidSignInEmailState());
    } else {
      if (validateEmailSignInEvent.email.isNotEmpty) {
        emit(const NotValidSignInEmailState());
      }
    }
  }

  Future<void> _onValidName(ValidateNameEvent validateNameEvent,
      Emitter<AuthenticationState> emit) async {
    if (validateNameEvent.name.isEmpty) {
      emit(const InitialValidNameState());
    }
    if (validateNameEvent.name.isValidName()) {
      emit(const ValidNameState());
    } else {
      if (validateNameEvent.name.isNotEmpty) {
        emit(const NotValidNameState());
      }
    }
  }

  Future<void> _onValidEmailForgotPassword(
      ValidateEmailForgotPasswordEvent validateEmailForgotPasswordEvent,
      Emitter<AuthenticationState> emit) async {
    if (validateEmailForgotPasswordEvent.email.isEmpty) {
      emit(const InitialValidForgotPasswordEmailState());
    }
    if (validateEmailForgotPasswordEvent.email.isValidEmail()) {
      emit(const ValidForgotPasswordEmailState());
    } else {
      if (validateEmailForgotPasswordEvent.email.isNotEmpty) {
        emit(const NotValidForgotPasswordEmailState());
      }
    }
  }

  Future<void> _onValidPassword(ValidatePasswordEvent validatePasswordEvent,
      Emitter<AuthenticationState> emit) async {
    if (validatePasswordEvent.password.isEmpty) {
      emit(const InitialValidPasswordState());
    }
    if (validatePasswordEvent.password.isValidPassword()) {
      emit(const ValidPasswordState());
    } else {
      if (validatePasswordEvent.password.isNotEmpty) {
        emit(const NotValidPasswordState());
      }
    }
  }

  Future<void> _onSignUp(SignUpAuthEvent signUpAuthEvent,
      Emitter<AuthenticationState> emit) async {
    emit(const SignUpLoadingState());
    try {
      uId = await authenticationRepository
          .signUp(signUpAuthEvent.authenticationRequest);
      emit(const SignUpSuccessState());

      add(
        StoreUserEvent(
          storeUserRequest: StoreUserRequest(
              uId: uId,
              email: signUpAuthEvent.authenticationRequest.email.trim(),
              name: signUpAuthEvent.authenticationRequest.name.trim()),
        ),
      );
    } on FirebaseAuthException catch (error) {
      emit(SignUpFailureState(
          signUpWithEmailAndPasswordFailure:
              SignUpWithEmailAndPasswordFailure.fromCode(error.code)));
    }
  }

  Future<void> _onSignUpWithGoogle(
      SignUpWithGoogleEvent event, Emitter<AuthenticationState> emit) async {
    emit(const SignUpWithGoogleLoadingState());
    try {
      final UserCredential userCredential =
          await authenticationRepository.signInWithGoogle();
      uId = userCredential.user!.uid;
      if (kDebugMode) {
        print("MY UID $uId");
      }
      emit(const SignUpWithGoogleSuccessState());
      add(StoreUserEvent(
        storeUserRequest: StoreUserRequest(
          uId: uId,
          email: userCredential.user!.displayName!,
          name: userCredential.user!.email!,
        ),
      ));
    } on FirebaseAuthException catch (error) {
      emit(SignUpWithGoogleFailureState(
          signUpWithGoogleFailure:
              SignUpWithGoogleFailure.fromCode(error.code)));
    }
  }

  Future<void> _onStoreUser(
      StoreUserEvent event, Emitter<AuthenticationState> emit) async {
    emit(const StoreUserLoadingState());
    try {
      await authenticationRepository.storeUser(event.storeUserRequest);
      emit(const StoreUserSuccessState());
    } catch (error) {
      emit(const StoreUserFailureState());
    }
  }

  Future<void> _onSignIn(
      SignInAuthEvent event, Emitter<AuthenticationState> emit) async {
    emit(const SignInLoadingState());
    try {
      final uId =
          await authenticationRepository.signIn(event.authenticationRequest);
      emit(SignInSuccessState(uId: uId));
    } on FirebaseAuthException catch (error) {
      emit(SignInFailureState(
          logInWithEmailAndPasswordFailure:
              LogInWithEmailAndPasswordFailure.fromCode(error.code)));
    }
  }

  Future<void> _onForgotPassword(ForgotPasswrodEvent forgotPasswrodEvent,
      Emitter<AuthenticationState> emit) async {
    emit(const ForgotPasswordLoadingState());
    try {
      await authenticationRepository.forgotPassword(
          email: forgotPasswrodEvent.email);
      emit(const ForgotPasswordSuccessState());
    } on FirebaseAuthException catch (error) {
      emit(ForgotPasswordFailureState(error: error.message!));
    }
  }

  Future<void> _onFetchUser(
      FetchUserEvent event, Emitter<AuthenticationState> emit) async {
    emit(const GetUserLoadingState());
    try {
      final UserModel user = await authenticationRepository.getUser(
          firebaseUserId: CachingStorage.getUId(key: 'uId'),
          collectionName: 'users');
      emit(GetUserSuccessState(user));
    } on FirebaseAuthException catch (error) {
      emit(const GetUserFailureState());
    }
  }

  Future<void> _onValidPasswordSignIn(
      ValidatePasswordSignInEvent validatePasswordSignInEvent,
      Emitter<AuthenticationState> emit) async {
    if (validatePasswordSignInEvent.password.isEmpty) {
      emit(const InitialValidPasswordSignInState());
    }
    if (validatePasswordSignInEvent.password.isValidPassword()) {
      emit(const ValidPasswordSignInState());
    } else {
      if (validatePasswordSignInEvent.password.isNotEmpty) {
        emit(const NotValidPasswordSignInState());
      }
    }
  }
}
