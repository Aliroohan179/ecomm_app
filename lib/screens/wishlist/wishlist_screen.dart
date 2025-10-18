import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/wishlist_item.dart';
import '../../services/auth_service.dart';
import '../../services/firestore_service.dart';
import '../../utils/constants.dart';
import '../../utils/helpers.dart';

class WishlistScreen extends StatelessWidget {
  const WishlistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context, listen: false);
    final firestoreService = Provider.of<FirestoreService>(context, listen: false);
    final userId = authService.currentUser?.uid;

    if (userId == null) {
      return const Center(child: Text('Please sign in to view wishlist'));
    }

    return StreamBuilder<List<WishlistItem>>(
      stream: firestoreService.getWishlistItems(userId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }

        final wishlistItems = snapshot.data ?? [];

        if (wishlistItems.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.favorite_outline,
                  size: 64,
                  color: Colors.grey.shade400,
                ),
                const SizedBox(height: 16),
                Text(
                  'Your wishlist is empty',
                  style: TextStyle(
                    fontSize: 18,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          );
        }

        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: wishlistItems.length,
          itemBuilder: (context, index) {
            return _WishlistItemCard(
              wishlistItem: wishlistItems[index],
              userId: userId,
            );
          },
        );
      },
    );
  }
}

class _WishlistItemCard extends StatelessWidget {
  final WishlistItem wishlistItem;
  final String userId;

  const _WishlistItemCard({
    required this.wishlistItem,
    required this.userId,
  });

  @override
  Widget build(BuildContext context) {
    final firestoreService = Provider.of<FirestoreService>(context, listen: false);

    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            Container(
              width: 80,
              height: 100,
              color: Colors.grey.shade200,
              child: wishlistItem.imageUrl.isNotEmpty
                  ? Image.network(
                      wishlistItem.imageUrl,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Icon(
                          Icons.book,
                          size: 32,
                          color: Colors.grey.shade400,
                        );
                      },
                    )
                  : Icon(
                      Icons.book,
                      size: 32,
                      color: Colors.grey.shade400,
                    ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    wishlistItem.title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    wishlistItem.author,
                    style: TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    Helpers.formatPrice(wishlistItem.price),
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: AppColors.primary,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Added ${Helpers.formatDate(wishlistItem.addedAt)}',
                    style: TextStyle(
                      fontSize: 12,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
            IconButton(
              onPressed: () {
                firestoreService.removeFromWishlist(userId, wishlistItem.bookId);
                Helpers.showSnackBar(context, 'Removed from wishlist');
              },
              icon: const Icon(Icons.favorite),
              color: Colors.red,
            ),
          ],
        ),
      ),
    );
  }
}
