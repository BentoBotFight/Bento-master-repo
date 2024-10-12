import 'package:firebase_database/firebase_database.dart';

void listenToDatabase() {
  // Get a reference to the database
  final DatabaseReference databaseRef = FirebaseDatabase.instance.ref();

  // Specify the path to the data you want to listen to
  final DatabaseReference dataRef = databaseRef.child('your/data/path');

  // Set up a listener for changes
  dataRef.onValue.listen((DatabaseEvent event) {
    // This callback will be triggered whenever the data changes
    final dynamic data = event.snapshot.value;

    if (data != null) {
      print('Data changed: $data');
    } else {
      print('No data available');
    }
  }, onError: (error) {
    print('Error: $error');
  });
}
