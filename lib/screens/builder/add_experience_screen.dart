import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/resume_provider.dart';
import '../../providers/auth_provider.dart';

class AddExperienceScreen extends StatefulWidget {

  const AddExperienceScreen({super.key});

  @override
  State<AddExperienceScreen> createState() => _AddExperienceScreenState();
}

class _AddExperienceScreenState extends State<AddExperienceScreen> {

  final jobController = TextEditingController();
  final companyController = TextEditingController();
  final descController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    final resumeProvider = Provider.of<ResumeProvider>(context);
    final auth = Provider.of<AuthProvider>(context);

    final userId = auth.user?.uid ?? "";

    return Scaffold(

      appBar: AppBar(
        title: const Text("Add Experience"),
      ),

      body: Padding(

        padding: const EdgeInsets.all(20),

        child: Column(

          children: [

            TextField(
              controller: jobController,
              decoration: const InputDecoration(
                hintText: "Job Title",
              ),
            ),

            const SizedBox(height: 16),

            TextField(
              controller: companyController,
              decoration: const InputDecoration(
                hintText: "Company",
              ),
            ),

            const SizedBox(height: 16),

            TextField(
              controller: descController,
              decoration: const InputDecoration(
                hintText: "Description",
              ),
            ),

            const SizedBox(height: 30),

            ElevatedButton(

              onPressed: () {

                resumeProvider.addExperience(
                  userId,
                  jobController.text,
                  companyController.text,
                  descController.text,
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