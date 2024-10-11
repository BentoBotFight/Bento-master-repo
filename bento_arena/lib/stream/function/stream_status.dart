import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

Future<bool> obtain_stream_status() async {
  if (kDebugMode) {
    print('obtaining stream status');
  }

  //FirebaseAuth.instance.currentUser?.email.toString();
  var db = FirebaseFirestore.instance;

  bool stream_status = true;
  try{
    await db.collection('bento_stream').doc('global').get().then(
            (snapshot){
          stream_status = snapshot.data()?['stream_status'];
        });
  } catch (e){
    if (kDebugMode) {
      print('error obtaining stream status ${e.toString()}');
    }
  }

  return stream_status;
}