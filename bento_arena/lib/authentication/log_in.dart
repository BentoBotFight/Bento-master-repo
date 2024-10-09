import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:gap/gap.dart';
import 'package:hugeicons/hugeicons.dart';

import '../theme/color.dart';
import 'auth.dart';
import 'components/auth_button.dart';
import 'components/text_field.dart';

class log_in extends StatefulWidget {
  const log_in({super.key, required this.onTap});
  final Function()? onTap;
  @override
  State<log_in> createState() => _log_inState();
}

class _log_inState extends State<log_in> {
  // Text editing controllers
  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  Future<void> signUserIn() async {
    // show loading screen
    showDialog(
        context: context,
        builder: (context) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        });
    // try sign in
    try {
      if (emailController.text.contains('@')) {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: emailController.text, password: passwordController.text);
      } else {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: '${emailController.text}@bento-user.tech',
            password: passwordController.text);
      }
      // pop the loading circle
      Navigator.pop(context);
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const auth_page()));
    } on FirebaseAuthException catch (e) {
      print('${e.code}is the issue');
      if (e.code == 'invalid-credential') {
        ScaffoldMessenger.of(context).showSnackBar(WrongCredentials);
      } else if (e.code == 'invalid-email') {
        ScaffoldMessenger.of(context).showSnackBar(WrongEmail);
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('Incorrect login')));
      }
      // pop the loading circle
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Login',
            style: Theme.of(context)
                .textTheme
                .headlineSmall!
                .copyWith(color: AppColors.black),
          ),
          leading: GestureDetector(
            child: const HugeIcon(
              icon: HugeIcons.strokeRoundedArrowLeft01,
              color: AppColors.black,
            ),
            onTap: () {
              Navigator.pop(context);
            },
          ),

          //put slider here
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset(
                    'assets/authentication/page1_logo.png',
                    height: 65,
                  ).animate().fadeIn(duration: 1000.ms),
                  const Gap(16),
                  Text(
                    'Hey there, good to see you back. Are you ready to do some good old robots?',
                    style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                          color: AppColors.black,
                        ),
                  ).animate(delay: 1000.ms).fadeIn(duration: 1000.ms).then(),
                  const Gap(20),
                  Text(
                    'Enter your email',
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          color: AppColors.black,
                        ),
                  ),
                  const Gap(8),
                  TextField(
                    controller: emailController,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(18),
                          borderSide: BorderSide.none,
                        ),
                        fillColor: AppColors.lightGrey,
                        filled: true),
                  ),
                  const Gap(20),
                  Text(
                    'Enter your password',
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          color: AppColors.black,
                        ),
                  ),
                  const Gap(8),
                  TextField(
                    controller: passwordController,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(18),
                          borderSide: BorderSide.none,
                        ),
                        fillColor: AppColors.lightGrey,
                        filled: true),
                  ),
                  const Gap(8),
                  Text('Let your imagination run wild, love',
                      style: Theme.of(context).textTheme.titleSmall!.copyWith(
                            color: AppColors.grey,
                          ))
                ],
              ),
            ),
          ),
        ),
        floatingActionButton: GestureDetector(
          child: const HugeIcon(
            icon: HugeIcons.strokeRoundedCircleArrowRight01,
            color: AppColors.comfyGreenText,
            size: 60.0,
          ),
          onTap: () {
            signUserIn();
          },
        ));
  }
}

var WrongCredentials =
    const SnackBar(content: Text('Wrong username or password'));
var WrongEmail = const SnackBar(content: Text('Email entered is not valid'));
