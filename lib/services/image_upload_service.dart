import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';

class ImageUploadService {

  final FirebaseStorage storage = FirebaseStorage.instance;

  Future<String> uploadProfileImage(File file, String userId) async {

    final ref = storage.ref().child("profile_images/$userId.jpg");

    await ref.putFile(file);

    final url = await ref.getDownloadURL();

    return url;
  }

}