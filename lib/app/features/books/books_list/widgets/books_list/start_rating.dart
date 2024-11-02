import 'package:flutter/material.dart';

class StartRating extends StatelessWidget {
  final double ratingValue;
  final Color fillColor;
  final void Function(int value) onTapStart;
  final int quantStars;

  const StartRating(
      {super.key,
      required this.fillColor,
      required this.ratingValue,
      required this.onTapStart,
      this.quantStars = 5})
      : assert(ratingValue >= 0 && ratingValue <= quantStars);

  @override
  Widget build(BuildContext context) {
    final List<Widget> stars = [];
    double internalValue = ratingValue;

    for (int i = 0; i < quantStars; i++) {
      if (internalValue >= 1) {
        stars.add(GestureDetector(
          onTap: () => onTapStart(i + 1),
          child: Icon(
            Icons.star,
            color: fillColor,
            size: 32,
          ),
        ));
        internalValue -= 1;
        continue;
      }

      if (internalValue > 0) {
        stars.add(GestureDetector(
          onTap: () => onTapStart(i + 1),
          child: Icon(
            Icons.star_half,
            color: fillColor,
            size: 32,
          ),
        ));
        internalValue -= internalValue;
        continue;
      }

      if (internalValue == 0) {
        stars.add(GestureDetector(
          onTap: () => onTapStart(i + 1),
          child: Icon(
            Icons.star_outline,
            color: fillColor,
            size: 32,
          ),
        ));
      }
    }

    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: stars,
        ));
  }
}
