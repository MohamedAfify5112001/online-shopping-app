import 'package:equatable/equatable.dart';

final class ReviewModel extends Equatable {
  final String personImage;
  final String name;
  final String rating;
  final String date;
  final String review;
  final List<String> images;

  const ReviewModel({
    required this.personImage,
    required this.name,
    required this.rating,
    required this.date,
    required this.review,
    required this.images,
  });

  factory ReviewModel.fromMap(JsonMap json) => ReviewModel(
      personImage: json['personImage'],
      name: json['name'],
      rating: json['rating'],
      date: json['date'],
      review: json['review'],
      images: json['images']);

  JsonMap get toMap => {
        'personImage': personImage,
        'name': name,
        'rating': rating,
        'date': date,
        'review': review,
        'images': images,
      };

  @override
  List<Object> get props => [name, personImage, rating, date, review, images];
}

typedef JsonMap = Map<String, dynamic>;
