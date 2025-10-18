# Quick Start Guide

This guide will help you get the BookStore app up and running quickly.

## Prerequisites

✅ Flutter SDK 3.0.0 or higher  
✅ Dart SDK 3.0.0 or higher  
✅ Android Studio or VS Code with Flutter extension  
✅ Firebase account (free tier is sufficient)  
✅ Git installed  

## Step-by-Step Setup (15 minutes)

### 1. Clone and Setup Flutter Project (2 minutes)

```bash
# Clone the repository
git clone https://github.com/Aliroohan179/ecomm_app.git
cd ecomm_app

# Install dependencies
flutter pub get

# Verify Flutter installation
flutter doctor
```

### 2. Create Firebase Project (3 minutes)

1. Go to [Firebase Console](https://console.firebase.google.com/)
2. Click **"Add project"**
3. Enter project name: **"BookStore"** (or your preferred name)
4. Disable Google Analytics (optional for now)
5. Click **"Create project"**

### 3. Configure Firebase for Android (5 minutes)

1. In Firebase Console, click the **Android icon** to add an Android app
2. Enter package name: `com.example.ecomm_app`
3. Click **"Register app"**
4. Download `google-services.json`
5. Place it in: `android/app/google-services.json`

### 4. Enable Firebase Services (3 minutes)

#### Enable Authentication:
1. In Firebase Console → **Authentication**
2. Click **"Get Started"**
3. Select **"Email/Password"**
4. Toggle to **Enable**
5. Click **"Save"**

#### Enable Firestore:
1. In Firebase Console → **Firestore Database**
2. Click **"Create database"**
3. Select **"Start in test mode"** (for development)
4. Choose your preferred location
5. Click **"Enable"**

### 5. Add Sample Books (2 minutes)

1. In Firestore Console, you should now see the database
2. Click **"Start collection"**
3. Collection ID: `books`
4. Add your first book:
   - Let Firebase auto-generate the Document ID
   - Add these fields manually:

```
title (string): "The Great Gatsby"
author (string): "F. Scott Fitzgerald"
description (string): "A classic American novel set in the Jazz Age."
price (number): 12.99
category (string): "Fiction"
imageUrl (string): "https://via.placeholder.com/400x600?text=The+Great+Gatsby"
rating (number): 4.5
reviewCount (number): 1250
isbn (string): "978-0-7432-7356-5"
stock (number): 45
```

5. Click **"Save"**
6. Repeat for more books using data from `SAMPLE_DATA.md`

**Quick Tip:** Add at least 3-5 books to see the app in action!

### 6. Run the App! 🚀

```bash
# Make sure you have an Android emulator running or device connected
flutter devices

# Run the app
flutter run
```

## Testing the App

### Test User Registration:
1. Launch the app
2. Click **"Sign Up"**
3. Enter:
   - Name: Test User
   - Email: test@example.com
   - Password: test123 (or any password 6+ characters)
4. Click **"Sign Up"**

### Test Features:
✅ Browse books on home screen  
✅ Filter by category  
✅ Tap a book to view details  
✅ Add book to cart  
✅ Add book to wishlist (heart icon)  
✅ View cart (cart icon in top bar)  
✅ Update quantities in cart  
✅ Proceed to checkout  
✅ Enter shipping information  
✅ Place order  
✅ View orders in Orders tab  
✅ Update profile in Profile tab  

## Common Issues & Solutions

### Issue: Build fails with "google-services.json not found"
**Solution:** Make sure you placed `google-services.json` in `android/app/` directory

### Issue: "Permission denied" when accessing Firestore
**Solution:** 
- Check that Firestore is in "test mode"
- Or update security rules to allow authenticated reads/writes

### Issue: No books showing on home screen
**Solution:** 
- Make sure you added books to the `books` collection in Firestore
- Check that book documents have all required fields

### Issue: Authentication not working
**Solution:**
- Verify Email/Password is enabled in Firebase Authentication
- Check that you're using a valid email format

### Issue: Flutter not found
**Solution:**
```bash
# On Windows: Add Flutter to PATH
# On Mac/Linux:
export PATH="$PATH:[PATH_TO_FLUTTER_DIRECTORY]/flutter/bin"
```

## Next Steps

### For Development:
- Read through `README.md` for detailed documentation
- Check `FIREBASE_SETUP.md` for advanced Firebase configuration
- Add more sample books from `SAMPLE_DATA.md`
- Customize colors in `lib/utils/constants.dart`

### For Production:
- Update Firestore security rules (see `FIREBASE_SETUP.md`)
- Add real book cover images
- Set up proper error tracking
- Configure app icons and splash screens
- Add payment integration
- Submit to app stores

## Project Structure Overview

```
lib/
├── main.dart              # Entry point
├── models/                # Data models
├── services/              # Firebase services
├── screens/               # UI screens
│   ├── auth/             # Login/Signup
│   ├── home/             # Home screen
│   ├── book/             # Book details
│   ├── cart/             # Shopping cart
│   ├── wishlist/         # Wishlist
│   ├── checkout/         # Checkout
│   ├── orders/           # Order history
│   └── profile/          # User profile
└── utils/                 # Utilities
```

## Getting Help

- 📖 Read the full [README.md](README.md)
- 🔥 Check [FIREBASE_SETUP.md](FIREBASE_SETUP.md) for Firebase details
- 📚 View [SAMPLE_DATA.md](SAMPLE_DATA.md) for more book examples
- 🐛 Open an issue on GitHub for bugs
- 💬 Ask questions in Discussions

## Summary

You should now have:
- ✅ A working Flutter e-commerce bookstore app
- ✅ Firebase Authentication set up
- ✅ Firestore database with sample books
- ✅ Ability to browse, cart, wishlist, checkout, and manage orders

**Congratulations! You're ready to start building! 🎉**

---

**Time to completion:** ~15 minutes  
**Difficulty:** Beginner-friendly  
**Prerequisites:** Basic Flutter knowledge helpful but not required
