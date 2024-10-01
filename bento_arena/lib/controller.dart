import 'package:bento_arena/components/button.dart';
import 'package:bento_arena/components/control_section.dart';
import 'package:bento_arena/theme/color.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:gap/gap.dart';
import 'package:awesome_bottom_bar/awesome_bottom_bar.dart';
import 'package:webview_all/webview_all.dart';

import 'components/live_stream.dart';

const List<TabItem> items = [
  TabItem(
    icon: Icons.stop,
    // title: 'Home',
  ),

];

class ControllerPage extends StatefulWidget {
  const ControllerPage({super.key});

  @override
  State<ControllerPage> createState() => _ControllerPageState();
}

class _ControllerPageState extends State<ControllerPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: AppColors.lighterGreen,
      body: OrientationBuilder(builder: (context, orientation){
        return orientation == Orientation.landscape
            ? const Row(
          children: [
            LiveStream(),
            Gap(64),
            ControlSection(),
            Gap(64),
          ],
        )
            : const Column(
          children: [
            LiveStream(),
            Gap(64),
            ControlSection(),
            Gap(64),
          ],
        );

      }),
    );

    /*return Scaffold(
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Gap(32),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ActionButton(icon: Icons.arrow_upward_outlined, url: 'https://bento.comfyspace.tech/forward'),
                Gap(32),
                ActionButton(icon: Icons.arrow_downward_outlined, url: 'https://bento.comfyspace.tech/backward'),
              ],
            ),

            Gap(32),
            Expanded(child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                /*Center(
                  child: Image.network('https://images.prismic.io/nhrl/Zq0F7kaF0TcGIp8e_SeptemberNHRLspectator.jpg?auto=format,compress'),
                ),*/
                LiveStream(),
                ActionButton(icon: Icons.stop, url: 'https://bento.comfyspace.tech/stop')
              ],
            ),),

            Gap(32),
            Row(
              children: [
                ActionButton(icon: Icons.keyboard_arrow_left_outlined, url: 'https://bento.comfyspace.tech/left'),
                Gap(32),
                ActionButton(icon: Icons.keyboard_arrow_right_outlined, url: 'https://bento.comfyspace.tech/right'),

              ],
            ),
            Gap(32)

          ],
        ),
      ),
    )*/
  }
}

Future<void> sendCurlRequest(String url_str) async {
  final url = Uri.parse(url_str);

  final response = await http.post(url);

  /*if (response.statusCode == 200) {
    return response.body;
  } else {
    throw Exception('Failed to send request: ${response.statusCode}');
  }*/
}

Future<void> sendRequestToFlaskApp(String str_url) async {
  final url = Uri.parse(str_url);

  try {
    final response = await http.get(url).timeout(Duration(seconds: 10));

    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode == 200) {
      // Request successful
      print('Request successful');
      // Process the response here if needed
    } else {
      // Request failed
      print('Request failed with status: ${response.statusCode}');
    }
  } catch (e) {
    // Handle any errors
    print('Error occurred: $e');
  }
}
