abstract class UserBookListActions {
  Future<void> loadBookFromUser(String userId);
  Future<void> loadMoreBooksFromUser(String userId);
}
