import 'package:flutter/material.dart';

class auth_button extends StatefulWidget {
  const auth_button({super.key, required this.onTap, required this.text});
  final Function()? onTap; final String text;
  @override
  State<auth_button> createState() => _auth_buttonState();
}

class _auth_buttonState extends State<auth_button> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(8),
            border: Border.all(
            width: 2.0,
          color: Theme.of(context).colorScheme.primary
        )
        ),
        child: Text(widget.text,
          style: Theme.of(context).textTheme.labelLarge,
        ),
      ),
    );
  }
}
