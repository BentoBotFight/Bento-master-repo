import 'package:cloud_firestore/cloud_firestore.dart';

var db = FirebaseFirestore.instance;

Future<String> get_user_name(String email) async {
  try {
    // Get the document directly using the email as the document ID
    DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
        .collection('user_information')
        .doc(email)
        .get();

    // Check if the document exists
    if (documentSnapshot.exists) {
      print('Document found for $email');

      // Check if the document contains the 'name' field
      if (documentSnapshot.data() != null &&
          (documentSnapshot.data() as Map<String, dynamic>).containsKey('name')) {
        // Return the name
        print(documentSnapshot.get('name').toString());
        return documentSnapshot.get('name') as String;
      } else {
        return 'name not found';
        throw Exception('Name field not found in the document');
      }
    } else {
      return 'user not found with this email';
      throw Exception('No user found with the provided email');
    }
  } catch (e) {
    // Handle any errors that occurred during the process
    print('Error retrieving user name: $e');
    rethrow;
  }
}