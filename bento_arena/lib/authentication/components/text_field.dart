import 'package:flutter/material.dart';

class auth_textfield extends StatefulWidget {
  const auth_textfield({super.key, required this.controller, required this.hintText, required this.obsureText});
  final TextEditingController controller; final String hintText; final bool obsureText;
  @override
  State<auth_textfield> createState() => _auth_textfieldState();
}

class _auth_textfieldState extends State<auth_textfield> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 500),
        child: TextField(
          textInputAction: TextInputAction.next,
          obscureText: widget.obsureText,
          controller: widget.controller,
          decoration: InputDecoration(
            hintText: widget.hintText,
            enabledBorder: const OutlineInputBorder(),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Theme.of(context).colorScheme.primary),
            ),
          ),
        ),
      ),
    );
  }
}
