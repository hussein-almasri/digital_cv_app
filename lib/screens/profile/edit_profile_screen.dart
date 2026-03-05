import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/auth_provider.dart';
import '../../services/firestore_service.dart';

class EditProfileScreen extends StatefulWidget {

  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {

  final nameController = TextEditingController();
  final bioController = TextEditingController();

  final firestore = FirestoreService();

  @override
  Widget build(BuildContext context) {

    final auth = Provider.of<AuthProvider>(context);
    final userId = auth.user?.uid ?? "";
    final email = auth.user?.email ?? "";

    return Scaffold(

      appBar: AppBar(
        title: const Text("Edit Profile"),
      ),

      body: Padding(

        padding: const EdgeInsets.all(20),

        child: Column(

          children: [

            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                hintText: "Name",
              ),
            ),

            const SizedBox(height: 16),

            TextField(
              controller: bioController,
              decoration: const InputDecoration(
                hintText: "Bio",
              ),
            ),

            const SizedBox(height: 30),

            ElevatedButton(

              onPressed: () async {

                await firestore.saveUserProfile(
                  userId,
                  nameController.text,
                  email,
                  bioController.text,
                );

                Navigator.pop(context);

              },

              child: const Text("Save"),

            )

          ],
        ),
      ),
    );
  }
}