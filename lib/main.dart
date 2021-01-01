import 'package:books/interface/books_interface.dart';
import 'package:books/utils/utils.dart';
import 'package:books/widgets/book_list_builder.dart';
import 'package:books/widgets/search_widget.dart';
import 'package:flutter/material.dart';

void main() {
  BooksInterface booksInterface = BooksInterface();

  runApp(InheritedApiWidget(booksInterface: booksInterface, child: MyApp()));
}

/// The Inherited Widget wrapper to comfortably pass down the instance of the `BooksInterface` class.

class InheritedApiWidget extends InheritedWidget {
  const InheritedApiWidget({
    Key key,
    @required this.booksInterface,
    @required Widget child,
  })  : assert(booksInterface != null),
        assert(child != null),
        super(key: key, child: child);

  final BooksInterface booksInterface;

  static InheritedApiWidget of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<InheritedApiWidget>();
  }

  @override
  bool updateShouldNotify(InheritedApiWidget old) =>
      booksInterface != old.booksInterface;
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Color(0xff581120),
        iconTheme: IconThemeData(color: Color(0xffa115ae)),
        splashColor: Colors.black,
        canvasColor: Colors.white,
        accentColor: Color(0xffa115ae),
        textTheme: buildNunitoTextTheme(context),
        cardTheme: CardTheme(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10))),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomePage(),
    );
  }
}

/// Home Page is the default widget displaying the list of new books retrieved from the API.
/// It uses `BookListBuilder` to build a list of books by passing `booksInterface.new()`

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future newBooks;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    newBooks = InheritedApiWidget.of(context).booksInterface.newBooks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('CODE </> BOOKS',
              style: Theme.of(context).textTheme.headline4),
          actions: [
            IconButton(
                icon: Icon(Icons.search),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => SearchWidget()));
                })
          ],
        ),
        body: BookListBuilder(future: newBooks));
  }
}
