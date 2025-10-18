class CartItem {
  final String id;
  final String bookId;
  final String title;
  final String author;
  final double price;
  final String imageUrl;
  final int quantity;

  CartItem({
    required this.id,
    required this.bookId,
    required this.title,
    required this.author,
    required this.price,
    required this.imageUrl,
    required this.quantity,
  });

  factory CartItem.fromMap(Map<String, dynamic> map, String id) {
    return CartItem(
      id: id,
      bookId: map['bookId'] ?? '',
      title: map['title'] ?? '',
      author: map['author'] ?? '',
      price: (map['price'] ?? 0.0).toDouble(),
      imageUrl: map['imageUrl'] ?? '',
      quantity: map['quantity'] ?? 1,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'bookId': bookId,
      'title': title,
      'author': author,
      'price': price,
      'imageUrl': imageUrl,
      'quantity': quantity,
    };
  }

  double get totalPrice => price * quantity;

  CartItem copyWith({int? quantity}) {
    return CartItem(
      id: id,
      bookId: bookId,
      title: title,
      author: author,
      price: price,
      imageUrl: imageUrl,
      quantity: quantity ?? this.quantity,
    );
  }
}
