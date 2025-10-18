class Book {
  final String id;
  final String title;
  final String author;
  final String description;
  final double price;
  final String category;
  final String imageUrl;
  final double rating;
  final int reviewCount;
  final String isbn;
  final int stock;

  Book({
    required this.id,
    required this.title,
    required this.author,
    required this.description,
    required this.price,
    required this.category,
    required this.imageUrl,
    this.rating = 0.0,
    this.reviewCount = 0,
    required this.isbn,
    required this.stock,
  });

  factory Book.fromMap(Map<String, dynamic> map, String id) {
    return Book(
      id: id,
      title: map['title'] ?? '',
      author: map['author'] ?? '',
      description: map['description'] ?? '',
      price: (map['price'] ?? 0.0).toDouble(),
      category: map['category'] ?? '',
      imageUrl: map['imageUrl'] ?? '',
      rating: (map['rating'] ?? 0.0).toDouble(),
      reviewCount: map['reviewCount'] ?? 0,
      isbn: map['isbn'] ?? '',
      stock: map['stock'] ?? 0,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'author': author,
      'description': description,
      'price': price,
      'category': category,
      'imageUrl': imageUrl,
      'rating': rating,
      'reviewCount': reviewCount,
      'isbn': isbn,
      'stock': stock,
    };
  }
}
