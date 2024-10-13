import 'package:bento_arena/components/button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_joystick/flutter_joystick.dart';
import 'package:gap/gap.dart';
import 'package:matrices/matrices.dart';

const ballSize = 20.0;
const step = 10.0;
FirebaseDatabase database = FirebaseDatabase.instance;
String uid = FirebaseAuth.instance.currentUser!.uid;

DatabaseReference bento_info = database.ref('status/$uid/bento');


class ControlSection extends StatefulWidget {
  const ControlSection({super.key});

  @override
  State<ControlSection> createState() => _ControlSectionState();
}

class _ControlSectionState extends State<ControlSection> {
  double _x = 100;
  double _y = 100;
  JoystickMode _joystickMode = JoystickMode.all;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: bento_info.onValue,
        builder: (context, snapshot){
          String bento_name = snapshot.data!.snapshot.value.toString();
          DatabaseReference ref = database.ref('robot/$bento_name');
          print('bento name is $bento_name');
          return Joystick(
            mode: _joystickMode,
            listener: (details) async {

              /*var x_y_matrix = Matrix.fromList([[details.x, details.y]]);
              var conversion_matrix = Matrix.fromList(
                [[0, 1], [-1, 1]]
              );
              var result = x_y_matrix * conversion_matrix;
              var motor1 = result[0][0];
              var motor2 = result[0][1];
              await ref.update({
                "command": 'python dc.py 1 $motor1 & python dc.py 2 $motor2',
              });*/



              if(details.x < 0.7 && details.x>-0.7 && details.y < -0.3){
                await ref.update({
                  "command": 'python dc.py 1 -0.5 & python dc.py 2 -0.5',
                });
                print('up');

              }
              else if (details.x < 0.7 && details.x>-0.7 && details.y > 0.3){
                await ref.update({
                  "command": 'python dc.py 1 0.5 & python dc.py 2 0.5',
                });
                print('down');
              }
              else if (details.x > 0.3) {
                await ref.update({
                  "command": 'python dc.py 1 -0.2 & python dc.py 2 0',
                });
                print('right');
              }
              else if (details.x < -0.3){
                await ref.update({
                  "command": 'python dc.py 1 0 & python dc.py 2 -0.2',
                });
                print('left');
              }
              else{
                await ref.update({
                  "command": 'python dc.py 1 0 & python dc.py 2 0',
                });
                print('stop');
              }


            },

          );

    });
    /*return Column(
      mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ActionButton(
          command: 'python dc.py 1 -1 & python dc.py 2 -1 & python dc.py 3 1',
          stop_command: 'python dc.py 1 0 & python dc.py 2 0 & python dc.py 3 0',
          svg: 'assets/svg/up.svg',
            //icon: Icons.arrow_upward_outlined,
            //url: 'https://bento.comfyspace.tech/forward'
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ActionButton(
    command: 'python3 dc.py 1 0 & python3 dc.py 2 -1 ',
    stop_command: 'python3 dc.py 1 0 & python3 dc.py 2 0',
              svg: 'assets/svg/left.svg',
                //icon: Icons.arrow_circle_left_outlined,
                //url: 'https://bento.comfyspace.tech/left'
    ),
            Gap(90),
            ActionButton(
                command: 'python3 dc.py 1 -1 & python3 dc.py 2 0',
                stop_command: 'python3 dc.py 1 0 & python3 dc.py 2 0',
                svg: 'assets/svg/right.svg',
                //icon: Icons.arrow_circle_right_outlined,
                //url: 'https://bento.comfyspace.tech/right'
    ),
          ],
        ),
        ActionButton(
            command: 'python3 dc.py 1 1 & python3 dc.py 2 1',
            stop_command: 'python3 dc.py 1 0 & python3 dc.py 2 0',
            svg: 'assets/svg/down.svg',
            //icon: Icons.arrow_downward,
            //url: 'https://bento.comfyspace.tech/backward'
        ),
      ],
    );*/

  }
}

class Ball extends StatelessWidget {
  final double x;
  final double y;

  const Ball(this.x, this.y, {super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: x,
      top: y,
      child: Container(
        width: ballSize,
        height: ballSize,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.redAccent,
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              spreadRadius: 2,
              blurRadius: 3,
              offset: Offset(0, 3),
            )
          ],
        ),
      ),
    );
  }
}