import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:media_share_task/firebase_options.dart';
import 'package:media_share_task/theme/light_theme.dart';
import 'package:rive/rive.dart';

import 'theme/dark_theme.dart';
import 'theme/theme_providers.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(toggleThemeProvider);
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ref.read(toggleThemeProvider) ? darkTheme : lightTheme,
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends ConsumerWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final toggleTheme = ref.watch(toggleThemeProvider);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
              onPressed: () {
                ref.read(toggleThemeProvider.notifier).state = !toggleTheme;
              },
              icon: Icon(
                toggleTheme ? Icons.dark_mode : Icons.light_mode,
              ),
            ),
          )
        ],
      ),
      backgroundColor: Theme.of(context).colorScheme.background,
      body: const Center(
        child: Text(
          'Hello World',
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
