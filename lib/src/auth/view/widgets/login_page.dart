import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:media_share_task/src/auth/view/widgets/custom_text_field.dart';
import 'auth_button.dart';
import '../../providers/auth_providers.dart';
import '../../api/auth_repository.dart';

class LoginPage extends ConsumerWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loginFormKey = GlobalKey<FormState>();
    return SingleChildScrollView(
      child: Column(
        children: [
          const Icon(
            Icons.login,
            size: 100,
          ),
          const Gap(20),
          Text(
            'Login',
            style: Theme.of(context).textTheme.displayLarge,
          ),
          const Gap(50),
          Form(
              key: loginFormKey,
              child: Column(
                children: [
                  CustomTextField(
                    icon: Icons.email,
                    hintText: 'Email',
                    controller: ref.read(emailControllerProvider),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomTextField(
                    hideString: true,
                    icon: Icons.lock,
                    hintText: 'Password',
                    controller: ref.read(passwordControllerProvider),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  AuthButton(
                    buttonLabel: 'Login',
                    onPressed: () {
                      if (loginFormKey.currentState!.validate()) {
                        ref.read(authRepositoryProvider).signIn(ref, context);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Processing Data'),
                          ),
                        );
                      }
                    },
                  ),
                  const Gap(20),
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                  ),
                  const Gap(5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Don\'t have an account?',
                          style: Theme.of(context).textTheme.displaySmall),
                      TextButton(
                        onPressed: () {
                          ref.read(authPageControllerProvider).nextPage(
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.easeIn);
                        },
                        child: Text('Sign Up',
                            style: Theme.of(context).textTheme.displaySmall),
                      )
                    ],
                  )
                ],
              ))
        ],
      ),
    );
  }
}
