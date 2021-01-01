import 'package:books/models/book_model.dart';
import 'package:flutter/material.dart';

typedef Null ItemSelectedCallback(String isbn);

class BookCard extends StatelessWidget {
  final ItemSelectedCallback onItemSelected;
  final width;

  BookCard({Key key, this.book, this.onItemSelected, this.width})
      : super(key: key);
  final Book book;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onItemSelected(book.isbn);
      },
      child: Container(
        height: 230,
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 15.0, right: 15.0),
              child: Container(
                  height: 230,
                  width: 120,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage(book.imageUrl),
                          fit: BoxFit.cover))),
            ),
            Positioned(
              top: 25,
              left: 150,
              child: Container(
                height: 230,
                width: width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(book.title,
                        style: Theme.of(context).textTheme.headline1,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis),
                    SizedBox(height: 10),
                    Text(book.subtitle,
                        style: Theme.of(context).textTheme.headline2,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis),
                  ],
                ),
              ),
            ),
            Positioned(child: Text(book.price), bottom: 35, left: 150)
          ],
        ),
      ),
    );
  }
}
