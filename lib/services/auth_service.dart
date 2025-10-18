import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/user_profile.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  User? get currentUser => _auth.currentUser;
  Stream<User?> get authStateChanges => _auth.authStateChanges();

  // Sign up with email and password
  Future<User?> signUp({
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      User? user = result.user;

      if (user != null) {
        // Create user profile
        await _firestore.collection('users').doc(user.uid).set({
          'email': email,
          'name': name,
          'phone': '',
          'address': '',
          'city': '',
          'state': '',
          'zipCode': '',
          'photoUrl': '',
          'createdAt': DateTime.now().millisecondsSinceEpoch,
        });
      }
      return user;
    } catch (e) {
      throw Exception('Sign up failed: ${e.toString()}');
    }
  }

  // Sign in with email and password
  Future<User?> signIn({
    required String email,
    required String password,
  }) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return result.user;
    } catch (e) {
      throw Exception('Sign in failed: ${e.toString()}');
    }
  }

  // Sign out
  Future<void> signOut() async {
    try {
      await _auth.signOut();
    } catch (e) {
      throw Exception('Sign out failed: ${e.toString()}');
    }
  }

  // Get user profile
  Future<UserProfile?> getUserProfile(String userId) async {
    try {
      DocumentSnapshot doc =
          await _firestore.collection('users').doc(userId).get();
      if (doc.exists) {
        return UserProfile.fromMap(
            doc.data() as Map<String, dynamic>, doc.id);
      }
      return null;
    } catch (e) {
      throw Exception('Failed to get user profile: ${e.toString()}');
    }
  }

  // Update user profile
  Future<void> updateUserProfile(
      String userId, Map<String, dynamic> data) async {
    try {
      await _firestore.collection('users').doc(userId).update(data);
    } catch (e) {
      throw Exception('Failed to update user profile: ${e.toString()}');
    }
  }

  // Reset password
  Future<void> resetPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } catch (e) {
      throw Exception('Failed to send password reset email: ${e.toString()}');
    }
  }
}
