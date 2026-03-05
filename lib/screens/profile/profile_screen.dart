import 'package:digital_cv_app/screens/profile/edit_profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/auth_provider.dart';
import '../../services/firestore_service.dart';
import '../../screens/auth/login_screen.dart';

class ProfileScreen extends StatelessWidget {

  const ProfileScreen({super.key});

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

        builder: (context, snapshot){

          if(!snapshot.hasData){
            return const Center(child: CircularProgressIndicator());
          }

          final data = snapshot.data!.data() as Map<String, dynamic>;
          
          return Padding(

            padding: const EdgeInsets.all(20),

            child: Column(

              children: [

                const CircleAvatar(
                  radius: 50,
                  backgroundImage: NetworkImage(
                    "https://i.pravatar.cc/300",
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