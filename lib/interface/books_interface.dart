import 'package:books/backend/api_provider.dart';
import 'package:books/models/book_model.dart';

/// This class acts as an interface to convert JSON data to Dart.
/// It uses the `ApiProvider` class to interact with the API for the new, search and isbn functionalities.
/// Each method returns either `List<Book>` or `Book`

class BooksInterface {
  ApiProvider _apiProvider = ApiProvider();

  Future<List<Book>> newBooks() async {
    try {
      dynamic responseMap = await _apiProvider.getRequest('new', null);
      List<Book> bookList = List.generate(responseMap['books'].length,
          (index) => Book.fromJson(responseMap['books'][index]));
      return bookList;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<List<Book>> search(String query, int page) async {
    try {
      dynamic responseMap = await _apiProvider
          .getRequest('search', {'query': query, 'page': page});
      List<Book> bookList = List.generate(responseMap['books'].length,
          (index) => Book.fromJson(responseMap['books'][index]));
      return bookList;
    } on Exception catch (e) {
      print(e);
      return null;
    }
  }

  Future<Book> isbn(String isbn) async {
    try {
      dynamic responseMap = await _apiProvider.getRequest('isbn', isbn);
      Book book = Book.fromJson(responseMap);
      return book;
    } on Exception catch (e) {
      print(e);
      return null;
    }
  }
}
