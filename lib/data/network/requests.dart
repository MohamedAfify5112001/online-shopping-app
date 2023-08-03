import 'package:equatable/equatable.dart';

sealed class AuthenticationRequest extends Equatable {
  final String email;
  final String password;

  const AuthenticationRequest({required this.email, required this.password});

  @override
  List<Object> get props => [email, password];
}

final class SignUpAuthenticationRequest extends AuthenticationRequest {
  final String name;
  const SignUpAuthenticationRequest(
      {required super.email, required super.password, required this.name});
}

final class SignInAuthenticationRequest extends AuthenticationRequest {
  const SignInAuthenticationRequest(
      {required super.email, required super.password});
}

final class StoreUserRequest extends Equatable {
  final String uId;
  final String email;
  final String name;
  final String image;
  const StoreUserRequest(
      {required this.uId,
      required this.email,
      required this.name,
      this.image =
          "https://media.istockphoto.com/id/1337144146/vector/default-avatar-profile-icon-vector.jpg?s=612x612&w=0&k=20&c=BIbFwuv7FxTWvh5S3vB6bkT0Qv8Vn8N5Ffseq84ClGI="});

  @override
  List<Object?> get props => [email, name];
}
