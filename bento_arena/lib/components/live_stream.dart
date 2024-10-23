import 'package:bento_arena/theme/color.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:webview_all/webview_all.dart';

String? uid = FirebaseAuth.instance.currentUser?.uid;
FirebaseDatabase database = FirebaseDatabase.instance;
DatabaseReference bento_info = database.ref('status/$uid/bento');
class LiveStream extends StatelessWidget {
  const LiveStream({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: bento_info.onValue,
        builder: (context, snapshot){
          String bento_name = snapshot.data!.snapshot.value.toString();
          print(' bento name is $bento_name');
            return Expanded(
              child: Container(
                  padding: EdgeInsets.all(12),
                  color: AppColors.comfyGreen,
                  child: Stack(children: [
                    Webview(url: "https://viewer.millicast.com?streamId=4zxunL/myStreamName"),
                    Container(color: AppColors.comfyGreen, padding: EdgeInsets.all(8) ,child: Text('controlling $bento_name')),
                  ])),
            );

        }
    );


  }
}
