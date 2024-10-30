import 'package:bookstanis/app/features/books/models/book.dart';
import 'package:bookstanis/app/features/books/widgets/books_list/book_card.dart';
import 'package:bookstanis/app/features/books/widgets/books_list/book_loading_card.dart';
import 'package:flutter/material.dart';

class BooksList extends StatelessWidget {
  final List<Book> books;
  final bool addingMore;
  final Future<void> Function(Book book) updateBookCallback;
  final Future<void> Function() addMoreCallback;

  const BooksList(
      {super.key,
      required this.books,
      required this.updateBookCallback,
      required this.addMoreCallback,
      required this.addingMore});

  @override
  Widget build(BuildContext context) {
    const int gridCount = 2;
    final ScrollController scrollController = ScrollController();

    List<Widget> loadingBooksCard = [];

    scrollController.addListener(
      () {
        if (scrollController.position.pixels ==
            scrollController.position.maxScrollExtent) {
          addMoreCallback();
        }
      },
    );

    if (addingMore) {
      loadingBooksCard
          .addAll([const BookLoadingCard(), const BookLoadingCard()]);
      if (books.length % 2 != 0) {
        loadingBooksCard.add(const BookLoadingCard());
      }
    }

    return GridView.count(
        controller: scrollController,
        crossAxisCount: gridCount,
        childAspectRatio: 0.6,
        children: <Widget>[
          ...books.map((book) => BookCard(
                bookId: book.id,
                bookCoverUrl: book.coverUrl,
                bookName: book.name,
                bookRating: book.rating,
                onStartTapStart: (value) {
                  book.rating = value.toDouble();
                  updateBookCallback(book);
                },
              )),
          ...loadingBooksCard
        ]);
  }
}
