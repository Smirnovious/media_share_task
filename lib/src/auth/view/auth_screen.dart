import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../common/main_app_bar.dart';
import '../providers/auth_providers.dart';
import 'widgets/login_page.dart';
import 'widgets/sign_up_page.dart';

class AuthScreen extends ConsumerWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.watch(authPageControllerProvider);
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: MainAppBar(logOutVisible: false),
      ),
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: controller,
        children: const [
          LoginPage(),
          SignUpPage(),
        ],
      ),
    );
  }
}
