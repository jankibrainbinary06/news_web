import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class ImageFromFirebaseStorage extends StatefulWidget {
  @override
  _ImageFromFirebaseStorageState createState() =>
      _ImageFromFirebaseStorageState();
}

class _ImageFromFirebaseStorageState extends State<ImageFromFirebaseStorage> {
  final FirebaseStorage storage = FirebaseStorage.instance;
  String? imageUrl; // This will store the image URL once retrieved.

  @override
  void initState() {
    super.initState();
    getImageFromFirebaseStorage();
  }

  Future<void> getImageFromFirebaseStorage() async {
    try {
      final Reference ref = storage.ref().child(
          'NewsImage/3Rvtw7tW8tUgBxNlRylo.png'); // Replace 'your_image.jpg' with your image's path.
      final String downloadUrl = await ref.getDownloadURL();
      setState(() {
        imageUrl = downloadUrl;
      });
    } catch (e) {
      print('Error retrieving image: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Firebase Storage Image'),
      ),
      body: Center(
        child: imageUrl == null
            ? CircularProgressIndicator() // Show a loading indicator while fetching the image.
            : Image.network(
                imageUrl!), // Display the image using Image.network.
      ),
    );
  }
}
