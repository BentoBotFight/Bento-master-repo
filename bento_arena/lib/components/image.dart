import 'package:flutter/material.dart';

class ImagePane extends StatefulWidget {
  const ImagePane({super.key, required this.img});
  final String img;

  @override
  State<ImagePane> createState() => _ImagePaneState();
}

class _ImagePaneState extends State<ImagePane> {
  @override
  Widget build(BuildContext context) {
    return Image.network(widget.img, fit: BoxFit.fill);
  }
}
