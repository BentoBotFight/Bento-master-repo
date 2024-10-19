import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

FirebaseDatabase database = FirebaseDatabase.instance;
String uid = FirebaseAuth.instance.currentUser!.uid;

DatabaseReference bento_info = database.ref('status/$uid/bento');

class KeyboardControl extends StatefulWidget {
  const KeyboardControl({super.key, required this.child, required this.key_command});
  final Widget child;
  final Map<String, String> key_command;

  @override
  State<KeyboardControl> createState() => _KeyboardControlState();
}

class _KeyboardControlState extends State<KeyboardControl> {
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _focusNode.requestFocus();
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: bento_info.onValue,
        builder: (context, snapshot) {
          String bento_name = snapshot.data?.snapshot.value?.toString() ?? '';
          DatabaseReference ref = database.ref('robot/$bento_name');

          return FocusScope(
            autofocus: true,
            child: RawKeyboardListener(
              focusNode: _focusNode,
              onKey: (RawKeyEvent event) async {
                print('keyboard used');
                if (event is RawKeyDownEvent) {
                  print(event.logicalKey.keyLabel);
                  String keyPressed = event.logicalKey.keyLabel.toLowerCase();
                  if (widget.key_command.keys.contains(keyPressed)) {
                    print(widget.key_command[keyPressed]);
                    await ref.update({
                      "command": widget.key_command[keyPressed],
                    });
                  }
                } else if (event is RawKeyUpEvent) {
                  await ref.update({
                    "command": 'python dc.py 1 0 & python dc.py 2 0',
                    "weapon": 'python servo.py 21 90',
                  });
                }
              },
              child: widget.child,
            ),
          );
        }
    );
  }
}