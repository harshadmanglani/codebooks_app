class Book {
  String title;
  String subtitle;
  String isbn;
  String price;
  String imageUrl;
  String bookUrl;
  String pages;
  String year;
  String desc;
  String authors;
  String publisher;
  String rating;

  Book(
      {this.title,
      this.subtitle,
      this.isbn,
      this.imageUrl,
      this.bookUrl,
      this.authors,
      this.desc,
      this.pages,
      this.publisher,
      this.year,
      this.rating,
      this.price});

  factory Book.fromJson(Map<String, dynamic> data) {
    return Book(
        title: data['title'],
        subtitle: data['subtitle'],
        isbn: data['isbn13'],
        price: data['price'],
        imageUrl: data['image'],
        desc: data['desc'],
        pages: data['pages'],
        authors: data['authors'],
        publisher: data['publisher'],
        rating: data['rating'],
        year: data['year'],
        bookUrl: data['url']);
  }
}
