import 'package:bookstanis/app/features/books/books_list/widgets/books_list/start_rating.dart';
import 'package:flutter/material.dart';

class BookCard extends StatelessWidget {
  final int? bookId;
  final String bookName;
  final String? bookCoverUrl;
  final double? bookRating;
  final void Function(int) onStartTapStart;

  const BookCard(
      {super.key,
      required this.bookId,
      required this.bookName,
      required this.bookCoverUrl,
      required this.bookRating,
      required this.onStartTapStart});
  @override
  Widget build(BuildContext context) {
    final Color primaryColor = Theme.of(context).colorScheme.primary;
    const double titleFontSize = 16;
    return InkWell(
      onTap: () {
        if (bookId == null) {
          return;
        }
        Navigator.of(context).pushNamed("/book_info", arguments: bookId);
      },
      child: Card(
        child: Column(
          children: [
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(2),
                child: bookCoverUrl == null
                    ? Container(
                        color: Colors.grey,
                      )
                    : Image.network(
                        bookCoverUrl ?? "",
                        fit: BoxFit.cover,
                      ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Text(
                bookName,
                style: const TextStyle(fontSize: titleFontSize),
              ),
            ),
            StartRating(
                onTapStart: (_) {},
                fillColor: primaryColor,
                ratingValue: bookRating ?? 0)
          ],
        ),
      ),
    );
  }
}
