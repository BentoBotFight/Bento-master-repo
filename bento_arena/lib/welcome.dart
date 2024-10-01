import 'package:bento_arena/components/image.dart';
import 'package:bento_arena/components/text_instruction.dart';
import 'package:bento_arena/theme/color.dart';
import 'package:flutter/material.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key, required this.title,
    required this.description,
    required this.next_page,
    required this.img
  });
  final String img;
  final String title;
  final List<String> description;
  final Widget next_page;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.comfyGreenText,
      body: OrientationBuilder(builder: (context, orientation){
        return orientation == Orientation.landscape
            ? Row(
          children: [
            Expanded(
              flex: 1,
                child: ImagePane(img: img)),
            Expanded(
              flex: 1,
                child: TextInstruction(title: title, description: description, next_page: next_page))
          ],
        )
            : Column(
          children: [
            Expanded(flex: 1,
        child: ImagePane(img: img)),
            Expanded(
              flex: 1,
                child: TextInstruction(title: title, description: description, next_page: next_page))
          ],
        );

      }),
    );
  }
}
