import 'package:firebase_auth/firebase_auth.dart';

import '../../data/network/requests.dart';
import '../../data/network/services/auth_services/auth.dart';
import '../../model/user.dart';

abstract interface class AuthenticationRepository {
  Future<String> signUp(AuthenticationRequest authenticationRequest);

  Future<String> signIn(AuthenticationRequest authenticationRequest);

  Future<UserCredential> signInWithGoogle();

  Future<void> storeUser(StoreUserRequest storeUserRequest);

  Future<void> forgotPassword({required String email});

  Future<UserModel> getUser({
    required String firebaseUserId,
    required String collectionName,
  });
}

final class AuthenticationRepositoryImplement
    implements AuthenticationRepository {
  final AuthenticationServices authenticationServices;
  AuthenticationRepositoryImplement({required this.authenticationServices});
  @override
  Future<String> signIn(AuthenticationRequest authenticationRequest) async =>
      await authenticationServices.signIn(authenticationRequest);

  @override
  Future<String> signUp(AuthenticationRequest authenticationRequest) async =>
      await authenticationServices.signUp(authenticationRequest);

  @override
  Future<void> storeUser(StoreUserRequest storeUserRequest) async =>
      await authenticationServices.storeUser(storeUserRequest);

  @override
  Future<UserCredential> signInWithGoogle() async =>
      await authenticationServices.signInWithGoogle();

  @override
  Future<void> forgotPassword({required String email}) async =>
      await authenticationServices.forgotPassword(email: email);

  @override
  Future<UserModel> getUser(
          {required String firebaseUserId,
          required String collectionName}) async =>
      authenticationServices.getUser(
          firebaseUserId: firebaseUserId, collectionName: collectionName);
}
