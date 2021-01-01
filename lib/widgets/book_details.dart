import 'package:books/main.dart';
import 'package:books/models/book_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class BookDetails extends StatefulWidget {
  final String isbn;
  BookDetails(this.isbn);
  @override
  _BookDetailsState createState() => _BookDetailsState();
}

class _BookDetailsState extends State<BookDetails> {
  Future bookFuture;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.isbn == null
          ? Center(child: Text('Select a book to view the details'))
          : FutureBuilder(
              future: InheritedApiWidget.of(context)
                  .booksInterface
                  .isbn(widget.isbn),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.data == null) {
                    return Center(
                      child: Text('Something went wrong.'),
                    );
                  }
                  Book book = snapshot.data;
                  return SingleChildScrollView(
                    child: Container(
                        child: Padding(
                      padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(child: Image.network(book.imageUrl)),
                          introductionWidget(book),
                          SizedBox(height: 15),
                          descriptionWidget(book)
                        ],
                      ),
                    )),
                  );
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              },
            ),
    );
  }

  Widget introductionWidget(Book book) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
              flex: 2,
              child: Text(book.title,
                  maxLines: 5, style: Theme.of(context).textTheme.headline3)),
          Text(book.price, style: Theme.of(context).textTheme.headline1)
        ],
      ),
      SizedBox(
        height: 5,
      ),
      Text(book.authors, style: Theme.of(context).textTheme.headline2),
      SizedBox(
        height: 5,
      ),
      RatingBarIndicator(
        rating: double.parse(book.rating),
        itemBuilder: (context, index) => Icon(
          Icons.star,
          color: Colors.amber,
        ),
        itemCount: 5,
        itemSize: 30.0,
        direction: Axis.horizontal,
      )
    ]);
  }

  Widget descriptionWidget(Book book) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Description: ", style: Theme.of(context).textTheme.headline1),
        SizedBox(height: 10),
        Text(book.desc, style: Theme.of(context).textTheme.bodyText1),
        SizedBox(height: 15),
        Text(
            "Pages: ${book.pages}\nPublisher: ${book.publisher}\nYear: ${book.year}",
            style: Theme.of(context)
                .textTheme
                .headline2
                .copyWith(fontSize: 16, color: Colors.black)),
        SizedBox(height: 10)
      ],
    );
  }
}
