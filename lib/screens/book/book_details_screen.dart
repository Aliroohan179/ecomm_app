import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import '../../models/book.dart';
import '../../services/auth_service.dart';
import '../../services/firestore_service.dart';
import '../../utils/constants.dart';
import '../../utils/helpers.dart';

class BookDetailsScreen extends StatefulWidget {
  final Book book;

  const BookDetailsScreen({super.key, required this.book});

  @override
  State<BookDetailsScreen> createState() => _BookDetailsScreenState();
}

class _BookDetailsScreenState extends State<BookDetailsScreen> {
  int _quantity = 1;
  bool _isInWishlist = false;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _checkWishlist();
  }

  Future<void> _checkWishlist() async {
    final authService = Provider.of<AuthService>(context, listen: false);
    final firestoreService = Provider.of<FirestoreService>(context, listen: false);
    final userId = authService.currentUser?.uid;
    
    if (userId != null) {
      final inWishlist = await firestoreService.isInWishlist(userId, widget.book.id);
      if (mounted) {
        setState(() => _isInWishlist = inWishlist);
      }
    }
  }

  Future<void> _addToCart() async {
    setState(() => _isLoading = true);
    
    try {
      final authService = Provider.of<AuthService>(context, listen: false);
      final firestoreService = Provider.of<FirestoreService>(context, listen: false);
      final userId = authService.currentUser?.uid;

      if (userId != null) {
        await firestoreService.addToCart(userId, widget.book, _quantity);
        if (mounted) {
          Helpers.showSnackBar(context, 'Added to cart');
        }
      }
    } catch (e) {
      if (mounted) {
        Helpers.showSnackBar(context, 'Failed to add to cart', isError: true);
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  Future<void> _toggleWishlist() async {
    try {
      final authService = Provider.of<AuthService>(context, listen: false);
      final firestoreService = Provider.of<FirestoreService>(context, listen: false);
      final userId = authService.currentUser?.uid;

      if (userId != null) {
        if (_isInWishlist) {
          await firestoreService.removeFromWishlist(userId, widget.book.id);
          if (mounted) {
            Helpers.showSnackBar(context, 'Removed from wishlist');
            setState(() => _isInWishlist = false);
          }
        } else {
          await firestoreService.addToWishlist(userId, widget.book);
          if (mounted) {
            Helpers.showSnackBar(context, 'Added to wishlist');
            setState(() => _isInWishlist = true);
          }
        }
      }
    } catch (e) {
      if (mounted) {
        Helpers.showSnackBar(context, 'Failed to update wishlist', isError: true);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Book Details'),
        actions: [
          IconButton(
            icon: Icon(
              _isInWishlist ? Icons.favorite : Icons.favorite_outline,
              color: _isInWishlist ? Colors.red : null,
            ),
            onPressed: _toggleWishlist,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 300,
              width: double.infinity,
              color: Colors.grey.shade200,
              child: widget.book.imageUrl.isNotEmpty
                  ? Image.network(
                      widget.book.imageUrl,
                      fit: BoxFit.contain,
                      errorBuilder: (context, error, stackTrace) {
                        return Icon(
                          Icons.book,
                          size: 100,
                          color: Colors.grey.shade400,
                        );
                      },
                    )
                  : Icon(
                      Icons.book,
                      size: 100,
                      color: Colors.grey.shade400,
                    ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.book.title,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'by ${widget.book.author}',
                    style: TextStyle(
                      fontSize: 16,
                      color: AppColors.textSecondary,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      RatingBarIndicator(
                        rating: widget.book.rating,
                        itemBuilder: (context, index) => const Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                        itemCount: 5,
                        itemSize: 20,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        '${widget.book.rating.toStringAsFixed(1)} (${widget.book.reviewCount} reviews)',
                        style: TextStyle(
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.primary.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          widget.book.category,
                          style: TextStyle(
                            color: AppColors.primary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const Spacer(),
                      Text(
                        Helpers.formatPrice(widget.book.price),
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primary,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    'Description',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    widget.book.description,
                    style: TextStyle(
                      fontSize: 14,
                      color: AppColors.textSecondary,
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 24),
                  Row(
                    children: [
                      const Text(
                        'ISBN:',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(width: 8),
                      Text(widget.book.isbn),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Text(
                        'Stock:',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        '${widget.book.stock} available',
                        style: TextStyle(
                          color: widget.book.stock > 0
                              ? AppColors.success
                              : AppColors.error,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  Row(
                    children: [
                      const Text(
                        'Quantity:',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: 16),
                      IconButton(
                        onPressed: _quantity > 1
                            ? () => setState(() => _quantity--)
                            : null,
                        icon: const Icon(Icons.remove_circle_outline),
                      ),
                      Text(
                        '$_quantity',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      IconButton(
                        onPressed: _quantity < widget.book.stock
                            ? () => setState(() => _quantity++)
                            : null,
                        icon: const Icon(Icons.add_circle_outline),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: _isLoading || widget.book.stock == 0
                          ? null
                          : _addToCart,
                      icon: _isLoading
                          ? const SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: Colors.white,
                              ),
                            )
                          : const Icon(Icons.shopping_cart),
                      label: Text(
                        widget.book.stock == 0 ? 'Out of Stock' : 'Add to Cart',
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
