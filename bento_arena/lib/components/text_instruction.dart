import 'package:bento_arena/theme/color.dart';
import 'package:bento_arena/theme/typography.dart';
import 'package:flutter/material.dart';

class TextInstruction extends StatelessWidget {
  const TextInstruction({
    super.key,
    required this.title,
    required this.description,
    required this.next_page,
  });

  final String title;
  final List<String> description;
  final Widget next_page;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: buildspaceText
              //Theme.of(context).textTheme.titleLarge!
                  .copyWith(color: AppColors.lighterGreen),
            ),
          ),

          ...description.map((item) => Padding(
            padding: EdgeInsets.only(bottom: 20),
            child: Text(
              '$item',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: AppColors.lighterGreen),

            ),
          )).toList(),

          Container(
            color: AppColors.comfyGreen,
            child: TextButton(onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => next_page));
            }, child: Text(
                'Next',
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: AppColors.comfyGreenText),
            )),
          )
        ],
      ),
    );
  }
}