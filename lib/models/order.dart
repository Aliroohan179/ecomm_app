enum OrderStatus {
  pending,
  processing,
  shipped,
  delivered,
  cancelled,
}

class Order {
  final String id;
  final String userId;
  final List<OrderItem> items;
  final double totalAmount;
  final String shippingAddress;
  final String city;
  final String state;
  final String zipCode;
  final String phone;
  final OrderStatus status;
  final DateTime createdAt;
  final DateTime? deliveredAt;

  Order({
    required this.id,
    required this.userId,
    required this.items,
    required this.totalAmount,
    required this.shippingAddress,
    required this.city,
    required this.state,
    required this.zipCode,
    required this.phone,
    required this.status,
    required this.createdAt,
    this.deliveredAt,
  });

  factory Order.fromMap(Map<String, dynamic> map, String id) {
    return Order(
      id: id,
      userId: map['userId'] ?? '',
      items: (map['items'] as List<dynamic>?)
              ?.map((item) => OrderItem.fromMap(item))
              .toList() ??
          [],
      totalAmount: (map['totalAmount'] ?? 0.0).toDouble(),
      shippingAddress: map['shippingAddress'] ?? '',
      city: map['city'] ?? '',
      state: map['state'] ?? '',
      zipCode: map['zipCode'] ?? '',
      phone: map['phone'] ?? '',
      status: OrderStatus.values.firstWhere(
        (e) => e.toString() == 'OrderStatus.${map['status']}',
        orElse: () => OrderStatus.pending,
      ),
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt'] ?? 0),
      deliveredAt: map['deliveredAt'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['deliveredAt'])
          : null,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'items': items.map((item) => item.toMap()).toList(),
      'totalAmount': totalAmount,
      'shippingAddress': shippingAddress,
      'city': city,
      'state': state,
      'zipCode': zipCode,
      'phone': phone,
      'status': status.toString().split('.').last,
      'createdAt': createdAt.millisecondsSinceEpoch,
      'deliveredAt': deliveredAt?.millisecondsSinceEpoch,
    };
  }

  String get statusString {
    switch (status) {
      case OrderStatus.pending:
        return 'Pending';
      case OrderStatus.processing:
        return 'Processing';
      case OrderStatus.shipped:
        return 'Shipped';
      case OrderStatus.delivered:
        return 'Delivered';
      case OrderStatus.cancelled:
        return 'Cancelled';
    }
  }
}

class OrderItem {
  final String bookId;
  final String title;
  final String author;
  final double price;
  final int quantity;

  OrderItem({
    required this.bookId,
    required this.title,
    required this.author,
    required this.price,
    required this.quantity,
  });

  factory OrderItem.fromMap(Map<String, dynamic> map) {
    return OrderItem(
      bookId: map['bookId'] ?? '',
      title: map['title'] ?? '',
      author: map['author'] ?? '',
      price: (map['price'] ?? 0.0).toDouble(),
      quantity: map['quantity'] ?? 1,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'bookId': bookId,
      'title': title,
      'author': author,
      'price': price,
      'quantity': quantity,
    };
  }

  double get totalPrice => price * quantity;
}
