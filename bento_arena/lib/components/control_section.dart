import 'dart:math';

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

Map<String, Map<String, String>> bento_control = {
  'men-in-black': {
    'up': 'python dc.py 1 -0.5 & python dc.py 2 -0.5',
    'down': 'python dc.py 1 0.5 & python dc.py 2 0.5',
    'right':  'python dc.py 1 -0.2 & python dc.py 2 0',
    'left': 'python dc.py 1 0 & python dc.py 2 -0.2',
    'stop': 'python dc.py 1 0 & python dc.py 2 0'
  },
  'snow-white': {
    'up': 'python dc.py 1 -0.5 & python dc.py 2 -0.5',
    'down': 'python dc.py 1 0.5 & python dc.py 2 0.5',
    'right':  'python dc.py 1 -0.2 & python dc.py 2 0',
    'left': 'python dc.py 1 0 & python dc.py 2 -0.2',
    'stop': 'python dc.py 1 0 & python dc.py 2 0'
  },
  'cyclop': {
    'up': 'raspi-gpio set 5 dh & raspi-gpio set 6 dl & raspi-gpio set 22 dh & raspi-gpio set 27 dl',
    'down': 'raspi-gpio set 5 dl & raspi-gpio set 6 dh & raspi-gpio set 22 dl & raspi-gpio set 27 dh',
    'left':  'raspi-gpio set 5 dl & raspi-gpio set 6 dl & raspi-gpio set 22 dh & raspi-gpio set 27 dl',
    'right': 'raspi-gpio set 5 dh & raspi-gpio set 6 dl & raspi-gpio set 22 dl & raspi-gpio set 27 dl',
    'stop': 'raspi-gpio set 5 dl & raspi-gpio set 6 dl & raspi-gpio set 22 dl & raspi-gpio set 27 dl'
  }
};
Map<String, Map<String, String>> bento_weapon_control = {
  'men-in-black': {
    'up': 'python servo.py 21 170',
    'down': 'python servo.py 21 90',
  },
  'snow-white': {
    'up': 'python servo.py 21 170',
    'down': 'python servo.py 21 90',
  },
  'cyclop': {
    'up': 'raspi-gpio set 20 dh',
    'down': 'raspi-gpio set 20 dl',
  }
};

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

            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
              Joystick(
              mode: _joystickMode,

              listener: (details) async {

                if(details.x < 0.7 && details.x>-0.7 && details.y < -0.3){

                  await ref.update({
                    "command": bento_control[bento_name]?['up'],
                    //'python dc.py 1 -0.5 & python dc.py 2 -0.5',
                  });
                  print('up');
                  print(bento_control[bento_name]?['up']);
                }
                else if (details.x < 0.7 && details.x>-0.7 && details.y > 0.3){
                  await ref.update({
                    "command": bento_control[bento_name]?['down'],
                  });
                  print('down');
                }
                else if (details.x > 0.3) {
                  await ref.update({
                    "command": bento_control[bento_name]?['right'],
                  });
                  print('right');
                }
                else if (details.x < -0.3){
                  await ref.update({
                    "command": bento_control[bento_name]?['left'],
                  });
                  print('left');
                }
                else{
                  await ref.update({
                    "command": bento_control[bento_name]?['stop'],
                  });
                  print('stop');
                }
                //_circleDetector.update(details);
              },
              ),
              ],
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
                        "weapon": bento_weapon_control[bento_name]?['up'],
                      });
                      print(bento_name);
                      print(bento_weapon_control[bento_name]?['up']);
                    }
                    else{
                      await ref.update({
                        "weapon": bento_weapon_control[bento_name]?['down'],
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
