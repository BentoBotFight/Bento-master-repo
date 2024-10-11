import 'package:bento_arena/controller.dart';
import 'package:bento_arena/stream/stream_reroute.dart';
import 'package:bento_arena/user_information/bento_queue.dart';
import 'package:bento_arena/user_information/user_information.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'LoginOrRegister.dart';

class auth_page extends StatefulWidget {
// if signed in -> home page
// if not signed in -> login page
  const auth_page({super.key, this.welcomePage = false});
  final bool welcomePage;


  @override
  State<auth_page> createState() => _auth_pageState();
}

class _auth_pageState extends State<auth_page> {
  late user_information user;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    get_user();
  }

  Future<void> get_user() async{
    user = await get_user_information();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot){
          //if user is logged in -> home screen
          if(snapshot.hasData){
            return const StreamReroute();
            //ControllerPage();
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
