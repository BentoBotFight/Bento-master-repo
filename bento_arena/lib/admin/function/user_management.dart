import 'package:firebase_database/firebase_database.dart';

FirebaseDatabase database = FirebaseDatabase.instance;
DatabaseReference user_presence_status = database.ref('status');

void display_user(){
  user_presence_status.onValue.listen((event){
    final data = event.snapshot.value;
    print(data);
  });
}

Stream<dynamic> display_user_stream() async*{
  yield user_presence_status.onValue;
}