import 'package:bento_arena/theme/color.dart';
import 'package:flutter/material.dart';
import 'package:webview_all/webview_all.dart';

class LiveStream extends StatelessWidget {
  const LiveStream({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(12),
          color: AppColors.comfyGreen,
          child: Webview(url: "https://viewer.millicast.com?streamId=W3yfVd/myStreamName")),
    );

  }
}
