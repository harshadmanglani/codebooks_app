import 'package:books/models/book_model.dart';
import 'package:flutter/material.dart';

import 'book_card.dart';
import 'book_details.dart';

/// This widget builds a list of books when a future returning `List<Book>` is provided.
/// It also handles the UI logic for different screen sizes/orientations.

class BookListBuilder extends StatefulWidget {
  final Future future;
  BookListBuilder({@required this.future});
  @override
  _BookListBuilderState createState() => _BookListBuilderState();
}

class _BookListBuilderState extends State<BookListBuilder> {
  Future future;
  var selectedIsbn;
  var isLargeScreen = false;
  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    future = widget.future;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: future,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.data == null) {
            return Center(
              child: Text('Something went wrong.'),
            );
          }
          List<Book> bookList = snapshot.data;
          if (bookList.length == 0) {
            return Center(
                child: Text('No results found.',
                    style: Theme.of(context).textTheme.bodyText1));
          }
          return OrientationBuilder(builder: (context, orientation) {
            if (MediaQuery.of(context).size.width > 600) {
              isLargeScreen = true;
            } else {
              isLargeScreen = false;
            }
            return Row(
              children: [
                Expanded(
                  child: booksList(bookList),
                ),
                isLargeScreen
                    ? Container(
                        width: 10,
                        height: MediaQuery.of(context).size.height,
                        color: Colors.grey[200])
                    : Container(),
                isLargeScreen
                    ? Expanded(child: BookDetails(selectedIsbn))
                    : Container(),
              ],
            );
          });
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  Widget booksList(List<Book> bookList) {
    return ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        itemCount: bookList.length,
        itemBuilder: (BuildContext context, int index) => BookCard(
            book: bookList[index],
            width: isLargeScreen
                ? MediaQuery.of(context).size.width / 4
                : MediaQuery.of(context).size.width / 2,
            onItemSelected: (isbn) {
              if (isLargeScreen) {
                setState(() {
                  selectedIsbn = isbn;
                });
              } else
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => BookDetails(isbn)));
            }));
  }
}
