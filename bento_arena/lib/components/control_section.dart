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
    return Container(
      //color: Colors.yellow,
      child: StreamBuilder(
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

      }),
    );

  }
}

class WeaponControl extends StatefulWidget {
  const WeaponControl({super.key});

  @override
  State<WeaponControl> createState() => _WeaponControlState();
}

class _WeaponControlState extends State<WeaponControl> {
  double initial_angle = 90;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: bento_info.onValue,
        builder: (context, snapshot){
          String bento_name = snapshot.data!.snapshot.value.toString();
          DatabaseReference ref = database.ref('robot/$bento_name');
          print('bento name is $bento_name');
          return Container(
            //color: Colors.red,
            child: RotatedBox(
              quarterTurns: 3,
              child: SliderTheme(
                data: SliderThemeData(
                  thumbShape: RoundSliderThumbShape(enabledThumbRadius: 20),
                  //trackShape: CustomTrackShape(),
                ),
                child: Slider(
                  divisions: 1,
                  min: 90, max: 170,
                  value: initial_angle,
                  onChanged: (double value) async {
                    if((initial_angle == 90)){
                      await ref.update({
                        "weapon": 'python servo.py 21 170',
                      });
                    }
                    else{
                      await ref.update({
                        "weapon": 'python servo.py 21 90',
                      });
                    }
                    setState((){
                
                
                      initial_angle = value;
                    });
                  },
                ),
              ),
            ),
          );
        });

  }
}

class CustomTrackShape extends RoundedRectSliderTrackShape {
  Rect getPreferredRect({
    required RenderBox parentBox,
    Offset offset = Offset.zero,
    required SliderThemeData sliderTheme,
    bool isEnabled = false,
    bool isDiscrete = false,
  }) {
    final double trackHeight = sliderTheme.trackHeight!;
    final double trackLeft = offset.dx;
    final double trackTop = offset.dy + (parentBox.size.height - trackHeight) / 2;
    final double trackWidth = parentBox.size.width;
    return Rect.fromLTWH(trackLeft, trackTop, trackWidth, trackHeight);
  }
}