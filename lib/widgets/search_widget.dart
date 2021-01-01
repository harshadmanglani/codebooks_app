import 'package:books/main.dart';
import 'package:books/widgets/book_list_builder.dart';
import 'package:flutter/material.dart';

/// The search widget uses the search API to find books.
/// It calls `BookListBuilder` to build the list of search results.

class SearchWidget extends StatefulWidget {
  @override
  _SearchWidgetState createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  bool showSearchResults = false;
  TextEditingController _textEditingController;
  FocusNode searchNode;
  int page;
  String searchQuery;

  @override
  void initState() {
    super.initState();
    searchNode = FocusNode();
    page = 1;
    _textEditingController = TextEditingController();
    searchNode.requestFocus();
    searchQuery = "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0.5,
            centerTitle: true,
            automaticallyImplyLeading: false,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                    flex: 2,
                    child: IconButton(
                        icon: Icon(
                          Icons.arrow_back,
                          color: Theme.of(context).accentColor,
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        })),
                SizedBox(width: 30),
                Expanded(
                  flex: 17,
                  child: TextField(
                    focusNode: searchNode,
                    onEditingComplete: () {
                      searchNode.unfocus();
                      setState(() {
                        searchQuery = _textEditingController.value.text;
                        searchQuery != ''
                            ? setState(() {
                                showSearchResults = true;
                              })
                            : setState(() {
                                showSearchResults = false;
                              });
                      });
                    },
                    controller: _textEditingController,
                    style: TextStyle(fontSize: 17),
                    decoration: InputDecoration(
                        isDense: true,
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                        hintText: 'Search'),
                  ),
                ),
                SizedBox(width: 5)
              ],
            )),
        body: showSearchResults
            ? Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 15.0, bottom: 5.0),
                    child: Text('Showing results for $searchQuery: '),
                  ),
                  Expanded(
                    flex: 10,
                    child: BookListBuilder(
                        future: InheritedApiWidget.of(context)
                            .booksInterface
                            .search(searchQuery, page)),
                  ),
                ],
              )
            : Container());
  }
}
