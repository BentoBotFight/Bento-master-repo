import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:gap/gap.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter/foundation.dart';
import 'package:webview_all/webview_all.dart';

import 'package:awesome_bottom_bar/awesome_bottom_bar.dart';

const List<TabItem> items = [
  TabItem(
    icon: Icons.home,
    // title: 'Home',
  ),
  TabItem(
    icon: Icons.search_sharp,
    title: 'Shop',
  ),
  TabItem(
    icon: Icons.favorite_border,
    title: 'Wishlist',
  ),
  TabItem(
    icon: Icons.shopping_cart_outlined,
    title: 'Cart',
  ),
  TabItem(
    icon: Icons.account_box,
    title: 'profile',
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
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            IconButton(
              iconSize: 100,
              onPressed: () async {
                await sendRequestToFlaskApp(
                    'https://bento.comfyspace.tech/run');
              },
              icon: Icon(Icons.arrow_upward),
            ),
            Gap(32),
            //Webview(url: "https://www.wechat.com/en"),
            Gap(32),
            IconButton(
              iconSize: 100,
              onPressed: () async {
                await sendRequestToFlaskApp(
                    'https://bento.comfyspace.tech/stop');
              },
              icon: Icon(Icons.arrow_downward),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const BottomBarFloating(
        items: items,
        backgroundColor: Colors.white,
        color: Colors.green,
        colorSelected: Colors.red,
      ),
    );
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
