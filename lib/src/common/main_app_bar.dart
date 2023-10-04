import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../auth/api/auth_repository.dart';
import '../theme/theme_providers.dart';

class MainAppBar extends ConsumerWidget {
  const MainAppBar({super.key, this.logOutVisible = true});
  final bool logOutVisible;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final toggleTheme = ref.watch(toggleThemeProvider);
    return AppBar(
      surfaceTintColor: Colors.transparent,
      backgroundColor: Colors.transparent,
      leading: Visibility(
          visible: logOutVisible,
          child: IconButton(
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                        title: const Text('Log Out',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            )),
                        content:
                            const Text('Are you sure you want to log out?'),
                        actions: [
                          TextButton(
                              onPressed: () {
                                ref.read(authRepositoryProvider).signOut();
                                
                                Navigator.of(context).pop();
                              },
                              child: const Text('Yes')),
                          TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: const Text('No')),
                        ],
                      ));
            },
            icon: const Icon(Icons.logout),
          )),
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
    );
  }
}
