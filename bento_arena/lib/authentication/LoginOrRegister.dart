import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/color.dart';
import 'log_in.dart';
import 'registerPage.dart';
import 'package:hugeicons/hugeicons.dart';


class LoginOrRegister extends StatefulWidget {
  const LoginOrRegister({super.key});

  @override
  State<LoginOrRegister> createState() => _LoginOrRegisterState();
}

class _LoginOrRegisterState extends State<LoginOrRegister> {
  // initially show login page
  bool showLoginPage = true;

  @override
  void initState() {
    super.initState();

  }

  @override
  void dispose() {
    super.dispose();

  }

  @override
  void deactivate() {
    super.deactivate();

  }

  void togglePages() {
    setState(() {
      showLoginPage = !showLoginPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    // old auth page
    /*if(showLoginPage == true){
     return log_in(onTap: togglePages);
   }
   else{
     return register_page(onTap: togglePages,);
   }*/
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surfaceDim,
      body: Center(
        child: Container(
          /*decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment(0.8, 1),
              colors: <Color>[
                Theme.of(context).colorScheme.surface,
                Theme.of(context).colorScheme.primaryContainer,
                //Theme.of(context).colorScheme.onPrimary,
                Theme.of(context).colorScheme.tertiaryContainer
              ],
              tileMode: TileMode.mirror,
            ),

          ),*/
          child: SafeArea(
            child: Stack(alignment: Alignment.center, children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Gap(180),
                  Image.asset(
                    'assets/img/bento-headshot.webp',
                    width: 100,
                  )
                      /*.animate()
                      .fadeIn(duration: 1000.ms)
                      .then()
                      .slide(begin: const Offset(0, -0.2), end: Offset.zero)*/,
                  const Gap(20),
                  Text(
                    'ComfySpace',
                    style: Theme.of(context)
                        .textTheme
                        .displayMedium
                        ?.copyWith(color: AppColors.black),
                  )
                      .animate()
                      .fadeIn(duration: 1000.ms)
                      .then()
                      .slide(begin: const Offset(0, -0.2), end: Offset.zero),
                  const Gap(100),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32),
                    child: Text(
                      textAlign: TextAlign.center,
                      'Learn and build robots comfortably',
                      style: Theme.of(context).textTheme.displaySmall!.copyWith(
                            color: AppColors.almostBlack,
                          ),
                    )
                        .animate(delay: 1000.ms)
                        .fadeIn(duration: 1000.ms)
                        .then()
                        .slide(begin: const Offset(0, -0.2), end: Offset.zero),
                  ),

                  const Spacer(),
                  //Sign up!
                  const Gap(20),
                  Animate(
                    effects: const [FadeEffect(), ScaleEffect()],
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const register_page()));
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 32),
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          decoration: BoxDecoration(
                            color: AppColors.lighterGreen,
                            borderRadius: BorderRadius.circular(8),
                            /*border: Border.all(
        width: 2.0,
        color: Theme.of(context).colorScheme.primary
      )*/
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment
                                .center, // Centers the row contents
                            children: [
                              Text(
                                'Let\'s begin',
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineLarge!
                                    .copyWith(color: AppColors.comfyGreenText),
                              ),
                              const SizedBox(
                                  width:
                                      8), // Adds some space between text and icon
                              const HugeIcon(
                                icon: HugeIcons.strokeRoundedCircleArrowRight01,
                                color: AppColors.comfyGreenText,
                                size: 30.0,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),

                  const Gap(20),
                  //Log in
                  Animate(
                    effects: const [FadeEffect(), ScaleEffect()],
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Already a member?',
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(color: AppColors.almostBlack),
                        ),
                        const Gap(10),
                        GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          log_in(onTap: () {})));
                            },
                            child: Text(
                              'Login now',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium!
                                  .copyWith(
                                    color: AppColors.almostBlack,
                                    decoration: TextDecoration.underline,
                                  ),
                            ))
                      ],
                    ),
                  ),
                  const Gap(80),
                ],
              ),
              /*ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.asset(
                    width: 200,
                      'assets/jax-spinning.gif'
                  ,//colorBlendMode: BlendMode.color,
                    //color: Theme.of(context).colorScheme.primary,
                  ),
                )*/
            ]),
          ),
        ),
      ),
    );
  }
}
