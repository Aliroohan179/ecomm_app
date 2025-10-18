class WishlistItem {
  final String id;
  final String bookId;
  final String title;
  final String author;
  final double price;
  final String imageUrl;
  final DateTime addedAt;

  WishlistItem({
    required this.id,
    required this.bookId,
    required this.title,
    required this.author,
    required this.price,
    required this.imageUrl,
    required this.addedAt,
  });

  factory WishlistItem.fromMap(Map<String, dynamic> map, String id) {
    return WishlistItem(
      id: id,
      bookId: map['bookId'] ?? '',
      title: map['title'] ?? '',
      author: map['author'] ?? '',
      price: (map['price'] ?? 0.0).toDouble(),
      imageUrl: map['imageUrl'] ?? '',
      addedAt: DateTime.fromMillisecondsSinceEpoch(map['addedAt'] ?? 0),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'bookId': bookId,
      'title': title,
      'author': author,
      'price': price,
      'imageUrl': imageUrl,
      'addedAt': addedAt.millisecondsSinceEpoch,
    };
  }
}
