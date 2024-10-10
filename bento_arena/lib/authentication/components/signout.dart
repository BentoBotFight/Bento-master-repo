
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../presence/presence.dart';
import '../auth.dart';
import 'auth_button.dart';


class signout_button extends StatefulWidget {
  const signout_button({super.key});

  @override
  State<signout_button> createState() => _signout_buttonState();
}

class _signout_buttonState extends State<signout_button> {
  Future<void> signUserOut() async {
    // show loading screen
    showDialog(context: context, builder: (context){
      return const Center(child: CircularProgressIndicator(),);
    });
    // remove presence from realtime database
    //PresenceService().disconnect(signout: true);

    // check if currently google sign in
      if (await GoogleSignIn().isSignedIn()){
        await GoogleSignIn().disconnect();
      }

    // try signing out
    FirebaseAuth.instance.signOut();

    // pop the loading circle
    Navigator.pop(context);
    Navigator.push(context, MaterialPageRoute(builder: (context) => const auth_page(welcomePage: true,)));
  }

  @override
  Widget build(BuildContext context) {
    return auth_button(onTap: signUserOut, text: 'Sign out');
  }
}
