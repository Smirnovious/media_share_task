import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:media_share_task/src/auth/api/auth_repository.dart';
import 'package:media_share_task/src/auth/view/widgets/custom_text_field.dart';
import 'package:media_share_task/src/shared_pref.dart';
import '../../providers/auth_providers.dart';
import 'auth_button.dart';

class SignUpPage extends ConsumerWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final signUpFormKey = GlobalKey<FormState>();
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Icon(
              Icons.person_add,
              size: 100,
            ),
            const Gap(20),
            Text(
              'Sign Up',
              style: Theme.of(context).textTheme.displayLarge,
            ),
            const Gap(50),
            Form(
              key: signUpFormKey,
              child: Column(
                children: [
                  CustomTextField(
                    icon: Icons.person,
                    hintText: 'Name',
                    controller: ref.read(nameControllerProvider),
                  ),
                  const Gap(20),
                  CustomTextField(
                    icon: Icons.email,
                    hintText: 'Email',
                    controller: ref.read(emailControllerProvider),
                  ),
                  const Gap(20),
                  CustomTextField(
                    icon: Icons.lock,
                    hintText: 'Password',
                    hideString: true,
                    controller: ref.read(passwordControllerProvider),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  AuthButton(
                    buttonLabel: 'Sign Up',
                    onPressed: () {
                      if (signUpFormKey.currentState!.validate()) {
                        SharedPref.setUsername(
                            ref.read(nameControllerProvider).text);
                        ref.read(authRepositoryProvider).signUp(ref, context);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Processing Data'),
                          ),
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
