# Firebase Setup Guide

This guide will help you set up Firebase and Firestore for the BookStore e-commerce app.

## Prerequisites

- Flutter SDK installed
- A Google account
- Android Studio or VS Code with Flutter extension

## Step 1: Create a Firebase Project

1. Go to [Firebase Console](https://console.firebase.google.com/)
2. Click on "Add project"
3. Enter a project name (e.g., "BookStore App")
4. Follow the prompts to create your project

## Step 2: Add Android App to Firebase

1. In your Firebase project dashboard, click the Android icon to add an Android app
2. Register your app with the package name from `android/app/build.gradle` (default: `com.example.ecomm_app`)
3. Download the `google-services.json` file
4. Place it in the `android/app/` directory

## Step 3: Add iOS App to Firebase (Optional)

1. Click the iOS icon in Firebase dashboard
2. Register your app with Bundle ID from `ios/Runner/Info.plist`
3. Download the `GoogleService-Info.plist` file
4. Place it in the `ios/Runner/` directory

## Step 4: Configure Android

Add the following to `android/build.gradle` (project level):

```gradle
buildscript {
    dependencies {
        classpath 'com.google.gms:google-services:4.4.0'
    }
}
```

Add the following to `android/app/build.gradle` (app level):

At the top after other plugins:
```gradle
apply plugin: 'com.google.gms.google-services'
```

Update `minSdkVersion` to at least 21 in `android/app/build.gradle`:
```gradle
defaultConfig {
    minSdkVersion 21
    ...
}
```

## Step 5: Enable Firebase Services

In Firebase Console:

### Authentication
1. Go to "Authentication" in the left sidebar
2. Click "Get Started"
3. Enable "Email/Password" sign-in method

### Firestore Database
1. Go to "Firestore Database" in the left sidebar
2. Click "Create database"
3. Choose "Start in test mode" for development (change to production rules later)
4. Select a location closest to your users
5. Click "Enable"

### Security Rules (Development)

For development, use these Firestore rules:

```javascript
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    // Users collection
    match /users/{userId} {
      allow read: if request.auth != null;
      allow write: if request.auth != null && request.auth.uid == userId;
      
      // User's cart
      match /cart/{cartItemId} {
        allow read, write: if request.auth != null && request.auth.uid == userId;
      }
      
      // User's wishlist
      match /wishlist/{wishlistItemId} {
        allow read, write: if request.auth != null && request.auth.uid == userId;
      }
    }
    
    // Books collection (read for all authenticated users)
    match /books/{bookId} {
      allow read: if request.auth != null;
      allow write: if false; // Only admins should write, set up admin rules
    }
    
    // Orders collection
    match /orders/{orderId} {
      allow read: if request.auth != null && 
                  resource.data.userId == request.auth.uid;
      allow create: if request.auth != null;
      allow update, delete: if false; // Only admins should modify orders
    }
  }
}
```

### Security Rules (Production)

For production, use more restrictive rules and add proper validation.

## Step 6: Populate Database with Sample Books

In Firestore Console, create a collection named `books` and add documents with the following structure:

```json
{
  "title": "The Great Gatsby",
  "author": "F. Scott Fitzgerald",
  "description": "A classic American novel set in the Jazz Age.",
  "price": 12.99,
  "category": "Fiction",
  "imageUrl": "https://example.com/gatsby.jpg",
  "rating": 4.5,
  "reviewCount": 1250,
  "isbn": "978-0-7432-7356-5",
  "stock": 45
}
```

### Sample Categories and Books

Add at least a few books in each category:

**Fiction:**
- The Great Gatsby by F. Scott Fitzgerald ($12.99)
- To Kill a Mockingbird by Harper Lee ($14.99)
- 1984 by George Orwell ($13.99)

**Non-Fiction:**
- Sapiens by Yuval Noah Harari ($18.99)
- Educated by Tara Westover ($16.99)

**Science:**
- A Brief History of Time by Stephen Hawking ($15.99)
- The Selfish Gene by Richard Dawkins ($14.99)

**Technology:**
- Clean Code by Robert C. Martin ($42.99)
- The Pragmatic Programmer by Andrew Hunt ($39.99)

**Biography:**
- Steve Jobs by Walter Isaacson ($16.99)
- Becoming by Michelle Obama ($19.99)

**Business:**
- The Lean Startup by Eric Ries ($24.99)
- Zero to One by Peter Thiel ($22.99)

You can use placeholder images from:
- https://via.placeholder.com/400x600?text=Book+Cover
- Or find book cover images from free sources

## Step 7: Configure FlutterFire

Run the following command in your project root:

```bash
flutter pub get
```

## Step 8: Test Your Setup

1. Run the app: `flutter run`
2. Try signing up with a test email
3. Add sample books to the database
4. Test the cart, wishlist, and checkout features

## Environment Variables (Optional)

For sensitive configuration, consider using environment variables or a config file that's not committed to version control.

## Troubleshooting

### Common Issues:

1. **Build fails on Android**: Make sure you have added `google-services.json` to `android/app/`
2. **Authentication not working**: Verify that Email/Password is enabled in Firebase Console
3. **Firestore permission denied**: Check your security rules allow authenticated access
4. **No books showing**: Make sure you've added books to the `books` collection in Firestore

## Additional Configuration

### For Web Support

1. In Firebase Console, add a Web app
2. Copy the Firebase configuration
3. Create `web/firebase-config.js` with your configuration
4. Update `web/index.html` to include Firebase SDK

### For Storage (Profile Pictures)

1. Enable Firebase Storage in Firebase Console
2. Set up storage rules similar to Firestore
3. Update the app to use Storage for image uploads

## Production Checklist

Before deploying to production:

- [ ] Update Firestore security rules to production-ready rules
- [ ] Enable Firebase App Check for additional security
- [ ] Set up proper indexes for complex queries
- [ ] Configure backup and restore procedures
- [ ] Set up monitoring and alerts
- [ ] Review and optimize pricing based on usage
- [ ] Add admin functionality to manage books and orders
- [ ] Implement proper error tracking (e.g., Firebase Crashlytics)

## Support

For more information, visit:
- [Firebase Documentation](https://firebase.google.com/docs)
- [FlutterFire Documentation](https://firebase.flutter.dev/)
