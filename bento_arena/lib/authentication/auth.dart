import 'package:bento_arena/controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'LoginOrRegister.dart';

class auth_page extends StatelessWidget {
// if signed in -> home page
// if not signed in -> login page
  const auth_page({super.key, this.welcomePage = false});
  final bool welcomePage;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot){
          //if user is logged in -> home screen
          if(snapshot.hasData){
            return const ControllerPage();
          }
          /*else if(welcomePage == true && snapshot.hasData == false){
            return overall_summary_screen();
          }*/
          else{
            return const LoginOrRegister();
          }

            //if user not logged in -> log in screen
        },
      ),
    );
  }
}
