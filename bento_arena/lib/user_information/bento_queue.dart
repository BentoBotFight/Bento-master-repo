import 'package:bento_arena/user_information/userIdentifier.dart';
import 'package:bento_arena/user_information/user_information.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

Future<void> queue_bento_player(bool status, int bento_port, user_information user) async{
  String? email = getUserID();

  //FirebaseAuth.instance.currentUser?.email.toString();
  if (kDebugMode) {
    (status == true)? print('adding $email to bento queue'): print('removing $email from bento queue');
  }
  var db = FirebaseFirestore.instance;
  await db.collection('bento_queue').doc(email).set({'name':user.name, 'app': 'bento-arena', 'live_status': status, 'bento': bento_port}).then((value) => print('updated user info'));
}