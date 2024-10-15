import 'package:bento_arena/admin/admin_console.dart';
import 'package:bento_arena/components/button.dart';
import 'package:bento_arena/components/control_section.dart';
import 'package:bento_arena/presence/presence.dart';
import 'package:bento_arena/secrets/variables.dart';
import 'package:bento_arena/theme/color.dart';
import 'package:bento_arena/user_information/bento_queue.dart';
import 'package:bento_arena/user_information/userIdentifier.dart';
import 'package:bento_arena/user_information/user_information.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_window_close/flutter_window_close.dart';
import 'package:http/http.dart' as http;
import 'package:gap/gap.dart';
import 'package:awesome_bottom_bar/awesome_bottom_bar.dart';
import 'package:webview_all/webview_all.dart';
import 'dart:html' as html;
import 'components/live_stream.dart';

FirebaseDatabase database = FirebaseDatabase.instance;
//String uid = FirebaseAuth.instance.currentUser!.uid;
String uid = 'jrOEpp1egiNlEYCimzEM2fnGOE13';
DatabaseReference user_presence_status = database.ref('status/${uid}');

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

class _ControllerPageState extends State<ControllerPage> with WidgetsBindingObserver{
  late user_information user;
  @override
  void initState() {
    super.initState();
    // track if paused or resumed etc..
    WidgetsBinding.instance.addObserver(this);
    String? uid = FirebaseAuth.instance.currentUser?.uid;
    PresenceService().updatePresence();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        /*floatingActionButton: (getUserID() == admin_email)?
        FloatingActionButton(onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) => AdminConsole()));
        }):
        Gap(0),*/
        body: StreamBuilder(
            stream: user_presence_status.onValue,
            builder: (context, snapshot){
              if (snapshot.hasError){
                return Center(child: Text(snapshot.error.toString()),);
              }
              else if(snapshot.hasData){
                Map<String, dynamic> user_presence_map = Map<String, dynamic>.from(snapshot.data!.snapshot.value as Map);
                print('queue status of current user is ${user_presence_map['queue']}');
                if(user_presence_map['queue'] == true){
                  return OrientationBuilder(builder: (context, orientation){
                    return orientation == Orientation.landscape
                        ? const Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.all(50),
                          child: WeaponControl(),
                        ),
                        Gap(64),
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
                        Row(
                          //mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(left: 40),
                              child: WeaponControl(),
                            ),

                            Padding(
                              padding: EdgeInsets.only(right: 40),
                              child: ControlSection(),
                            ),
                          ],
                        ),

                        Gap(64),
                      ],
                    );

                  });
                }
                else{
                  return Center(child: Text('Live view'));
                }
              }
              else{
                return Center(child: Text('No data found on user $uid queue status, contact Thomas for fix'),);
                }
            }
        )
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
