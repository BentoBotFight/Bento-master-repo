import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';

import '../controller.dart';

class ActionButton extends StatefulWidget {
  const ActionButton({super.key, required this.icon, required this.url});
  final IconData icon;
  final String url;

  @override
  State<ActionButton> createState() => _ActionButtonState();
}

class _ActionButtonState extends State<ActionButton> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) {
        setState(() {
          _isPressed = true;
        });
      },
      onTapUp: (_) {
        setState(() {
          _isPressed = false;
        });
      },
      onTapCancel: () {
        setState(() {
          _isPressed = false;
        });
      },
      onTap: () async {
        await sendRequestToFlaskApp(widget.url);
      },
      child: Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: _isPressed ? Colors.red : Colors.blue,
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
        child: Icon(
          widget.icon,
          size: 40,
          color: _isPressed ? Colors.yellow : Colors.white,
        ),
      ),
    );
  }
}