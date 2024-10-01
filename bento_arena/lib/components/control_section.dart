import 'package:bento_arena/components/button.dart';
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
          svg: 'assets/svg/up.svg',
            //icon: Icons.arrow_upward_outlined,
            url: 'https://bento.comfyspace.tech/forward'),
        Row(
          mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ActionButton(
              svg: 'assets/svg/left.svg',
                //icon: Icons.arrow_circle_left_outlined,
                url: 'https://bento.comfyspace.tech/left'),
            Gap(90),
            ActionButton(
                svg: 'assets/svg/right.svg',
                //icon: Icons.arrow_circle_right_outlined,
                url: 'https://bento.comfyspace.tech/right'),
          ],
        ),
        ActionButton(
            svg: 'assets/svg/down.svg',
            //icon: Icons.arrow_downward,
            url: 'https://bento.comfyspace.tech/backward'),
      ],
    );
  }
}
