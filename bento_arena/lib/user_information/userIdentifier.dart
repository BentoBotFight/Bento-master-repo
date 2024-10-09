
//If user logs in using Google or username/email, return respective email
//if user uses apple login, uses the uid (user identification)

import 'package:firebase_auth/firebase_auth.dart';

String getUserID(){
  String? email = FirebaseAuth.instance.currentUser?.email;
  email ??= FirebaseAuth.instance.currentUser?.uid;
  return email!;
}