import 'package:equatable/equatable.dart';

typedef JsonMap = Map<String, dynamic>;

final class BannerModel extends Equatable {
  final String imageUrl;
  final String title;
  const BannerModel({required this.imageUrl, required this.title});

  @override
  List<Object> get props => [imageUrl, title];

  factory BannerModel.fromMap(JsonMap json) => BannerModel(
        imageUrl: json['image'],
        title: json['title'],
      );
}
