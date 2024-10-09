import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:bento_arena/controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:gap/gap.dart';
import 'package:hugeicons/hugeicons.dart';

import '../theme/color.dart';
import '../user_information/userIdentifier.dart';
import 'components/option_block.dart';


class register_page extends StatefulWidget {
  const register_page({
    super.key,
  });

  //final Function()? onTap;
  @override
  State<register_page> createState() => _register_pageState();
}

class _register_pageState extends State<register_page> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController userDescriptionController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Create an account',
            style: Theme.of(context)
                .textTheme
                .headlineSmall!
                .copyWith(color: AppColors.black),
          ),
          leading: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: const HugeIcon(
                icon: HugeIcons.strokeRoundedArrowLeft01,
                color: AppColors.black,
              )),

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
                    'assets/img/page1_logo.png',
                    height: 65,
                  ).animate().fadeIn(duration: 1000.ms),
                  const Gap(16),
                  Text(
                    'Hey there, I’m Comfy. Let’s get started with your robotics journey',
                    style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                          color: AppColors.black,
                        ),
                  ).animate(delay: 1000.ms).fadeIn(duration: 1000.ms).then(),
                  const Gap(20),
                  Text(
                    'What should I call you?',
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          color: AppColors.black,
                        ),
                  ),
                  const Gap(8),
                  TextField(
                    controller: usernameController,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(18),
                          borderSide: BorderSide.none,
                        ),
                        fillColor: AppColors.lightGrey,
                        filled: true),
                  ),
                  const Gap(8),
                  Text('You can change this later',
                      style: Theme.of(context).textTheme.titleSmall!.copyWith(
                            color: AppColors.grey,
                          )),
                  const Gap(20),
                  Text(
                    'Describe yourself in 1 sentence',
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          color: AppColors.black,
                        ),
                  ),
                  const Gap(8),
                  TextField(
                    controller: userDescriptionController,
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
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => purpose_here(
                          name: usernameController.text,
                          description: userDescriptionController.text,
                        )));
          },
        ));
  }
  /*Widget build(BuildContext context) {
    return const Scaffold(
      body: chatPage(
          questions: {
            'name':['Welcome to your robotics journey!', 'How should we call you?'],
            'tagline': ['In two sentences, describe yourself and why you are here'],
            'email': ['Great! Enter an email to create your account'],
            'password': ['Enter a password (min. 8 characters)']
          },
          answers: {},
          title: 'Create an account',
          pageName: 'register_new_user')
    );
  }*/
}

class purpose_here extends StatefulWidget {
  const purpose_here(
      {super.key, required this.name, required this.description});
  final String name;
  final String description;
  @override
  State<purpose_here> createState() => _purpose_hereState();
}

class _purpose_hereState extends State<purpose_here> {
  Map<String, bool> purpose = {
    'Enjoy some comfy entertainment': false,
    'Battle robots from anywhere in the world': false,
    'Learn more about robotics in general': false,
    'I think Thomas is cool': false,
  };
  List<Map<String, dynamic>> purpose_cards = [
    {
      'message': 'Enjoy some comfy entertainment',
      'icon': HugeIcons.strokeRoundedGameController03,
      'color': AppColors.lighterGreen,
    },
    {
      'message': 'Engage in robot battles from anywhere in the world',
      'icon': HugeIcons.strokeRoundedBoxingGlove,
      'color': AppColors.peachBackground,
    },
    {
      'message': 'Learn more about robotics in general',
      'icon': HugeIcons.strokeRoundedOnlineLearning04,
      'color': AppColors.blueBackground,
    },
    {
      'message': 'I think Thomas is cool',
      'icon': HugeIcons.strokeRoundedNerd,
      'color': AppColors.yellowBackground,
    }
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Create an account',
            style: Theme.of(context)
                .textTheme
                .headlineSmall!
                .copyWith(color: AppColors.black),
          ),
          leading: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: const HugeIcon(
                icon: HugeIcons.strokeRoundedArrowLeft01,
                color: AppColors.black,
              )),

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
                    'assets/img/page1_logo.png',
                    height: 65,
                  ).animate().fadeIn(duration: 1000.ms),
                  const Gap(16),
                  Text(
                    'Nice to meet you ${widget.name}, here are few things I can help you with. ',
                    style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                          color: AppColors.black,
                        ),
                  ).animate(delay: 1000.ms).fadeIn(duration: 1000.ms).then(),
                  const Gap(20),
                  Text(
                    'Let me know what are you interested in',
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          color: AppColors.black,
                        ),
                  ),
                  const Gap(16),
                  IgnorePointer(
                    ignoring: true,
                    child: Container(
                      child: LayoutBuilder(
                        builder: (context, constraints) {
                          double cardWidth = 150; // Minimum width of each card
                          int crossAxisCount = (constraints.maxWidth / cardWidth).floor();
                          crossAxisCount = crossAxisCount.clamp(2, 4); // Ensure at least 2 and at most 4 cards per row

                          return GridView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: crossAxisCount,
                              childAspectRatio: 1, // Adjust this for card height
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 10,
                            ),
                            itemCount: 4, // Total number of cards
                            itemBuilder: (context, index) {
                              return option_block(
                                message: purpose_cards[index]['message'],
                                icon: purpose_cards[index]['icon'],
                                onTap: () {
                                  purpose[purpose_cards[index]['message']] =
                                  !purpose[
                                  purpose_cards[index]['message']]!;
                                },
                                color: purpose_cards[index]['color']
                              );
                            },
                          );
                        },
                      ),
                    ),
                  ),
                  /*SizedBox(
                    height: 380,
                    child: GridView.count(
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                      crossAxisCount: 2,
                      children: [
                        option_block(
                          message: 'Learn about robotics, and related field * ',
                          icon: HugeIcons.strokeRoundedOnlineLearning04,
                          onTap: () {
                            purpose['Learn about robotics and related fields'] =
                                !purpose[
                                    'Learn about robotics and related fields']!;
                          },
                          color: AppColors.lighterGreen,
                        ),
                        option_block(
                          message: 'Build your own robots',
                          icon: HugeIcons.strokeRoundedMachineRobot,
                          onTap: () {
                            purpose['Build your own robot'] =
                                !purpose['Build your own robot']!;
                          },
                          color: AppColors.peachBackground,
                        ),
                        option_block(
                          message: 'Share your creations in community',
                          icon: HugeIcons.strokeRoundedShare01,
                          onTap: () {
                            purpose['Share your creations in community'] =
                                !purpose['Share your creations in community']!;
                          },
                          color: AppColors.blueBackground,
                        ),
                        option_block(
                          message: 'View what we and other people are up to*',
                          icon: HugeIcons.strokeRoundedView,
                          onTap: () {
                            purpose['View what we and other people are up to'] =
                                !purpose[
                                    'View what we and other people are up to']!;
                          },
                          color: AppColors.yellowBackground,
                        ),
                      ],
                    ),
                  ),*/
                  const Gap(8),
                  Text('You can choose multiple options',
                      style: Theme.of(context).textTheme.titleSmall!.copyWith(
                            color: AppColors.grey,
                          )),
                ],
              ),
            ),
          ),
        ),
        floatingActionButton: GestureDetector(
          onTap: () {
            print(purpose);
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => create_account(
                          name: widget.name,
                          description: widget.description,
                          purpose: purpose,
                        )));
          },
          child: const HugeIcon(
            icon: HugeIcons.strokeRoundedCircleArrowRight01,
            color: AppColors.comfyGreenText,
            size: 60.0,
          ),
          //go to next page
        ));
  }
}

class create_account extends StatefulWidget {
  const create_account(
      {super.key,
      required this.name,
      required this.description,
      required this.purpose});
  final String name;
  final String description;
  final Map<String, bool> purpose;
  @override
  State<create_account> createState() => _create_accountState();
}

class _create_accountState extends State<create_account> {
  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Create an account',
            style: Theme.of(context)
                .textTheme
                .headlineSmall!
                .copyWith(color: AppColors.black),
          ),
          leading: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: const HugeIcon(
                icon: HugeIcons.strokeRoundedArrowLeft01,
                color: AppColors.black,
              )),

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
                    'assets/img/page1_logo.png',
                    height: 65,
                  ).animate().fadeIn(duration: 1000.ms),
                  const Gap(16),
                  Text(
                    'One last thing we need to setup your space.',
                    style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                          color: AppColors.black,
                        ),
                  ).animate(delay: 1000.ms).fadeIn(duration: 1000.ms).then(),
                  const Gap(20),
                  Text(
                    'Your email',
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
                    'Pick a password',
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
                  Text('Minimum 8 characters',
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
            signUserUp(context, emailController.text, passwordController.text,
                widget.name, widget.description, widget.purpose);
          },
        ));
  }
}

Future<void> signUserUp(BuildContext context, String email, String password,
    String name, String tagline, Map<String, bool> purpose) async {
  // show loading screen
  showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      });
  // try sign up
  try {
    if (email.contains("@")) {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
    } else {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: '$email@comfyuser.tech', password: password);
    }
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);

    // pop the loading circle
    Navigator.pop(context);
  }
  //error handler
  on FirebaseAuthException catch (e) {
    Navigator.pop(context);
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.code)));
  }

  //Adding information of user
  try {
    if (FirebaseAuth.instance.currentUser != null) {
      print('current email is ${getUserID()}');
      var db = FirebaseFirestore.instance;
      var userInfo = {'name': name, 'tagline': tagline, 'purpose': purpose};
      await db
          .collection('user_information')
          .doc(email)
          .set(userInfo)
          .then((value) => print('updated user info'));

      //await update_user_information(name, tagline);
    }
  } on FirebaseException catch (e) {
    Navigator.pop(context);
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.code)));
  }

  if (FirebaseAuth.instance.currentUser != null) {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const ControllerPage()),
      (Route<dynamic> route) => false,
    );
  } else {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const register_page()),
      (Route<dynamic> route) => false,
    );
  }
}
