import 'package:bento_arena/authentication/auth.dart';
import 'package:bento_arena/controller.dart';
import 'package:bento_arena/onboarding/onboarding.dart';
import 'package:bento_arena/theme/color.dart';
import 'package:bento_arena/theme/typography.dart';
import 'package:bento_arena/welcome.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
Future<void> main() async {
  //WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Bento Arena',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.comfyGreen),
        useMaterial3: true,
        textTheme: ComfyTextTheme,
      ),
        darkTheme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: AppColors.comfyGreen),
          useMaterial3: true,
          textTheme: ComfyTextTheme,
        ),
      home: auth_page()
      //ControllerPage(),
    );
  }
}



