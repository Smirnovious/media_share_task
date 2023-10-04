import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../view/widgets/auth_error_dialog.dart';
import '../providers/auth_providers.dart';

class AuthRepository {
  final authClient = FirebaseAuth.instance;
  final client = FirebaseFirestore.instance;

  // Sign Up
  Future<void> signUp(ref, context) async {
    try {
      await authClient.createUserWithEmailAndPassword(
        email: ref.read(emailControllerProvider).text,
        password: ref.read(passwordControllerProvider).text,
      );
      await saveUserInDB();
      GoRouter.of(context).go('/');
    } on FirebaseAuthException catch (e) {
      showDialog(
          context: context,
          builder: (context) => AuthErrorDialog(description: e.message!));
    }
  }

  /// Sign In
  Future<void> signIn(ref, context) async {
    try {
      await authClient.signInWithEmailAndPassword(
        email: ref.read(emailControllerProvider).text,
        password: ref.read(passwordControllerProvider).text,
      );
    } on FirebaseAuthException catch (e) {
      showDialog(
          context: context,
          builder: (context) => AuthErrorDialog(description: e.message!));
    }
  }

  // Save User in DB
  Future<void> saveUserInDB() async {
    final user = authClient.currentUser;
    final userCollection = client.collection('users');
    final userId = userCollection.doc(user!.uid);
    await userId.set({
      'email': user.email,
      'uid': user.uid,
    });
  }

  Future<void> signOut() async {
    await authClient.signOut();
  }

  Stream<User?> get authStateChanges => authClient.authStateChanges();
}

// Instance of AuthRepository

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepository();
});
