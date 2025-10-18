# App Architecture & Design

This document explains the architecture, design patterns, and structure of the BookStore e-commerce app.

## Architecture Overview

The app follows a **layered architecture** pattern with clear separation of concerns:

```
┌─────────────────────────────────────────┐
│         Presentation Layer              │
│    (Screens, Widgets, UI Logic)         │
├─────────────────────────────────────────┤
│         Business Logic Layer            │
│      (Services, State Management)       │
├─────────────────────────────────────────┤
│          Data Layer                     │
│    (Models, Firebase Integration)       │
└─────────────────────────────────────────┘
```

## Design Patterns

### 1. Service Pattern
Services encapsulate business logic and external API calls:
- `AuthService`: Handles authentication operations
- `FirestoreService`: Manages database operations

**Benefits:**
- Reusable across screens
- Easy to test
- Clear separation of concerns

### 2. Provider Pattern (State Management)
Using Flutter's Provider package for state management:
- Dependency injection
- Rebuild optimization
- Easy access to services

### 3. Repository Pattern
Firestore collections act as repositories:
- `books`: Product catalog
- `users`: User profiles
- `orders`: Order history
- `cart` (subcollection): Shopping cart
- `wishlist` (subcollection): User wishlist

## Project Structure

```
lib/
├── main.dart                    # App entry point, routing, theme
│
├── models/                      # Data models (Plain Dart Objects)
│   ├── book.dart               # Book entity
│   ├── user_profile.dart       # User profile entity
│   ├── cart_item.dart          # Cart item entity
│   ├── wishlist_item.dart      # Wishlist item entity
│   └── order.dart              # Order and OrderItem entities
│
├── services/                    # Business logic layer
│   ├── auth_service.dart       # Authentication operations
│   │   - signUp()
│   │   - signIn()
│   │   - signOut()
│   │   - getUserProfile()
│   │   - updateUserProfile()
│   │
│   └── firestore_service.dart  # Database operations
│       - getBooks()
│       - getBooksByCategory()
│       - addToCart()
│       - addToWishlist()
│       - createOrder()
│       - getUserOrders()
│
├── screens/                     # UI screens
│   ├── auth/
│   │   ├── login_screen.dart   # Login UI
│   │   └── signup_screen.dart  # Registration UI
│   │
│   ├── home/
│   │   └── home_screen.dart    # Main home with bottom navigation
│   │
│   ├── book/
│   │   └── book_details_screen.dart  # Book detail view
│   │
│   ├── cart/
│   │   └── cart_screen.dart    # Shopping cart
│   │
│   ├── wishlist/
│   │   └── wishlist_screen.dart  # Wishlist
│   │
│   ├── checkout/
│   │   └── checkout_screen.dart  # Checkout process
│   │
│   ├── orders/
│   │   └── orders_screen.dart   # Order history
│   │
│   └── profile/
│       └── profile_screen.dart  # User profile management
│
└── utils/                       # Utilities and constants
    ├── constants.dart          # App constants, colors
    └── helpers.dart            # Helper functions
```

## Data Flow

### Authentication Flow
```
LoginScreen → AuthService.signIn() → Firebase Auth → User Object
    ↓
AuthWrapper (StreamBuilder) listens to auth state changes
    ↓
Redirects to HomeScreen or LoginScreen
```

### Book Browsing Flow
```
HomeScreen → FirestoreService.getBooks() → Firestore 'books' collection
    ↓
StreamBuilder updates UI with book list
    ↓
User taps book → Navigate to BookDetailsScreen
```

### Add to Cart Flow
```
BookDetailsScreen → User clicks "Add to Cart"
    ↓
FirestoreService.addToCart(userId, book, quantity)
    ↓
Firestore users/{userId}/cart/{bookId}
    ↓
Success message shown to user
```

### Checkout Flow
```
CartScreen → User clicks "Checkout"
    ↓
CheckoutScreen → User fills shipping info
    ↓
FirestoreService.createOrder() → Firestore 'orders' collection
    ↓
FirestoreService.clearCart() → Clear user's cart
    ↓
Navigate back to home → Show success message
```

## State Management

### Provider Architecture

```dart
MaterialApp
  └── MultiProvider
       ├── Provider<AuthService>
       └── Provider<FirestoreService>
            └── MaterialApp
                 └── AuthWrapper (StreamBuilder<User?>)
                      ├── LoginScreen (if not authenticated)
                      └── HomeScreen (if authenticated)
```

### Stream-based Real-time Updates

Most screens use `StreamBuilder` for real-time data:
- Book list updates automatically when Firestore changes
- Cart updates in real-time
- Order status changes reflect immediately

## Firebase Integration

### Collections Structure

```
Firestore Database
│
├── books/                          # Main book catalog
│   └── {bookId}
│       ├── title: string
│       ├── author: string
│       ├── description: string
│       ├── price: number
│       ├── category: string
│       ├── imageUrl: string
│       ├── rating: number
│       ├── reviewCount: number
│       ├── isbn: string
│       └── stock: number
│
├── users/                          # User profiles
│   └── {userId}
│       ├── email: string
│       ├── name: string
│       ├── phone: string
│       ├── address: string
│       ├── city: string
│       ├── state: string
│       ├── zipCode: string
│       └── createdAt: timestamp
│       │
│       ├── cart/                  # User's cart (subcollection)
│       │   └── {bookId}
│       │       ├── bookId: string
│       │       ├── title: string
│       │       ├── author: string
│       │       ├── price: number
│       │       ├── imageUrl: string
│       │       └── quantity: number
│       │
│       └── wishlist/              # User's wishlist (subcollection)
│           └── {bookId}
│               ├── bookId: string
│               ├── title: string
│               ├── author: string
│               ├── price: number
│               ├── imageUrl: string
│               └── addedAt: timestamp
│
└── orders/                        # All orders
    └── {orderId}
        ├── userId: string
        ├── items: array
        │   └── {
        │       bookId: string,
        │       title: string,
        │       author: string,
        │       price: number,
        │       quantity: number
        │   }
        ├── totalAmount: number
        ├── shippingAddress: string
        ├── city: string
        ├── state: string
        ├── zipCode: string
        ├── phone: string
        ├── status: string
        ├── createdAt: timestamp
        └── deliveredAt: timestamp (nullable)
```

## UI/UX Design

### Theme
- **Primary Color**: Indigo (#6366F1)
- **Secondary Color**: Purple (#8B5CF6)
- **Design System**: Material Design 3
- **Typography**: System default with custom sizing

### Navigation
- Bottom Navigation Bar with 4 tabs:
  1. Home (Browse books)
  2. Wishlist
  3. Orders
  4. Profile
- Stack-based navigation for detail screens

### Key UI Components

1. **Book Card**: Grid item showing book cover, title, author, price
2. **Cart Item Card**: Horizontal card with book info and quantity controls
3. **Wishlist Item Card**: Similar to cart but with add date
4. **Order Card**: Expandable card showing order details and status

## Security Considerations

### Firestore Security Rules (Production)

```javascript
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    // Helper function to check if user is authenticated
    function isSignedIn() {
      return request.auth != null;
    }
    
    // Helper function to check if user owns the resource
    function isOwner(userId) {
      return isSignedIn() && request.auth.uid == userId;
    }
    
    // Users can only read/write their own data
    match /users/{userId} {
      allow read: if isOwner(userId);
      allow write: if isOwner(userId);
      
      match /cart/{cartItem} {
        allow read, write: if isOwner(userId);
      }
      
      match /wishlist/{wishlistItem} {
        allow read, write: if isOwner(userId);
      }
    }
    
    // Books are readable by all authenticated users
    match /books/{bookId} {
      allow read: if isSignedIn();
      allow write: if false; // Only admins via backend
    }
    
    // Orders
    match /orders/{orderId} {
      allow read: if isSignedIn() && 
                    resource.data.userId == request.auth.uid;
      allow create: if isSignedIn() && 
                     request.resource.data.userId == request.auth.uid;
      allow update, delete: if false; // Only admins
    }
  }
}
```

### Authentication Security
- Passwords handled by Firebase (bcrypt hashing)
- No password storage in app
- Email verification can be enabled
- Password reset via email

## Performance Optimization

### Current Optimizations
1. **Image Caching**: Using `cached_network_image` package
2. **Pagination Ready**: Structure supports pagination (not implemented yet)
3. **Indexed Queries**: Category filtering uses Firestore indexes
4. **Stream Efficiency**: StreamBuilders only rebuild when data changes

### Future Optimizations
- Implement pagination for large book lists
- Add image optimization/resizing
- Implement caching for frequently accessed data
- Add offline support with local database

## Testing Strategy

### Unit Tests
- Test models (serialization/deserialization)
- Test service methods
- Test helper functions

### Widget Tests
- Test individual screens
- Test form validation
- Test navigation

### Integration Tests
- Test complete user flows
- Test Firebase integration
- Test error handling

## Extensibility

The architecture supports easy addition of:

### New Features
- **Search**: Add search method to FirestoreService
- **Reviews**: Add reviews subcollection to books
- **Favorites**: Already have wishlist infrastructure
- **Payment**: Add payment service layer
- **Notifications**: Add FCM integration
- **Admin Panel**: Add admin-specific screens and services

### New Models
Simply create a new model in `models/` and add corresponding service methods.

### New Screens
Follow existing screen structure and use Provider for service access.

## Best Practices Implemented

✅ Separation of concerns (models, services, UI)  
✅ Single Responsibility Principle  
✅ DRY (Don't Repeat Yourself)  
✅ Consistent naming conventions  
✅ Error handling with try-catch  
✅ User feedback with SnackBars  
✅ Loading states for async operations  
✅ Form validation  
✅ Responsive UI design  
✅ Material Design guidelines  

## Development Workflow

1. **Feature Development**
   - Create/update models if needed
   - Add service methods
   - Build UI screens
   - Test functionality
   - Update documentation

2. **Code Review Checklist**
   - [ ] Error handling implemented
   - [ ] Loading states shown
   - [ ] User feedback provided
   - [ ] Code follows conventions
   - [ ] No hardcoded values
   - [ ] Comments for complex logic

3. **Deployment Checklist**
   - [ ] Update Firestore rules
   - [ ] Test all user flows
   - [ ] Check performance
   - [ ] Update version number
   - [ ] Create release notes

---

This architecture provides a solid foundation for a scalable, maintainable e-commerce application.
