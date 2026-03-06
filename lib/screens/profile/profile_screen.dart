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

  Future<Map<String, dynamic>> loadProfile(String userId, String email) async {

    final doc = await FirestoreService().getUser(userId).first;

    if (!doc.exists) {

      String name = email.split("@")[0];

      await FirestoreService().saveUserProfile(
        userId,
        name,
        email,
        "",
      );

      return {
        "name": name,
        "email": email,
        "bio": "",
        "avatar": ""
      };
    }

    return doc.data() as Map<String, dynamic>;
  }

  Future<void> pickImage(String userId) async {

    final pickedFile =
        await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile == null) return;

    File file = File(pickedFile.path);

    final ref = FirebaseStorage.instance
        .ref()
        .child("profile_images")
        .child("$userId.jpg");

    await ref.putFile(file);

    final imageUrl = await ref.getDownloadURL();

    await FirestoreService().updateProfileImage(userId, imageUrl);

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {

    final auth = Provider.of<AuthProvider>(context);
    final userId = auth.user?.uid ?? "";
    final email = auth.user?.email ?? "";

    return Scaffold(

      appBar: AppBar(
        title: const Text("Profile"),
      ),

      body: FutureBuilder(

        future: loadProfile(userId, email),

        builder: (context, snapshot) {

          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          final data = snapshot.data as Map<String, dynamic>;

          final avatar = data["avatar"];

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

                    backgroundColor: Colors.grey.shade300,

                    backgroundImage:
                        avatar != null && avatar != ""
                            ? NetworkImage(avatar)
                            : null,

                    child: avatar == null || avatar == ""
                        ? const Icon(
                            Icons.person,
                            size: 40,
                            color: Colors.white,
                          )
                        : null,

                  ),

                ),

                const SizedBox(height: 10),

                const Text(
                  "Tap image to change",
                  style: TextStyle(color: Colors.grey),
                ),

                const SizedBox(height: 20),

                Text(
                  data["name"] ?? "User",
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