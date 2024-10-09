import 'package:flutter/material.dart';


class option_block extends StatefulWidget {
  const option_block({
    super.key,
    required this.message,
    required this.icon,
    required this.onTap,
    required this.color,
  });

  final String message;
  final IconData icon;
  final void Function() onTap;
  final Color color;

  @override
  _option_blockState createState() => _option_blockState();
}

class _option_blockState extends State<option_block> {
  bool _isPressed = false;

  void _handleTapDown(TapDownDetails details) {
    print('tapping down');
    setState(() {
      _isPressed = !_isPressed;
    });
  }

  void _handleTapUp(TapUpDetails details) {
    print('tapping up');
    setState(() {
      //_isPressed = true;
    });
    widget.onTap();
  }

  void _handleTapCancel() {
    setState(() {
      _isPressed = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: _handleTapDown,
      onTapUp: _handleTapUp,
      onTapCancel: _handleTapCancel,
      child: Container(
        width: 165,
        height: 130,
        decoration: BoxDecoration(
          color: widget.color,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: _isPressed ? Colors.black : Colors.transparent,
            width: 2,
          ),
        ),
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(widget.icon, color: Colors.black, size: 32),
            const SizedBox(height: 16),
            Text(
              widget.message,
              style: Theme.of(context)
                  .textTheme
                  .bodySmall!
                  .copyWith(color: Colors.black),
            ),
          ],
        ),
      ),
    );
  }
}
