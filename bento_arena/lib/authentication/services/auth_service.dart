import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart' as apple;

class AuthService{
  SignInWithGoogle() async{
    // begin interactive sign in process
    if(kIsWeb!=false){
      final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();
      //obtain auth details from requirest
      final GoogleSignInAuthentication gAuth = await gUser!.authentication;
      //create a new credentials for user

      final credential = GoogleAuthProvider.credential(
        accessToken: gAuth.accessToken,
        idToken: gAuth.idToken,
      );
      //let's sign in
      return await FirebaseAuth.instance.signInWithCredential(credential);
    }
    else{
      final GoogleSignInAccount? gUser = await GoogleSignIn(
        /*scopes: <String>[
          'email',
          'https://www.googleapis.com/auth/contacts.readonly',
        ]*/
      ).signIn();
      //obtain auth details from requirest
      final GoogleSignInAuthentication gAuth = await gUser!.authentication;
      //create a new credentials for user

      final credential = GoogleAuthProvider.credential(
        accessToken: gAuth.accessToken,
        idToken: gAuth.idToken,
      );
      //let's sign in
      return await FirebaseAuth.instance.signInWithCredential(credential);
    }
  }
  SignInWithApple() async{

    final credential = await apple.SignInWithApple.getAppleIDCredential(
      scopes: [
        apple.AppleIDAuthorizationScopes.email,
        apple.AppleIDAuthorizationScopes.fullName,
      ],
      webAuthenticationOptions: apple.WebAuthenticationOptions(
          clientId: 'tech.comfyspace.comfyspace-apple-login',
          redirectUri: Uri.parse('https://comfyspace-73966.firebaseapp.com/__/auth/handler')
      ),
    );
    final AuthCredential authCredential = OAuthProvider('apple.com').credential(
      idToken: credential.identityToken,
      accessToken: credential.authorizationCode,
    );

    //print(credential.userIdentifier);
    return await FirebaseAuth.instance.signInWithCredential(authCredential);
    /*
    final appleProvider = AppleAuthProvider();

    if (kIsWeb) {
      return await FirebaseAuth.instance.signInWithPopup(appleProvider);
    } else {
      return await FirebaseAuth.instance.signInWithProvider(appleProvider);
    }
    */
  }

}