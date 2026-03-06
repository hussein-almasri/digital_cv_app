import 'dart:io';

import 'package:digital_cv_app/screens/profile/edit_profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../../providers/auth_provider.dart';
import '../../services/firestore_service.dart';
import '../../screens/auth/login_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  final picker = ImagePicker();

  Future<void> pickImage(String userId) async {

    final pickedFile =
        await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile == null) return;

    File file = File(pickedFile.path);

    // رفع الصورة إلى Firebase Storage
    final ref = FirebaseStorage.instance
        .ref()
        .child("profile_images")
        .child("$userId.jpg");

    await ref.putFile(file);

    final imageUrl = await ref.getDownloadURL();

    // حفظ الرابط في Firestore
    await FirestoreService().updateProfileImage(userId, imageUrl);

  }

  @override
  Widget build(BuildContext context) {

    final auth = Provider.of<AuthProvider>(context);
    final userId = auth.user?.uid ?? "";

    final firestore = FirestoreService();

    return Scaffold(

      appBar: AppBar(
        title: const Text("Profile"),
      ),

      body: StreamBuilder(

        stream: firestore.getUser(userId),

        builder: (context, snapshot) {

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData) {
            return const Center(
              child: Text("No profile data yet"),
            );
          }

          final doc = snapshot.data!;

          if (!doc.exists) {
            return const Center(
              child: Text("No profile created yet"),
            );
          }

          final data = doc.data() as Map<String, dynamic>?;

          if (data == null) {
            return const Center(
              child: Text("Profile is empty"),
            );
          }

          final avatar =
              data["avatar"] ??
              "https://i.pravatar.cc/300";

          return Padding(

            padding: const EdgeInsets.all(20),

            child: Column(

              children: [

                GestureDetector(

                  onTap: () {
                    pickImage(userId);
                  },

                  child: CircleAvatar(

                    radius: 50,

                    backgroundImage: NetworkImage(avatar),

                  ),

                ),

                const SizedBox(height: 10),

                const Text(
                  "Tap image to change",
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                ),

                const SizedBox(height: 20),

                Text(
                  data["name"] ?? "No Name",
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 6),

                Text(
                  data["email"] ?? "",
                  style: const TextStyle(
                    color: Colors.grey,
                  ),
                ),

                const SizedBox(height: 20),

                Card(
                  child: ListTile(

                    leading: const Icon(Icons.edit),

                    title: const Text("Edit Profile"),

                    onTap: () {

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const EditProfileScreen(),
                        ),
                      );

                    },
                  ),
                ),

                Card(
                  child: ListTile(

                    leading: const Icon(Icons.logout),

                    title: const Text("Logout"),

                    onTap: () async {

                      await auth.logout();

                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const LoginScreen(),
                        ),
                        (route) => false,
                      );

                    },
                  ),
                ),

              ],
            ),
          );
        },
      ),
    );
  }
}