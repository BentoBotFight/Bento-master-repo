import 'package:flutter/material.dart';
import 'package:livekit_client/livekit_client.dart';

class LiveStreamingApp extends StatefulWidget {
  @override
  _LiveStreamingAppState createState() => _LiveStreamingAppState();
}

class _LiveStreamingAppState extends State<LiveStreamingApp> {
  Room? _room;
  LocalVideoTrack? _localVideoTrack;
  bool _isCameraOn = false;
  bool _isMicOn = false;

  @override
  void initState() {
    super.initState();
    _connectToRoom();
  }

  Future<void> _connectToRoom() async {
    final room = Room();

    try {
      await room.connect(
        'wss://bento-fights-t9pojnsj.livekit.cloud',
        'your-token',
        roomOptions: RoomOptions(
          adaptiveStream: true,
          dynacast: true,
        ),
      );

      setState(() {
        _room = room;
      });
    } catch (error) {
      print('Failed to connect to room: $error');
    }
  }

  Future<void> _toggleCamera() async {
    if (_isCameraOn) {
      await _room?.localParticipant?.setCameraEnabled(false);
    } else {
      _localVideoTrack = await LocalVideoTrack.createCameraTrack();
      await _room?.localParticipant?.publishVideoTrack(_localVideoTrack!);
    }

    setState(() {
      _isCameraOn = !_isCameraOn;
    });
  }

  Future<void> _toggleMicrophone() async {
    if (_isMicOn) {
      await _room?.localParticipant?.setMicrophoneEnabled(false);
    } else {
      await _room?.localParticipant?.setMicrophoneEnabled(true);
    }

    setState(() {
      _isMicOn = !_isMicOn;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: _room != null
          ? Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (_isCameraOn && _localVideoTrack != null)
            Container(
              width: 200,
              height: 200,
              child: VideoTrackRenderer(_localVideoTrack!),
            ),
          SizedBox(height: 20),
          Text('Connected to room: ${_room!.name}'),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: _toggleCamera,
                child: Text(_isCameraOn ? 'Turn Off Camera' : 'Turn On Camera'),
              ),
              SizedBox(width: 20),
              ElevatedButton(
                onPressed: _toggleMicrophone,
                child: Text(_isMicOn ? 'Turn Off Mic' : 'Turn On Mic'),
              ),
            ],
          ),
        ],
      )
          : CircularProgressIndicator(),
    );
  }

  @override
  void dispose() {
    _room?.disconnect();
    super.dispose();
  }
}