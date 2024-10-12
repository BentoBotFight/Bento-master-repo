import 'package:bento_arena/components/button.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';



class ControlSection extends StatelessWidget {
  const ControlSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
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
    command: 'python3 dc.py 1 -1 & python3 dc.py 2 0 ',
    stop_command: 'python3 dc.py 1 0 & python3 dc.py 2 0',
              svg: 'assets/svg/left.svg',
                //icon: Icons.arrow_circle_left_outlined,
                //url: 'https://bento.comfyspace.tech/left'
    ),
            Gap(90),
            ActionButton(
                command: 'python3 dc.py 1 0 & python3 dc.py 2 -1',
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
    );
  }
}
