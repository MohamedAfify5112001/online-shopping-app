import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:online_shopping/token/app_colors.dart';

class ReusableRatingBar extends StatelessWidget {
  final int initialRating;

  const ReusableRatingBar({Key? key, required this.initialRating})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RatingBar.builder(
      initialRating: initialRating.toDouble(),
      minRating: 1,
      maxRating: 10,
      direction: Axis.horizontal,
      itemSize: 14.0,
      allowHalfRating: true,
      itemCount: 5,
      itemPadding: const EdgeInsets.symmetric(horizontal: .5),
      itemBuilder: (context, _) => Icon(
        Icons.star_rounded,
        color: AppColors.ratingColor,
      ),
      onRatingUpdate: (double value) {
        if (kDebugMode) {
          print(value);
        }
      },
    );
  }
}

class ReusableRatingBarForReviews extends StatelessWidget {
  final int initialRating;
  final int count;

  const ReusableRatingBarForReviews(
      {Key? key, required this.initialRating, required this.count})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RatingBar.builder(
      initialRating: initialRating.toDouble(),
      minRating: 1,
      maxRating: 10,
      direction: Axis.horizontal,
      itemSize: 14.0,
      allowHalfRating: true,
      itemCount: count,
      itemPadding: const EdgeInsets.only(right: .5),
      itemBuilder: (context, _) => Icon(
        Icons.star_rounded,
        color: AppColors.ratingColor,
      ),
      onRatingUpdate: (double value) {
        if (kDebugMode) {
          print(value);
        }
      },
    );
  }
}
