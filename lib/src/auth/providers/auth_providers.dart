
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


final emailControllerProvider = Provider<TextEditingController>((ref) {
  return TextEditingController();
});

final nameControllerProvider = Provider<TextEditingController>((ref) {
  return TextEditingController();
});

final passwordControllerProvider = Provider<TextEditingController>((ref) {
  return TextEditingController();
});

// Switch Between Sign In and Sign Up
final authPageControllerProvider = Provider<PageController>((ref) {
  return PageController();
});


final usernameProvider = StateProvider<String>((ref) => 'User');
