import 'package:bento_arena/user_information/userIdentifier.dart';
import 'package:bento_arena/user_information/user_information.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart';

class PresenceService {
  final DatabaseReference _database = FirebaseDatabase.instance.ref();
  final String _uid = FirebaseAuth.instance.currentUser!.uid;

  void updatePresence() {
    final userStatusRef = _database.child('status/$_uid');

    // When app is opened
    userStatusRef.set({
      'email': getUserID(),
      'state': 'online',
      'last_seen': ServerValue.timestamp,
    });

    // When app is closed
    userStatusRef.onDisconnect().set({
      'email': getUserID(),
      'state': 'offline',
      'last_seen': ServerValue.timestamp,
    });
  }
}