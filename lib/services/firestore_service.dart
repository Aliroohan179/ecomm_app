import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/book.dart';
import '../models/cart_item.dart';
import '../models/wishlist_item.dart';
import '../models/order.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Books
  Stream<List<Book>> getBooks() {
    return _firestore.collection('books').snapshots().map((snapshot) =>
        snapshot.docs.map((doc) => Book.fromMap(doc.data(), doc.id)).toList());
  }

  Stream<List<Book>> getBooksByCategory(String category) {
    return _firestore
        .collection('books')
        .where('category', isEqualTo: category)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => Book.fromMap(doc.data(), doc.id))
            .toList());
  }

  Future<Book?> getBook(String bookId) async {
    try {
      DocumentSnapshot doc =
          await _firestore.collection('books').doc(bookId).get();
      if (doc.exists) {
        return Book.fromMap(doc.data() as Map<String, dynamic>, doc.id);
      }
      return null;
    } catch (e) {
      throw Exception('Failed to get book: ${e.toString()}');
    }
  }

  Future<List<String>> getCategories() async {
    try {
      QuerySnapshot snapshot = await _firestore.collection('books').get();
      Set<String> categories = {};
      for (var doc in snapshot.docs) {
        final data = doc.data() as Map<String, dynamic>;
        if (data['category'] != null) {
          categories.add(data['category']);
        }
      }
      return categories.toList()..sort();
    } catch (e) {
      throw Exception('Failed to get categories: ${e.toString()}');
    }
  }

  // Cart
  Stream<List<CartItem>> getCartItems(String userId) {
    return _firestore
        .collection('users')
        .doc(userId)
        .collection('cart')
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => CartItem.fromMap(doc.data(), doc.id))
            .toList());
  }

  Future<void> addToCart(String userId, Book book, int quantity) async {
    try {
      final cartRef = _firestore
          .collection('users')
          .doc(userId)
          .collection('cart')
          .doc(book.id);

      final doc = await cartRef.get();
      if (doc.exists) {
        final existingQuantity = doc.data()?['quantity'] ?? 0;
        await cartRef.update({'quantity': existingQuantity + quantity});
      } else {
        await cartRef.set({
          'bookId': book.id,
          'title': book.title,
          'author': book.author,
          'price': book.price,
          'imageUrl': book.imageUrl,
          'quantity': quantity,
        });
      }
    } catch (e) {
      throw Exception('Failed to add to cart: ${e.toString()}');
    }
  }

  Future<void> updateCartItemQuantity(
      String userId, String cartItemId, int quantity) async {
    try {
      if (quantity <= 0) {
        await _firestore
            .collection('users')
            .doc(userId)
            .collection('cart')
            .doc(cartItemId)
            .delete();
      } else {
        await _firestore
            .collection('users')
            .doc(userId)
            .collection('cart')
            .doc(cartItemId)
            .update({'quantity': quantity});
      }
    } catch (e) {
      throw Exception('Failed to update cart item: ${e.toString()}');
    }
  }

  Future<void> removeFromCart(String userId, String cartItemId) async {
    try {
      await _firestore
          .collection('users')
          .doc(userId)
          .collection('cart')
          .doc(cartItemId)
          .delete();
    } catch (e) {
      throw Exception('Failed to remove from cart: ${e.toString()}');
    }
  }

  Future<void> clearCart(String userId) async {
    try {
      final cartItems = await _firestore
          .collection('users')
          .doc(userId)
          .collection('cart')
          .get();
      for (var doc in cartItems.docs) {
        await doc.reference.delete();
      }
    } catch (e) {
      throw Exception('Failed to clear cart: ${e.toString()}');
    }
  }

  // Wishlist
  Stream<List<WishlistItem>> getWishlistItems(String userId) {
    return _firestore
        .collection('users')
        .doc(userId)
        .collection('wishlist')
        .orderBy('addedAt', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => WishlistItem.fromMap(doc.data(), doc.id))
            .toList());
  }

  Future<void> addToWishlist(String userId, Book book) async {
    try {
      await _firestore
          .collection('users')
          .doc(userId)
          .collection('wishlist')
          .doc(book.id)
          .set({
        'bookId': book.id,
        'title': book.title,
        'author': book.author,
        'price': book.price,
        'imageUrl': book.imageUrl,
        'addedAt': DateTime.now().millisecondsSinceEpoch,
      });
    } catch (e) {
      throw Exception('Failed to add to wishlist: ${e.toString()}');
    }
  }

  Future<void> removeFromWishlist(String userId, String bookId) async {
    try {
      await _firestore
          .collection('users')
          .doc(userId)
          .collection('wishlist')
          .doc(bookId)
          .delete();
    } catch (e) {
      throw Exception('Failed to remove from wishlist: ${e.toString()}');
    }
  }

  Future<bool> isInWishlist(String userId, String bookId) async {
    try {
      final doc = await _firestore
          .collection('users')
          .doc(userId)
          .collection('wishlist')
          .doc(bookId)
          .get();
      return doc.exists;
    } catch (e) {
      return false;
    }
  }

  // Orders
  Future<String> createOrder(String userId, Order order) async {
    try {
      final docRef = await _firestore.collection('orders').add(order.toMap());
      return docRef.id;
    } catch (e) {
      throw Exception('Failed to create order: ${e.toString()}');
    }
  }

  Stream<List<Order>> getUserOrders(String userId) {
    return _firestore
        .collection('orders')
        .where('userId', isEqualTo: userId)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => Order.fromMap(doc.data(), doc.id))
            .toList());
  }

  Future<Order?> getOrder(String orderId) async {
    try {
      DocumentSnapshot doc =
          await _firestore.collection('orders').doc(orderId).get();
      if (doc.exists) {
        return Order.fromMap(doc.data() as Map<String, dynamic>, doc.id);
      }
      return null;
    } catch (e) {
      throw Exception('Failed to get order: ${e.toString()}');
    }
  }
}
