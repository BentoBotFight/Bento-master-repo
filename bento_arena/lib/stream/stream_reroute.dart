import 'package:bento_arena/controller.dart';
import 'package:bento_arena/stream/function/stream_status.dart';
import 'package:bento_arena/stream/waitlist.dart';
import 'package:flutter/material.dart';

class StreamReroute extends StatefulWidget {
  const StreamReroute({super.key});

  @override
  State<StreamReroute> createState() => _StreamRerouteState();
}

class _StreamRerouteState extends State<StreamReroute> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    re_route();
  }

  Future<void> re_route() async{
    print('re-routing page based on stream live status');
    bool stream_status = await obtain_stream_status();
    if(stream_status == true){
      await Future.delayed(Duration(seconds: 2));
      Navigator.push(context, MaterialPageRoute(builder: (context) => ControllerPage()));
    }
    else{
      Navigator.push(context, MaterialPageRoute(builder: (context) => Waitlist()));
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Image.network('https://media0.giphy.com/media/4lvkZzTznfGbdnsI0C/giphy.webp?cid=790b76111z1i3of0ezfqbdbe1tgd3fv469ewc391gqgyp57x&ep=v1_gifs_search&rid=giphy.webp&ct=g')),
    );

  }
}
