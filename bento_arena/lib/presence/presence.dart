import 'package:bento_arena/user_information/userIdentifier.dart';
import 'package:bento_arena/user_information/user_information.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:math';

String getRandomItem(List<String> list) {
  final random = Random();
  return list[random.nextInt(list.length)];
}

List<String> bento_list = ['men-in-black', 'snow-white'];
class PresenceService {
  final DatabaseReference _database = FirebaseDatabase.instance.ref();
  final String _uid = FirebaseAuth.instance.currentUser!.uid;

  void updatePresence() async {
    final userStatusRef = _database.child('status/$_uid');

    // First, get the current value of 'bento'
    DataSnapshot snapshot = await userStatusRef.child('bento').get();
    String bentoValue = snapshot.value as String? ?? 'none';

    // When app is opened
    userStatusRef.update({
      'email': getUserID(),
      'state': 'online',
      'last_seen': ServerValue.timestamp,
      'bento': bentoValue  // Use the existing value or 'none' if it was null
    });

    // When app is closed
    userStatusRef.onDisconnect().update({
      'email': getUserID(),
      'state': 'offline',
      'last_seen': ServerValue.timestamp,
    });
  }
}