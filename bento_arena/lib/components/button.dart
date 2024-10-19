import 'package:bento_arena/theme/color.dart';
import 'package:bento_arena/user_information/userIdentifier.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hugeicons/hugeicons.dart';

import '../controller.dart';
FirebaseDatabase database = FirebaseDatabase.instance;
String uid = FirebaseAuth.instance.currentUser!.uid;

DatabaseReference bento_info = database.ref('status/$uid/bento');


class ActionButton extends StatefulWidget {
  const ActionButton({super.key,
    //required this.icon,
    //required this.url,
    required this.command,
    required this.stop_command,
    required this.svg,
    this.height = 50,
    this.width = 50,
  });
  //final IconData icon;
  //final String url;
  final String command;
  final String stop_command;
  final String svg;
  final double height;
  final double width;

  @override
  State<ActionButton> createState() => _ActionButtonState();
}

class _ActionButtonState extends State<ActionButton> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(stream: bento_info.onValue, builder: (context, snapshot){
      String bento_name = snapshot.data!.snapshot.value.toString();
      DatabaseReference ref = database.ref('robot/$bento_name');
      print('bento name is $bento_name');
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: GestureDetector(
          onTapDown: (_) async{
            print('tap holding');
            await ref.update({
              "command": widget.command,
            });
            //await sendRequestToFlaskApp(widget.url);
            setState(() {
              _isPressed = true;
            });
          },
          onTapUp: (_) async{
            print('tap stopping');
            await ref.update({
              "command": widget.stop_command,
            });
            //await sendRequestToFlaskApp('https://bento.comfyspace.tech/stop');
            setState(() {
              _isPressed = false;
            });
          },
          onTapCancel: () async {
            print('cancel');
            setState(() {
              _isPressed = false;
            });
          },

          child: Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: _isPressed ? Colors.red : AppColors.comfyGreenText,
                borderRadius: BorderRadius.circular(20), // Adds rounded corners
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    spreadRadius: 1,
                    blurRadius: 3,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: SvgPicture.asset(
                  color: AppColors.lighterGreen,
                  //colorFilter: ColorFilter.mode(AppColors.lighterGreen, BlendMode.color),
                  width: widget.width, height: widget.height,
                  widget.svg,
                  semanticsLabel: 'Navigation Button'
              )
            /*Icon(
            widget.icon,
            size: 40,
            color: _isPressed ? Colors.yellow : Colors.white,
          ),*/
          ),
        ),
      );
    });
  }
}


