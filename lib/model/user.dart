import 'package:equatable/equatable.dart';
import 'package:online_shopping/model/order_model.dart';

class UserModel extends Equatable {
  final String email;
  final String name;
  final String image;

  factory UserModel.fromMap($JsonMap json) =>
      UserModel(name: json['name'], email: json['email'], image: json['image']);

  const UserModel(
      {required this.name, required this.email, required this.image});

  @override
  List<Object?> get props => [name, email, image];
}
