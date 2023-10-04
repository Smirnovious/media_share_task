import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:media_share_task/src/auth/api/auth_repository.dart';
import 'package:media_share_task/src/auth/view/auth_screen.dart';

import '../media/view/media_screen.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
        stream: ref.read(authRepositoryProvider).authStateChanges,
        builder: (context, snapshot) {
          final user = snapshot.data;
          if (user == null) {
            return const AuthScreen();
          } else {
            return const MediaScreen();
          }
        });
  }
}
