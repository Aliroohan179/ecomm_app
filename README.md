# BookStore - Flutter E-Commerce App

A complete e-commerce bookstore application built with Flutter and Firebase, featuring user authentication, book browsing by categories, cart management, wishlist, checkout process, and user profile management.

## Features

### 🔐 Authentication
- **Email/Password Sign Up**: Create new accounts with email validation
- **Sign In**: Secure login for existing users
- **Auto Sign Out**: Automatic authentication state management

### 📚 Book Management
- **Browse Books**: View all available books in a grid layout
- **Category Filtering**: Filter books by categories (Fiction, Non-Fiction, Science, Technology, Biography, History, Self-Help, Business, Romance, Mystery, Fantasy, Horror)
- **Book Details**: Detailed information including title, author, description, price, ratings, ISBN, and stock availability
- **Search**: Easy navigation through book collections

### 🛒 Shopping Cart
- **Add to Cart**: Add books with quantity selection
- **Update Quantity**: Increase or decrease item quantities
- **Remove Items**: Delete items from cart
- **Real-time Total**: Automatic calculation of cart total
- **Persistent Storage**: Cart data saved to Firestore

### ❤️ Wishlist
- **Add to Wishlist**: Save books for later
- **Remove from Wishlist**: Manage your wishlist items
- **Quick Access**: View all wishlisted items in one place
- **Date Tracking**: See when items were added

### 💳 Checkout Process
- **Shipping Information**: Enter complete delivery address
- **Order Summary**: Review items before purchase
- **Order Placement**: Create orders stored in Firestore
- **Auto-populated Forms**: Uses profile data for faster checkout

### 📦 Order Management
- **Order History**: View all past orders
- **Order Status**: Track order status (Pending, Processing, Shipped, Delivered, Cancelled)
- **Order Details**: Complete information including items, pricing, and shipping address
- **Status Colors**: Visual indicators for different order states

### 👤 User Profile
- **Profile Management**: Update personal information
- **Edit Mode**: Toggle between view and edit modes
- **Data Persistence**: All changes saved to Firestore
- **Profile Fields**: Name, phone, address, city, state, ZIP code

## Technology Stack

- **Flutter**: Cross-platform UI framework
- **Firebase Authentication**: User authentication and management
- **Cloud Firestore**: NoSQL database for real-time data
- **Firebase Storage**: Image storage (ready for implementation)
- **Provider**: State management
- **Material Design 3**: Modern UI components

## Dependencies

```yaml
dependencies:
  flutter:
    sdk: flutter
  firebase_core: ^2.24.2
  firebase_auth: ^4.15.3
  cloud_firestore: ^4.13.6
  firebase_storage: ^11.5.6
  provider: ^6.1.1
  cached_network_image: ^3.3.1
  intl: ^0.18.1
  flutter_rating_bar: ^4.0.1
  image_picker: ^1.0.7
```

## Project Structure

```
lib/
├── main.dart                 # App entry point and routing
├── models/                   # Data models
│   ├── book.dart            # Book model
│   ├── cart_item.dart       # Cart item model
│   ├── order.dart           # Order and order item models
│   ├── user_profile.dart    # User profile model
│   └── wishlist_item.dart   # Wishlist item model
├── services/                 # Backend services
│   ├── auth_service.dart    # Authentication service
│   └── firestore_service.dart # Firestore database operations
├── screens/                  # UI screens
│   ├── auth/
│   │   ├── login_screen.dart
│   │   └── signup_screen.dart
│   ├── home/
│   │   └── home_screen.dart
│   ├── book/
│   │   └── book_details_screen.dart
│   ├── cart/
│   │   └── cart_screen.dart
│   ├── wishlist/
│   │   └── wishlist_screen.dart
│   ├── checkout/
│   │   └── checkout_screen.dart
│   ├── orders/
│   │   └── orders_screen.dart
│   └── profile/
│       └── profile_screen.dart
└── utils/                    # Utilities and constants
    ├── constants.dart       # App constants and colors
    └── helpers.dart         # Helper functions
```

## Installation

### Prerequisites
- Flutter SDK (3.0.0 or higher)
- Dart SDK (3.0.0 or higher)
- Android Studio or VS Code with Flutter extension
- Firebase account

### Setup Steps

1. **Clone the repository**
   ```bash
   git clone https://github.com/Aliroohan179/ecomm_app.git
   cd ecomm_app
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Set up Firebase**
   - Follow the detailed instructions in [FIREBASE_SETUP.md](FIREBASE_SETUP.md)
   - Create a Firebase project
   - Add Android/iOS apps to Firebase
   - Download and place configuration files
   - Enable Authentication and Firestore

4. **Configure Android**
   - Add `google-services.json` to `android/app/`
   - Update `android/app/build.gradle` with Firebase plugin
   - Set `minSdkVersion` to 21 or higher

5. **Add sample data**
   - Use Firebase Console to add books to the `books` collection
   - See [FIREBASE_SETUP.md](FIREBASE_SETUP.md) for sample book data structure

6. **Run the app**
   ```bash
   flutter run
   ```

## Firebase Collections Structure

### Users Collection (`users`)
```json
{
  "email": "user@example.com",
  "name": "John Doe",
  "phone": "+1234567890",
  "address": "123 Main St",
  "city": "New York",
  "state": "NY",
  "zipCode": "10001",
  "photoUrl": "",
  "createdAt": 1234567890000
}
```

### Books Collection (`books`)
```json
{
  "title": "Book Title",
  "author": "Author Name",
  "description": "Book description...",
  "price": 19.99,
  "category": "Fiction",
  "imageUrl": "https://...",
  "rating": 4.5,
  "reviewCount": 100,
  "isbn": "978-...",
  "stock": 50
}
```

### Cart Subcollection (`users/{userId}/cart`)
```json
{
  "bookId": "book_doc_id",
  "title": "Book Title",
  "author": "Author Name",
  "price": 19.99,
  "imageUrl": "https://...",
  "quantity": 2
}
```

### Wishlist Subcollection (`users/{userId}/wishlist`)
```json
{
  "bookId": "book_doc_id",
  "title": "Book Title",
  "author": "Author Name",
  "price": 19.99,
  "imageUrl": "https://...",
  "addedAt": 1234567890000
}
```

### Orders Collection (`orders`)
```json
{
  "userId": "user_doc_id",
  "items": [
    {
      "bookId": "book_doc_id",
      "title": "Book Title",
      "author": "Author Name",
      "price": 19.99,
      "quantity": 1
    }
  ],
  "totalAmount": 19.99,
  "shippingAddress": "123 Main St",
  "city": "New York",
  "state": "NY",
  "zipCode": "10001",
  "phone": "+1234567890",
  "status": "pending",
  "createdAt": 1234567890000,
  "deliveredAt": null
}
```

## Usage Guide

### For Users

1. **Sign Up/Login**: Create an account or sign in with existing credentials
2. **Browse Books**: View all books or filter by category
3. **View Details**: Tap on any book to see detailed information
4. **Add to Cart**: Select quantity and add books to your cart
5. **Manage Wishlist**: Save books you want to buy later
6. **Checkout**: Review cart and provide shipping information
7. **Track Orders**: View order history and status
8. **Update Profile**: Keep your profile information up to date

### For Developers

1. **Add New Categories**: Update `AppConstants.bookCategories` in `utils/constants.dart`
2. **Customize Theme**: Modify colors in `AppColors` class
3. **Add Features**: Extend services in `services/` directory
4. **Create Screens**: Follow existing screen structure in `screens/` directory

## Testing

To test the app:

1. Create a test Firebase project
2. Add sample books to Firestore
3. Run the app on an emulator or physical device
4. Test all features:
   - User registration and login
   - Browsing and filtering books
   - Adding items to cart and wishlist
   - Checkout process
   - Profile updates

## Future Enhancements

- [ ] Payment integration (Stripe, PayPal)
- [ ] Book search functionality
- [ ] User reviews and ratings
- [ ] Admin panel for book management
- [ ] Push notifications for order updates
- [ ] Social sharing
- [ ] Multi-language support
- [ ] Dark mode theme
- [ ] Offline support
- [ ] Advanced filtering and sorting
- [ ] Promo codes and discounts

## Security

- All sensitive operations require authentication
- Firestore security rules restrict data access
- User data is private and can only be accessed by the owner
- Passwords are handled securely by Firebase Authentication

## Contributing

Contributions are welcome! Please follow these steps:

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## License

This project is open source and available under the MIT License.

## Support

For issues, questions, or suggestions:
- Open an issue on GitHub
- Check [FIREBASE_SETUP.md](FIREBASE_SETUP.md) for Firebase configuration help

## Acknowledgments

- Flutter team for the amazing framework
- Firebase for backend services
- Material Design for UI components
- All contributors and testers

## Screenshots

*Add screenshots of your app here after running it*

## Author

**Aliroohan179**

---

Made with ❤️ using Flutter and Firebase
