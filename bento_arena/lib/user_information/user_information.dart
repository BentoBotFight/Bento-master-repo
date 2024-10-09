

import 'package:bento_arena/user_information/userIdentifier.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';


class user_information{
  String? name;
  String? tagline;

  user_information(String name, String tagline){
    this.name = name;
    this.tagline = tagline;
  }
}

Future<user_information> get_user_information() async {
  if (kDebugMode) {
    print('getting user data');
  }

  String? email = getUserID();
  //FirebaseAuth.instance.currentUser?.email.toString();
  var db = FirebaseFirestore.instance;
  late user_information user;
  try{
    await db.collection('user_information').doc(email).get().then(
            (snapshot){
          user = user_information(snapshot.data()?['name'], snapshot.data()?['tagline']);
        });
  } catch (e){
    if (kDebugMode) {
      print(e.toString());
    }
  }

  return user;
}

Future<void> add_user_to_database() async{
  String? email = getUserID();
  //FirebaseAuth.instance.currentUser?.email.toString();
  if (kDebugMode) {
    print('adding user data for $email');
  }
  var db = FirebaseFirestore.instance;
  await db.collection('user_information').doc(email).set({'email': email}).then(
          (value) => print('added user to database'),
            onError: (error) => print('error adding user to db $error')
  );
}

Future<void> update_user_information(String name, String tagline) async{
  String? email = getUserID();
  //FirebaseAuth.instance.currentUser?.email.toString();
  if (kDebugMode) {
    print('adding name and tagline for $email');
  }
  var db = FirebaseFirestore.instance;
  await db.collection('user_information').doc(email).update({'name':name, 'tagline': tagline, 'app': 'bento-arena'}).then((value) => print('updated user info'));
}