import 'package:bento_arena/theme/color.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:webview_all/webview_all.dart';

String? uid = FirebaseAuth.instance.currentUser?.uid;
FirebaseDatabase database = FirebaseDatabase.instance;
DatabaseReference play_or_watch = database.ref('status/$uid');
//DatabaseReference play_url = database.ref('play');
//DatabaseReference watch_url = database.ref('stream');

class LiveStream extends StatelessWidget {
  const LiveStream({super.key});

  @override
  Widget build(BuildContext context) {
/*    return StreamBuilder(
        stream: play_or_watch.onValue,
        builder: (context, snapshot){
          if(snapshot.connectionState == ConnectionState.done){
            Map<String, dynamic> player_info = Map<String, dynamic>.from(snapshot.data!.snapshot.value as Map);
            if(player_info['bento'] != 'none'){
              return Expanded(
                child: Container(
                    padding: EdgeInsets.all(12),
                    color: AppColors.comfyGreen,
                    child: Webview(url: 'https://www.youtube.com/live/Arlj4J9jA9U?si=iEvsfqpn8nN0t9GI')),
              );
            }
            else{
              return Expanded(
                child: Container(
                    padding: EdgeInsets.all(12),
                    color: AppColors.comfyGreen,
                    child: Webview(url: 'https://viewer.millicast.com?streamId=GG2XAu/myStreamName')),
              );
            }

          }
          else{
            return Container(
              width: 50, height: 50,
              child: Text('Error ${snapshot.error}'),
            );
          }
        }
    );*/
return Expanded(
      child: Container(
        padding: EdgeInsets.all(12),
          color: AppColors.comfyGreen,
          child: Webview(url: "https://viewer.millicast.com?streamId=GG2XAu/myStreamName")),
    );

  }
}
